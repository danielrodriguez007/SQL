DROP TABLE IF EXISTS tienda;
CREATE DATABASE tienda;
USE tienda;


CREATE TABLE fabricante(
	codigo int UNSIGNED auto_increment PRIMARY KEY,
    nombre varchar(100)
);

CREATE TABLE producto(
	codigo int auto_increment PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    precio double NOT NULL,
    codigoFabricante int UNSIGNED NOT NULL,
    FOREIGN KEY (codigoFabricante) REFERENCES fabricante(codigo)    
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- EXERCICES FROM https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html


-- 1.1.3 CONSULTA SOBRE UNA TABLA

SELECT nombre from producto; -- 1.Lista el nombre de todos los productos que hay en la tabla producto.

SELECT nombre, precio from producto; -- 2.Lista los nombres y los precios de todos los productos de la tabla producto.

SELECT * FROM producto; -- 3.Lista todas las columnas de la tabla producto.

SELECT nombre,
CONCAT ('$', precio) as DOLAR,
CONCAT ('€', precio) as EUROS
FROM producto; -- 4 & 5.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.

SELECT UPPER(nombre) as NOMBRE from producto; -- 6.Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.

SELECT LOWER(nombre) as nombre, precio FROM producto;-- 7.Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.

SELECT nombre , CONCAT(UPPER(SUBSTRING(nombre,1,2)), LOWER(SUBSTRING(nombre,3))) as FAbricante FROM fabricante; -- 8.Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.

SELECT nombre, precio, ROUND(precio, 0) as PrecioRedondeado from producto; -- 9 & 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.

SELECT producto.codigoFabricante FROM producto
INNER JOIN fabricante
WHERE  producto.codigo=fabricante.codigo
ORDER BY producto.codigoFabricante ASC; -- 11.Lista el identificador de los fabricantes que tienen productos en la tabla producto.

SELECT DISTINCT producto.codigoFabricante FROM producto
INNER JOIN fabricante
WHERE fabricante.codigo = producto.codigo
ORDER BY producto.codigoFabricante ASC; -- 12.Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.

SELECT nombre FROM fabricante
ORDER BY nombre ASC; -- 13.Lista los nombres de los fabricantes ordenados de forma ascendente.

SELECT nombre FROM fabricante
ORDER BY nombre DESC; -- 14.Lista los nombres de los fabricantes ordenados de forma descendente.

SELECT * FROM producto
ORDER BY nombre ASC , precio DESC; -- 15.Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.

SELECT * FROM fabricante
LIMIT 5; -- 16.Devuelve una lista con las 5 primeras filas de la tabla fabricante.

SELECT * FROM fabricante
WHERE codigo BETWEEN 4 AND 9; -- 17.Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.

SELECT nombre, precio FROM producto
ORDER BY precio
LIMIT 1;-- 18.Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)

SELECT nombre, precio FROM producto
ORDER BY precio DESC
LIMIT 1; -- 19.Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)

SELECT * FROM producto
WHERE codigoFabricante = 2; -- 20.Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.

SELECT nombre, CONCAT('€', precio) as precio FROM producto 
WHERE precio <= 120
ORDER BY precio DESC;-- 21.Lista el nombre de los productos que tienen un precio menor o igual a 120€.

SELECT nombre , CONCAT('€', precio) as precio FROM producto
WHERE precio >= 400
ORDER BY precio ASC;-- 22.Lista el nombre de los productos que tienen un precio mayor o igual a 400€.

SELECT nombre , CONCAT('€', precio) as precio FROM producto
WHERE precio <400
ORDER BY precio ASC;-- 23.Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.

SELECT nombre, CONCAT('€', precio) as precio FROM producto
WHERE precio >=80 AND precio <=300
ORDER BY precio DESC;-- 24.Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.

SELECT nombre, CONCAT('€', precio) as precio FROM producto
WHERE precio BETWEEN 60 and 200;-- 25.Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.

SELECT nombre , CONCAT('€',precio) as precio, codigoFabricante FROM producto
WHERE precio >200 AND codigoFabricante = 6;-- 26.Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.

SELECT nombre, codigoFabricante FROM producto
WHERE codigoFabricante = 1 OR codigoFabricante = 3 OR codigoFabricante = 5;-- 27.Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.

SELECT nombre, codigoFabricante FROM producto
WHERE codigoFabricante IN(1,3,5);-- 28.Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.

SELECT nombre, precio, precio/100 as centimos FROM producto;-- 29.Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos

SELECT nombre FROM fabricante
WHERE nombre LIKE('S%');-- 30.Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.

SELECT nombre FROM fabricante
WHERE nombre LIKE('%e');-- 31.Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.

SELECT nombre FROM fabricante
WHERE nombre LIKE('%w%');-- 32.Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.

SELECT nombre FROM fabricante
WHERE LENGTH(nombre) = 4; -- 33.Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.

SELECT nombre FROM producto
WHERE nombre LIKE('%Portátil%');-- 34.Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.

SELECT nombre, CONCAT('€', precio) as precio FROM producto
WHERE nombre LIKE('%Monitor%') AND precio <215;-- 35.Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.

SELECT nombre, CONCAT('€', precio) AS precio FROM producto
WHERE precio >=180
ORDER BY precio DESC , nombre ASC;-- 36.Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).

-- 1.1.4 CONSULTAS MULTITABLA (COMPOSICION INTERNA)

SELECT * FROM fabricante
ORDER BY precio;

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo; -- 1.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;-- 2.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.

SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo;-- 3.Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.

SELECT producto.nombre, producto.precio , fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
ORDER BY producto.precio
LIMIT 1;-- 4.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.

SELECT producto.nombre,  producto.precio, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
ORDER BY producto.precio DESC
LIMIT 1;-- 5.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.

SELECT producto.nombre, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';-- 6.Devuelve una lista de todos los productos del fabricante Lenovo.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;-- 7.Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.

SELECT producto.nombre, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR  fabricante.nombre = 'Seagate';-- 8.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.

SELECT producto.nombre, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard','Seagate');-- 9.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
WHERE fabricante.nombre LIKE('%e');-- 10.Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
WHERE fabricante.nombre LIKE('%w%');-- 11.Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
LEFT JOIN fabricante
ON producto.codigoFabricante = fabricante.codigo
WHERE producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;-- 12.Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)

SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigoFabricante;-- 13.Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.


-- 1.1.5 Consultas multitabla (Composición externa)

SELECT fabricante.nombre as nombreFabricante, producto.nombre as nombreProducto FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigoFabricante
ORDER BY fabricante.nombre;-- 1.Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociado


SELECT DISTINCT fabricante.nombre as nombreFabricante, producto.nombre FROM fabricante
LEFT JOIN producto
ON fabricante.codigo = producto.codigoFabricante
ORDER BY producto.nombre ASC
LIMIT 2;-- 2.Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.






















