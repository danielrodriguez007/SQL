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
USE interview;
SHOW TABLES;
SELECT * FROM USERS;
SELECT * FROM TRIPS;