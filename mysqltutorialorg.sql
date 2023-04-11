CREATE DATABASE mysqltutorialorg  CHARACTER SET utf8mb4;
DROP IF EXISTS WorkCenters;
CREATE TABLE WorkCenters(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

DROP TABLE IF EXISTS WorkCenterStats;
CREATE TABLE WorkCenterStats(
    totalCapacity INT NOT NULL
);

DROP TABLE IF EXISTS members;
CREATE TABLE members(
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS reminders;
CREATE TABLE reminders(
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, memberId)
);

---------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER before_workcenters_insert
BEFORE INSERT
ON WorkCenters FOR EACH ROW
BEGIN
    DECLARE rowcount INT;

    SELECT COUNT(*)
    INTO rowcount
    FROM WorkCenterStats;

    IF rowcount > 0 THEN
        UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + new.capacity;
    ELSE
        INSERT INTO WorkCenterStats(totalCapacity)
        VALUES(new.capacity);
    END IF;
END$$
DELIMITER;

INSERT INTO WorkCenters(name, capacity)
VALUES('Packing', 300);
---------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId,message)
        VALUES(new.id,CONCAT('Hi ',NEW.name,',Please update your date of birth'));
    END IF;
END$$
DELIMITER;

INSERT INTO members(name,email,birthDate)
VALUES
    ('John Doe', 'john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');

---------------------------------------------------------------------------------------------------------------------------------
#MySQL BEFORE DELETE TRIGGER EXAMPLE

DROP TABLE IF EXISTS Salaries;
CREATE TABLE Salaries(
    employeeNumber INT PRIMARY KEY,
    validFrom DATE NOT NULL,
    amout DEC (12,2) NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS SalaryArchives;
CREATE TABLE SalaryArchives(
    id INT PRIMARY KEY AUTO_INCREMENT,
    employeeNumber INT ,
    validFrom DATE NOT NULL,
    amout DEC (12,2) NOT NULL DEFAULT 0,
    deletedAt TIMESTAMP DEFAULT NOW()
);

INSERT INTO Salaries(employeeNumber,validFrom,amout)
VALUES
    (1002,'2000-01-01',50000),
    (1056,'2000-01-01',60000),
    (1076,'2000-01-01',70000);

DELIMITER $$

CREATE TRIGGER before_salaries_delete
BEFORE DELETE
ON Salaries FOR EACH ROW
BEGIN
    INSERT INTO SalaryArchives(employeeNumber,validFrom,amout)
    VALUES(OLD.employeeNumber,OLD.validFrom,OLD.amout);
END$$
DELIMITER;   

DELETE FROM salaries
WHERE employeeNumber = 1002;
---------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM SalaryArchives;
SHOW tables;
SHOW PROCEDURE STATUS;
USE mysqltutorialorg;