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

SELECT * FROM reminders;
SHOW tables;
SHOW PROCEDURE STATUS;
USE mysqltutorialorg;