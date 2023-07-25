DROP DATABASE IF EXISTS interview;
CREATE DATABASE interview CHARACTER SET utf8mb4;

USE interview;

CREATE TABLE BANKTRANSACTIONS(
    AccountNumber INT,
    AccountHolderName VARCHAR(255),
    TransactionDate DATE,
    TransactionType VARCHAR(255),
    TransactionAmount DECIMAL(10,2)
);

INSERT INTO BANKTRANSACTIONS (AccountNumber, AccountHolderName, TransactionDate, TransactionType, TransactionAmount)
VALUES
  (1001, 'Ravi Sharma', '2023-07-01', 'Deposit', 5000),
  (1001, 'Ravi Sharma', '2023-07-05', 'Withdrawal', 1000),
  (1001, 'Ravi Sharma', '2023-07-10', 'Deposit', 2000),
  (1002, 'Priya Gupta', '2023-07-02', 'Deposit', 3000),
  (1002, 'Priya Gupta', '2023-07-08', 'Withdrawal', 500),
  (1003, 'Vikram Patel', '2023-07-04', 'Deposit', 10000),
  (1003, 'Vikram Patel', '2023-07-09', 'Withdrawal', 2000);


CREATE TABLE Trips(
  ID INT,
  CLIENTE_ID INT,
  DRIVER_ID INT,
  CITY_ID INT,
  STATUS VARCHAR(20),
  REQUEST_AT DATE
);

CREATE TABLE USERS(
  USER_ID INT,
  BANNED VARCHAR(3),
  ROLE VARCHAR(10)
);

INSERT INTO TRIPS (ID,CLIENTE_ID,DRIVER_ID,CITY_ID,STATUS,REQUEST_AT)
VALUES
    (1, 1, 10, 1, 'completed', '2023-07-12'),
    (2, 2, 11, 1, 'cancelled_by_driver', '2023-07-12'),
    (3, 3, 12, 6, 'completed', '2023-07-12'),
    (4, 4, 13, 6, 'cancelled_by_client', '2023-07-12'),
    (5, 1, 10, 1, 'completed', '2023-07-13'),
    (6, 2, 11, 6, 'completed', '2023-07-13'),
    (7, 3, 12, 6, 'completed', '2023-07-13'),
    (8, 2, 12, 12, 'completed', '2023-07-14'),
    (9, 3, 10, 12, 'completed', '2023-07-14'),
    (10, 4, 13, 12, 'cancelled_by_driver', '2023-07-14');

INSERT INTO USERS (USER_ID, BANNED, ROLE)
VALUES
    (1, 'No', 'client'),
    (2, 'Yes', 'client'),
    (3, 'No', 'client'),
    (4, 'No', 'client'),
    (10, 'No', 'driver'),
    (11, 'No', 'driver'),
    (12, 'No', 'driver'),
    (13, 'No', 'driver');    

CREATE TEMPORARY TABLE TEMP_DEPOSIT(
    AccountNumber INT,
    AccountHolderName VARCHAR(255),
    TransactionDate DATE,
    TransactionType VARCHAR(255),
    TransactionAmount DECIMAL(10,2)
);

INSERT INTO TEMP_DEPOSIT 
SELECT * FROM BANKTRANSACTIONS
WHERE TRANSACTIONTYPE LIKE 'Deposit'
;

CREATE TABLE SALES(
  CUSTOMERID INT,
  PRODUCTID CHAR(1),
  PURCHASEDATE DATE,
  QUANTITY INT,
  REVENUE DECIMAL(10,2)
);

INSERT INTO SALES 
VALUES
    (1, 'A', '2023-01-01', 5, 100),
    (2, 'B', '2023-01-02', 3, 50),
    (3, 'A', '2023-01-03', 2, 30),
    (4, 'C', '2023-01-03', 1, 20),
    (1, 'B', '2023-01-04', 4, 80);

CREATE TABLE Names (
  Name VARCHAR(100)
);

INSERT INTO Names (Name)
VALUES ('rAVI kUMAR'), ('priya sharma'), ('amit PATEL'), ('NEHA gupta'); 

CREATE TABLE USER(
  USER_ID INT,
  NAME VARCHAR(50),
  EMAIL VARCHAR(100)
);

CREATE TABLE ACTIVITYLOG(
  LOG_ID INT,
  USER_ID INT,
  ACTIVITY_TYPE VARCHAR(50),
  TIMESTAMP DATETIME
);

INSERT INTO User (user_id, name, email)
VALUES
  (1, 'Rahul', 'rahul@example.com'),
  (2, 'Priya', 'priya@example.com'),
  (3, 'Amit', 'amit@example.com'),
  (4, 'Sneha', 'sneha@example.com'),
  (5, 'Gaurav', 'gaurav@example.com'),
  (6, 'Anika', 'anika@example.com');

INSERT INTO ActivityLog (log_id, user_id, activity_type, timestamp)
VALUES
  (1, 1, 'login', '2023-06-10 09:00:00'),
  (2, 1, 'search', '2023-06-10 09:15:00'),
  (3, 2, 'login', '2023-06-10 10:00:00'),
  (4, 3, 'login', '2023-06-11 11:00:00'),
  (5, 1, 'purchase', '2023-06-12 14:30:00'),
  (6, 2, 'search', '2023-06-15 16:45:00'),
  (7, 1, 'logout', '2023-06-18 20:00:00'),
  (8, 1, 'login', '2023-01-15 10:30:00'),
  (9, 2, 'search', '2023-02-05 14:45:00'),
  (10, 3, 'purchase', '2023-03-20 09:15:00'),
  (11, 1, 'search', '2023-04-10 16:30:00'),
  (12, 2, 'login', '2023-05-05 11:45:00'),
  (13, 3, 'search', '2023-06-15 08:30:00');

 CREATE TABLE PRODUCTS(
  PRODUCTID INT PRIMARY KEY,
  PRODUCTNAME VARCHAR(50),
  PRICE DECIMAL(10,2)
 );

 CREATE TABLE ORDERS(
  ORDERID INT PRIMARY KEY,
  PRODUCTID INT,
  QUANTITY INT,
  SALES DECIMAL(10.2)
 );

 INSERT INTO Products (productID, productName, price) VALUES
  (1, 'Apple', 2.5),
  (2, 'Banana', 1.5),
  (3, 'Orange', 3.0),
  (4, 'Mango', 2.0);

 INSERT INTO Orders (orderID, productID, quantity, sales) VALUES
  (1, 1, 10, 25.0),
  (2, 1, 5, 12.5),
  (3, 2, 8, 12.0),
  (4, 3, 12, 36.0),
  (5, 4, 6, 12.0); 
---------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM TEMP_DEPOSIT;

SELECT
A.ACCOUNTNUMBER,
A.ACCOUNTHOLDERNAME,
(SUM(B.TRANSACTIONAMOUNT)-A.TRANSACTIONAMOUNT) ACCOUNTSUMMARY
FROM BANKTRANSACTIONS A
RIGHT JOIN TEMP_DEPOSIT B 
ON A.ACCOUNTNUMBER = B.ACCOUNTNUMBER
WHERE A.TRANSACTIONTYPE LIKE 'WITHDRAWAL'
GROUP BY A.ACCOUNTNUMBER;

---------------------------------------------------------------------------------------------------------------------------------------
WITH CANCELLED AS(
 SELECT
 ID,
 REQUEST_AT,
 COUNT(STATUS) CANCELLED
 FROM TRIPS
 WHERE STATUS LIKE 'CANCELLED%'
 GROUP BY REQUEST_AT
)
SELECT
B.REQUEST_AT,
COUNT(B.STATUS) TOTAL_TRIPS,
A.CANCELLED,
CASE 
  WHEN (A.CANCELLED/COUNT(B.STATUS))*100 IS NULL THEN 0
  ELSE  (A.CANCELLED/COUNT(B.STATUS))*100
END RATE
FROM CANCELLED A
RIGHT JOIN TRIPS B
ON 
A.REQUEST_AT = B.REQUEST_AT
GROUP BY B.REQUEST_AT;
---------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM SALES;

#CALCULATE TOTAL REVENUE
SELECT SUM(REVENUE) TOTAL_REVENUE FROM SALES;

#CALCULATE TOTAL SALES BY PRODUCT
SELECT
PRODUCTID,
SUM(QUANTITY) TOTALQUANTITY,
SUM(REVENUE) TOTAL_REVENUE
FROM SALES
GROUP BY PRODUCTID;

#FIND TOP CUSTOMERS BY REVENUE
SELECT
CUSTOMERID,
SUM(REVENUE) TOTAL_REVENUE
FROM SALES
GROUP BY CUSTOMERID;
---------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM NAMES;

SELECT LOWER(NAME) FROM NAMES;
SELECT UPPER(NAME) FROM NAMES;
---------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM USER;
SELECT * FROM ACTIVITYLOG;


SELECT
A.*,
B.ACTIVITY_TYPE, 
B.TIMESTAMP
FROM USER A
INNER JOIN ACTIVITYLOG B 
ON 
A.USER_ID=B.USER_ID
WHERE B.TIMESTAMP >= DATE_SUB(CURRENT_DATE(),INTERVAL 30 DAY)
ORDER BY USER_ID;

---------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM ORDERS;

SELECT * FROM PRODUCTS;

SELECT 
A.PRODUCTNAME,
SUM(A.PRICE*B.QUANTITY) TOTALREVENUE
FROM PRODUCTS A
INNER JOIN ORDERS B
ON
A.PRODUCTID = B.PRODUCTID
GROUP BY A.PRODUCTNAME
ORDER BY TOTALREVENUE DESC;

---------------------------------------------------------------------------------------------------------------------------------------
USE interview;
SHOW TABLES;
SELECT * FROM USERS;
SELECT * FROM TRIPS;