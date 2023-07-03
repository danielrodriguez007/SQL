USE NORTHWIND

******************************************************************************************************************************************************************************************
SELECT TOP 10 * FROM DBO.CUSTOMERS

SELECT
FIRSTNAME+' '+LASTNAME CONTACT_NAME, ADDRESS, CITY FROM EMPLOYEES
UNION
SELECT CONTACTNAME, ADDRESS, CITY FROM CUSTOMERS
******************************************************************************************************************************************************************************************
UPDATE CUSTOMERS
SET REGION = 'EASTERN EUROPE'
WHERE COUNTRY LIKE 'G%'

SELECT * FROM CUSTOMERS
WHERE COUNTRY LIKE 'G%'

******************************************************************************************************************************************************************************************
--CAST VARIABLES TO DIFFERENT TYPES
DECLARE @SAMPLETEXT AS VARCHAR(10);
SET @SAMPLETEXT = '123456';

DECLARE @REALDATE AS VARCHAR(10);
SET @REALDATE = '13/09/2023';

SELECT TRY_CONVERT(INT,@SAMPLETEXT);
SELECT TRY_CONVERT(DATETIME,@SAMPLETEXT);
SELECT TRY_CONVERT(DATE,@REALDATE,111);
SELECT TRY_CAST(@REALDATE AS DATE)

DECLARE @A VARCHAR(2)--DON'T FORGET PUT THE TYPE OF THE VARIABLE TO CREATE
DECLARE @B VARCHAR(2)
SET @A = '2'
SET @B = '4'
SELECT CAST(@A AS INT) + CAST(@B AS INT) AS RESULT
SELECT CONVERT(VARCHAR(20),GETDATE(),108)

--OFFSET SHOWS ROWS THAT CONTINUES AFTER THE NUMBER
SELECT * FROM CUSTOMERS
ORDER BY CUSTOMERID
OFFSET 50 ROWS

DECLARE @WW INT
SET @WW = 17
SELECT @WW AS V1, @WW+2 AS V2, 'NULL' AS V3

--PRACTICE FOR NULL 
SELECT
CITY,COUNTRY,ISNULL(REGION,'SIN REGION')
FROM CUSTOMERS
WHERE REGION IS NULL
ORDER BY COUNTRY

--REMEMBER THE TABLE OF CODES TO GET THE SPECIFIC FORMAT OF DATE
SELECT CONVERT(VARCHAR(30),GETDATE(),100) AS CURRENTDATE

--REMEMBER THE FORMAT'S ARGUMENT
DECLARE @TODAY DATETIME = GETDATE()
SELECT FORMAT(@TODAY,N'F')

DECLARE @BDAY DATETIME='2023/02/22'
SELECT FORMAT(DATEADD(YEAR,1,@BDAY),N'F')

DECLARE @BDAY DATETIME='1989/02/22'
SELECT DATEDIFF(YEAR,@BDAY,GETDATE()) AS YEARSOLD

--COALESCE EXAMPLE

SELECT
CONTACTNAME,
COALESCE(PHONE,FAX) AS CONTACT_NUMBER
FROM CUSTOMERS

-- VIEW WITH ENCRYPTION

CREATE VIEW VIEW_ENCRYP
WITH ENCRYPTION
AS
	SELECT * FROM CUSTOMERS
SELECT * FROM VIEW_ENCRYP

SELECT
CITY,COUNT(CUSTOMERID) Q_COUNTRIES
FROM CUSTOMERS
GROUP BY CITY
HAVING COUNT(CUSTOMERID) >1
ORDER BY Q_COUNTRIES DESC

CREATE TABLE #TEMP_ORDERS(
	COMPANYNAME VARCHAR(100),
	SELLER VARCHAR(50),
	POSITION VARCHAR(200),
	Q_ORDERS INT
)

INSERT INTO #TEMP_ORDERS
	SELECT
	C.COMPANYNAME,
	CONCAT(E.FIRSTNAME,' ',E.LASTNAME) SELLER,
	E.TITLE POSITION,
	COUNT(O.ORDERID) Q_ORDERS
	FROM ORDERS O
	JOIN EMPLOYEES E
	ON
	O.EmployeeID = E.EmployeeID
	JOIN CUSTOMERS C
	ON
	O.CustomerID = C.CustomerID
	GROUP BY E.FIRSTNAME,E.LASTNAME,E.TITLE,C.COMPANYNAME

SELECT
SELLER, SUM(Q_ORDERS) TOTAL_ORDERS,
CASE
	WHEN SUM(Q_ORDERS) > 100 THEN 'BONIFICATION 100%'
	WHEN SUM(Q_ORDERS) > 70 AND SUM(Q_ORDERS) < 101 THEN 'BONIFICATION 70%'
	WHEN SUM(Q_ORDERS) > 50 AND SUM(Q_ORDERS) < 71 THEN 'BONIFICATION 50%'
	ELSE 'WITHOUT BONIFICATION'
END BONIFICATION 
FROM #TEMP_ORDERS
GROUP BY SELLER
ORDER BY TOTAL_ORDERS

-- ACUMULATIVE SUM

CREATE TABLE #TEMP_STOCKPRICES(
	PRODUCTNAME VARCHAR(150),
	TOTALSTOCK INT
)

INSERT INTO #TEMP_STOCKPRICES
	SELECT
	PRODUCTNAME,
	SUM(UNITPRICE*UNITSINSTOCK) TOTALSTOCK
	FROM PRODUCTS
	GROUP BY PRODUCTNAME

SELECT
*,
DENSE_RANK() OVER(PARTITION BY TOTALSTOCK ORDER BY PRODUCTNAME)
FROM #TEMP_STOCKPRICES

--PRACTICE OVER()

SELECT
O.CUSTOMERID,
OD.UNITPRICE,
OD.QUANTITY,
OD.DISCOUNT,
(OD.UNITPRICE*OD.QUANTITY)-OD.DISCOUNT TOTALORDER,
SUM((OD.UNITPRICE*OD.QUANTITY)-OD.DISCOUNT) OVER(PARTITION BY O.CUSTOMERID ORDER BY O.CUSTOMERID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TOTALBILL,
AVG((OD.UNITPRICE*OD.QUANTITY)-OD.DISCOUNT) OVER(PARTITION BY O.CUSTOMERID ORDER BY O.CUSTOMERID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AVERANGE,
COUNT((OD.UNITPRICE*OD.QUANTITY)-OD.DISCOUNT) OVER(PARTITION BY O.CUSTOMERID ORDER BY O.CUSTOMERID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) COUNTORDERS,
MAX((OD.UNITPRICE*OD.QUANTITY)-OD.DISCOUNT) OVER(PARTITION BY O.CUSTOMERID ) MAXORDER,
MIN((OD.UNITPRICE*OD.QUANTITY)-OD.DISCOUNT) OVER(PARTITION BY O.CUSTOMERID ) MINORDER
FROM
ORDERS O
LEFT JOIN [ORDER DETAILS]OD
ON
O.ORDERID = OD.ORDERID

-- STUFF WITH XML

SELECT
DISTINCT SUPPLIERID,
STUFF ((
	SELECT
	','+ PRODUCTNAME	
	FROM PRODUCTS B
	WHERE A.SUPPLIERID = B.SUPPLIERID
	FOR XML PATH('')),
	1,1,'') PRODUCTS
FROM PRODUCTS A
GROUP BY SUPPLIERID
------
------
DROP TABLE IF EXISTS #TEMP_SALESMAN;

CREATE TABLE #TEMP_SALESMAN(
	EMPLOYEEID INT,
	EMPLOYEENAME VARCHAR(100),
	COMPANYNAME VARCHAR(100)
)

INSERT INTO #TEMP_SALESMAN
	SELECT
	E.EMPLOYEEID,
	E.FIRSTNAME + ' ' + LASTNAME,
	C.COMPANYNAME
	FROM CUSTOMERS C
	JOIN ORDERS O
	ON
	C.CUSTOMERID = O.CUSTOMERID
	JOIN EMPLOYEES E
	ON
	E.EMPLOYEEID = O.EMPLOYEEID

SELECT
DISTINCT EMPLOYEENAME
STUFF((
	SELECT
	','+ COMPANYNAME
	FROM #TEMP_SALESMAN B
	WHERE A.EMPLOYEEID = B.EMPLOYEEID
	FOR XML PATH('')),
	1,1,'') CLIENTS
FROM #TEMP_SALESMAN A

SELECT 
DISTINCT COUNTRY
STUFF(
	(
	SELECT ','+ COMPANYNAME
	FROM CUSTOMERS B
	WHERE A.CUSTOMERID = B.CUSTOMERID
	FOR XML PATH(''))
	,1,1,'') COMPANIES
FROM CUSTOMERS A

-- SELF/INNER JOIN EARN MORE THAT THEIR MANAGERS

ALTER TABLE EMPLOYEES
ADD Salaries INT NULL

UPDATE EMPLOYEES
SET SALARIES = 4321
WHERE EMPLOYEEID =9

SELECT
A.EMPLOYEEID,
A.SALARIES,
A.REPORTSTO
FROM EMPLOYEES A
LEFT JOIN EMPLOYEES B
ON
A.REPORTSTO = B.EMPLOYEEID
WHERE A.SALARIES > B.SALARIES

******************************************************************************************************************************************************************************************

USE NORTHWIND
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM [EMPLOYEES];
SELECT * FROM FN_VIRTUALSERVERNODES()
--PAGE 115