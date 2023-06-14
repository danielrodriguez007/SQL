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
DECLARE @SAMPLETEXT AS VARCHAR(10);
SET @SAMPLETEXT = '123456';

DECLARE @REALDATE AS VARCHAR(10);
SET @REALDATE = '13/09/2023';

SELECT TRY_CONVERT(INT,@SAMPLETEXT);
SELECT TRY_CONVERT(DATETIME,@SAMPLETEXT);
SELECT TRY_CONVERT(DATE,@REALDATE,111);
SELECT TRY_CAST(@REALDATE AS DATE)
******************************************************************************************************************************************************************************************

USE NORTHWIND
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM CUSTOMERS;
SELECT * FROM FN_VIRTUALSERVERNODES()
--PAGE 29