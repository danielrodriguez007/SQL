USE Sales_Production;

CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go

-- create tables
CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);
**************************************************************************************************************************
CREATE TABLE #TEMP_AGES(
	ID INT,
	PRODUCT_NAME VARCHAR(150),
	MODEL_YEAR INT,
	NOW INT,
	EXPIRATION_YEAR INT,
	PRODUCT_AGE INT
)

INSERT INTO #TEMP_AGES
	SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	MODEL_YEAR,YEAR(CONVERT(DATE,GETDATE())) AS NOW,
	CASE
		WHEN MODEL_YEAR = 2016 THEN MODEL_YEAR+5
		WHEN MODEL_YEAR = 2017  THEN MODEL_YEAR+6
		WHEN MODEL_YEAR = 2018 THEN MODEL_YEAR+7
		ELSE MODEL_YEAR+8
	END AS EXPIRATION_YEAR,
	YEAR(CONVERT(DATE,GETDATE()))-MODEL_YEAR AS PRODUCT_AGE
	FROM PRODUCTION.PRODUCTS
	
SELECT * FROM #TEMP_AGES
**************************************************************************************************************************
WITH GROUP_PRODUCT AS (
	SELECT
	A.MODEL_YEAR,
	STUFF(
		(SELECT A.PRODUCT_NAME +' '
		 FROM #TEMP_AGES
		 WHERE PRODUCT_NAME = A.PRODUCT_NAME
		 FOR XML PATH(''))
		 ,1,0,'') AS PRODUCTS
	FROM #TEMP_AGES A
)

SELECT * FROM GROUP_PRODUCT
GROUP BY MODEL_YEAR;
**************************************************************************************************************************
WITH PRICE_RANKED AS(
	SELECT
	PRODUCT_NAME, LIST_PRICE,MODEL_YEAR,
	DENSE_RANK() OVER(PARTITION BY MODEL_YEAR ORDER BY LIST_PRICE) AS RANKING
	FROM PRODUCTION.PRODUCTS
)

SELECT * FROM PRICE_RANKED
WHERE RANKING LIKE '2'
;
**************************************************************************************************************************
CREATE TABLE #TEMP_STOCK(
	PRODUCT_NAME VARCHAR(200),
	BRAND_NAME VARCHAR(100),
	CATEGORY_NAME VARCHAR(150),
	STOCK VARCHAR(5)
)

INSERT INTO #TEMP_STOCK
	SELECT
		P.PRODUCT_NAME,
		B.BRAND_NAME,
		C.CATEGORY_NAME,
		S.QUANTITY 
	FROM PRODUCTION.PRODUCTS P
	JOIN PRODUCTION.BRANDS B
	ON P.BRAND_ID = B.BRAND_ID
	JOIN PRODUCTION.CATEGORIES C
	ON P.CATEGORY_ID = C.CATEGORY_ID
	LEFT JOIN PRODUCTION.STOCKS S
	ON P.PRODUCT_ID = S.PRODUCT_ID
	ORDER BY B.BRAND_NAME

SELECT * FROM #TEMP_STOCK
WHERE CATEGORY_NAME LIKE 'MOUNTAIN%' AND STOCK < 20
ORDER BY BRAND_NAME
**************************************************************************************************************************
CREATE TABLE #TEMP_PRICE(
	PRODUCT_NAME VARCHAR(200),
	BRAND_NAME VARCHAR(100),
	CATEGORY_NAME VARCHAR(150),
	PRICE decimal(10, 2)
)

DROP TABLE #TEMP_PRICE

INSERT INTO #TEMP_PRICE
	SELECT
		P.PRODUCT_NAME,
		B.BRAND_NAME,
		C.CATEGORY_NAME,
		P.LIST_PRICE
	FROM PRODUCTION.PRODUCTS P
	JOIN PRODUCTION.BRANDS B
	ON P.BRAND_ID = B.BRAND_ID
	JOIN PRODUCTION.CATEGORIES C
	ON P.CATEGORY_ID = C.CATEGORY_ID
	ORDER BY B.BRAND_NAME

SELECT
BRAND_NAME,
AVG(PRICE) AS AVERANGE_PRICE,
SUM(PRICE) AS SUM_PRICE
FROM #TEMP_PRICE
GROUP BY BRAND_NAME
**************************************************************************************************************************
CREATE TABLE #TEMP_ORDERS(
	CUSTOMER_ID INT,
	Q_ORDERS INT
)

INSERT INTO #TEMP_ORDERS
	SELECT
	C.CUSTOMER_ID,
	COUNT(O.ORDER_ID) AS Q_ORDERS
	FROM SALES.CUSTOMERS C
	LEFT JOIN SALES.ORDERS O
	ON
	C.CUSTOMER_ID = O.CUSTOMER_ID
	GROUP BY C.CUSTOMER_ID

SELECT
T.CUSTOMER_ID,
CONCAT (SC.FIRST_NAME,' ',SC.LAST_NAME) AS CUSTOMER_NAME,
T.Q_ORDERS,
CONCAT (SS.FIRST_NAME,' ',SS.LAST_NAME) AS SALESMAN_NAME,
SS.EMAIL
FROM #TEMP_ORDERS T
JOIN SALES.CUSTOMERS SC
ON
T.CUSTOMER_ID = SC.CUSTOMER_ID
JOIN SALES.ORDERS SO
ON
SC.CUSTOMER_ID = SO.CUSTOMER_ID
JOIN SALES.STAFFS SS
ON
SO.STAFF_ID = SS.STAFF_ID
ORDER BY T.Q_ORDERS
**************************************************************************************************************************



SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM PRODUCTION.PRODUCTS
SELECT * FROM SALES.STAFFS;


