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
USE interview;
SELECT * FROM BANKTRANSACTIONS;