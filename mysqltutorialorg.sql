CREATE DATABASE mysqltutorialorg  CHARACTER SET utf8mb4;
CREATE DATABASE;
--------------------------------------------------------------------------------------------------------------------------------
# https://www.mysqltutorial.org/wp-content/uploads/2017/06/mysql-adjacency-list.png --->image of the Tree;
DROP TABLE IF EXISTS category ;

CREATE TABLE category(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    parent_id INT(10) UNSIGNED DEFAULT NULL,
    PRIMARY KEY(id),
    Foreign Key (parent_id) REFERENCES category (id)
     on delete CASCADE on update CASCADE
);

INSERT INTO category(title,parent_id) 
VALUES('Electronics',NULL);
INSERT INTO category(title,parent_id) 
VALUES('Laptops & PC',1);

INSERT INTO category(title,parent_id) 
VALUES('Laptops',2);
INSERT INTO category(title,parent_id) 
VALUES('PC',2);

INSERT INTO category(title,parent_id) 
VALUES('Cameras & photo',1);
INSERT INTO category(title,parent_id) 
VALUES('Camera',5);

INSERT INTO category(title,parent_id) 
VALUES('Phones & Accessories',1);
INSERT INTO category(title,parent_id) 
VALUES('Smartphones',7);

INSERT INTO category(title,parent_id) 
VALUES('Android',8);
INSERT INTO category(title,parent_id) 
VALUES('iOS',8);
INSERT INTO category(title,parent_id) 
VALUES('Other Smartphones',8);
INSERT INTO category(title,parent_id) 
VALUES('Batteries',7);
INSERT INTO category(title,parent_id) 
VALUES('Headsets',7);
INSERT INTO category(title,parent_id) 
VALUES('Screen Protectors',7);

SELECT * FROM category
ORDER BY parent_id;
SELECT
    id,title
FROM
    category
WHERE
    parent_id = 1;

SELECT c1.title FROM category c1
LEFT JOIN category c2
ON c2.parent_id = c1.id
WHERE c2.id IS NULL;

WITH RECURSIVE category_path (id, title, path) AS
(
  SELECT id, title, title as path
    FROM category
    WHERE parent_id IS NULL
  UNION ALL
  SELECT c.id, c.title, CONCAT(cp.path, ' > ', c.title)
    FROM category_path AS cp JOIN category AS c
      ON cp.id = c.parent_id
)
SELECT * FROM category_path
ORDER BY path;



--------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts(
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(255) NOT NULL
);

INSERT INTO contacts (first_name, last_name, email)
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net'),
       ('Jean','King','jean.king@me.com'),
       ('Peter','Ferguson','peter.ferguson@google.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com'),
       ('Julie','Murphy','julie.murphy@yahoo.com'),
       ('Kwai','Lee','kwai.lee@google.com'),
       ('Jean','King','jean.king@me.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com');

SELECT email, count(email) as countEmail FROM contacts
GROUP BY email
HAVING countEmail > 1;

DELETE c1 FROM contacts c1
INNER JOIN contacts c2
WHERE c1.id > c2.id AND c1.email = c2.email;

SELECT @id:= LAST_INSERT_ID();

SELECT * FROM contacts
WHERE first_name REGEXP '^J';

--------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM products;

WITH inventory
AS (
  SELECT
    productName, productLine, quantityInStock,
    ROW_NUMBER() OVER (
      PARTITION BY productLine
      ORDER BY quantityInStock DESC) rowCount
  FROM products  
)
SELECT * FROM inventory
WHERE rowCount <= 10; 

--------------------------------------------------------------------------------------------------------------------------------


SHOW FULL TABLES;
SHOW PROCESSLIST;
SELECT * FROM employees;
USE mysqltutorialorg;