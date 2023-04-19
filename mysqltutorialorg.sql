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


SHOW FULL TABLES;
SHOW PROCESSLIST;
USE mysqltutorialorg;