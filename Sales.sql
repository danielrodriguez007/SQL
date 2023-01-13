DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;

CREATE TABLE cliente(
      id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(100) NOT NULL,
      apellido1 VARCHAR(100) NOT NULL,
      apellido2 VARCHAR(100),
      ciudad VARCHAR(100),
      categoria INT UNSIGNED 
);

CREATE TABLE comercial(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    comision FLOAT
);

CREATE TABLE pedido(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    total DOUBLE NOT NULL, 
    fecha DATE,
    id_cliente INT UNSIGNED NOT NULL,
    id_comercial INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    Foreign Key (id_comercial) REFERENCES comercial(id)
);



INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

-- 1.3.3 Consultas sobre una tabla

SELECT * FROM pedido
ORDER BY fecha DESC;-- 1.Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.

SELECT * FROM pedido
ORDER BY total DESC
LIMIT 2;-- 2.Devuelve todos los datos de los dos pedidos de mayor valor.

SELECT DISTINCT id_cliente FROM pedido;-- 3.Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.

SELECT * FROM pedido
WHERE fecha BETWEEN '2017-01-01' AND '2017-12-31'  AND total >500;;-- 4.Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€

SELECT * FROM comercial
WHERE comision BETWEEN 0.05 AND 0.11;-- 5.Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.

SELECT MAX(comision) FROM comercial;-- 6.Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.

SELECT id, nombre, apellido1, apellido2 FROM cliente
WHERE apellido2 IS NOT NULL;-- 7.Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. El listado deberá estar ordenado alfabéticamente por apellidos y nombre.

SELECT * FROM cliente
WHERE nombre LIKE'a%' AND nombre LIKE '%n' OR nombre LIKE 'p%' ;--8.Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticament

SELECT *  FROM cliente
WHERE nombre NOT LIKE 'a%'
ORDER BY nombre;-- 9.Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.

SELECT DISTINCT nombre FROM comercial
WHERE nombre LIKE '%o';-- 10.Devuelve un listado con los nombres de los comerciales que terminan por el o o. Tenga en cuenta que se deberán eliminar los nombres repetido

-- 1.3.4 Consultas multitabla (Composición interna)

SELECT id, nombre, apellido1, apellido2 FROM cliente
WHERE id IN(SELECT id_cliente FROM pedido);-- 1.Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.

SELECT pedido.*, cliente.* FROM pedido
INNER JOIN cliente
ON pedido.id_cliente = cliente.id 
ORDER BY cliente.nombre;-- 2.Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.

SELECT comercial.*,pedido.* FROM comercial
INNER JOIN pedido
ON comercial.id = pedido.id_comercial
ORDER BY comercial.nombre;-- 3.Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente

SELECT * FROM comercial
JOIN pedido
ON comercial.id = pedido.id_comercial
JOIN cliente
ON cliente.id = pedido.id_cliente;-- 4.Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.

SELECT *  FROM cliente
INNER JOIN pedido
ON cliente.id = pedido.id_cliente
WHERE pedido.fecha BETWEEN '2017-01-01' AND '2017-12-31' AND pedido.total BETWEEN 300 AND 1000; -- 5.Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.

SELECT comercial.nombre, comercial.apellido1, comercial.apellido2 FROM comercial
JOIN pedido
ON comercial.id = pedido.id_comercial
JOIN cliente
ON cliente.id = pedido.id_cliente
WHERE pedido.id_cliente = 6;-- 6.Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno

SELECT cliente.nombre, cliente.apellido1, cliente.apellido2 FROM cliente
JOIN pedido
ON cliente.id = pedido.id_cliente
JOIN comercial
ON comercial.id = pedido.id_comercial
WHERE comercial.id = 1;-- 7.Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.

-- 1.3.5 Consultas multitabla (Composición externa)

SELECT cliente.*, pedido.* FROM cliente
LEFT JOIN pedido
ON cliente.id = pedido.id_cliente;-- 1.Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.

SELECT comercial.*, pedido.* FROM comercial
LEFT JOIN pedido
ON comercial.id = pedido.id_comercial;-- 2.Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. Este listado también debe incluir los comerciales que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.

SELECT cliente.*, pedido.* FROM cliente
RIGHT JOIN pedido
ON cliente.id = pedido.id_cliente
ORDER BY cliente.id;-- 3.Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.

SELECT comercial.*, pedido.* FROM comercial
LEFT JOIN pedido
ON comercial.id = pedido.id_comercial
WHERE pedido.id IS NULL;-- 4.Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.

SELECT * FROM cliente
RIGHT JOIN pedido
ON cliente.id = pedido.id_cliente
RIGHT JOIN comercial
ON comercial.id = pedido.id_comercial
WHERE pedido.id IS NULL;--5.Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.

--1.3.6 Consultas resumen

SELECT COUNT(id) AS cantidadPedidos FROM pedido;--1.Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.

SELECT AVG(id) FROM pedido;--2.Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido

SELECT COUNT(DISTINCT id_comercial) FROM pedido;--3.Calcula el número total de comerciales distintos que aparecen en la tabla pedido.

SELECT COUNT(id) FROM cliente;--4.Calcula el número total de clientes que aparecen en la tabla cliente.

SELECT * FROM pedido
WHERE total = (SELECT MAX(total) FROM pedido);--5.Calcula cuál es la mayor cantidad que aparece en la tabla pedido.

SELECT MIN(total) FROM pedido;--6.Calcula cuál es la menor cantidad que aparece en la tabla pedido.

SELECT ciudad, MAX(categoria) FROM cliente
WHERE categoria = ANY(SELECT categoria FROM cliente)
GROUP BY ciudad;--7.Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.

