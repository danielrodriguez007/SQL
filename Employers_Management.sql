DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DOUBLE UNSIGNED NOT NULL,
    gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(9) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    id_departamento INT UNSIGNED,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)    
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);


SELECT * FROM departamento;
SELECT * FROM empleado;

-- 1.2.3 Consultas sobre una tabla

SELECT * FROM empleado
WHERE id = 1;-- 1.Lista el primer apellido de todos los empleados.

SELECT apellido1,COUNT(apellido1) as cantApellido FROM empleado
WHERE id = 1
GROUP By apellido1
HAVING cantApellido = 1;-- 2. Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.

SELECT * FROM empleado;-- 3.Lista todas las columnas de la tabla empleado.

SELECT nombre, apellido1, apellido2 FROM empleado;-- 4.Lista el nombre y los apellidos de todos los empleados.

SELECT departamento.nombre FROM departamento
LEFT JOIN empleado
ON departamento.id = empleado.id_departamento;-- 5.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.

SELECT DISTINCT(departamento.nombre) FROM departamento
LEFT JOIN empleado
ON departamento.id=empleado.id_departamento;-- 6.Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos

SELECT CONCAT(COALESCE(nombre, ''),COALESCE(apellido1, ''),COALESCE(apellido2, '')) AS nombreCompleto FROM empleado;-- 7.Lista el nombre y apellidos de los empleados en una única columna.

SELECT UPPER(CONCAT(COALESCE(nombre, ''), COALESCE(apellido1, ''), COALESCE(apellido2, ''))) AS nombreCompleto FROM empleado;-- 8.Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.

SELECT LOWER(CONCAT(COALESCE(nombre, ''), COALESCE(apellido1, ''), COALESCE(apellido2, ''))) AS nombreCompleto FROM empleado;-- 9.Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.

SELECT id, REGEXP_SUBSTR(nif, '^[0-9]+') AS nifNumbers, REGEXP_SUBSTR(nif,'[A-Z]') AS nifLetters FROM empleado;-- 10.Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.

SELECT CONCAT(presupuesto-gastos) AS presupuestoActual FROM departamento;-- 11.Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando.

SELECT nombre, CONCAT(presupuesto-gastos) AS presupuestoActual FROM departamento
ORDER BY presupuestoActual ASC;-- 12.Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.

SELECT nombre FROM departamento
ORDER BY nombre ASC;-- 13.Lista el nombre de todos los departamentos ordenados de forma ascendente.

SELECT nombre FROM departamento
ORDER BY nombre DESC;-- 14.Lista el nombre de todos los departamentos ordenados de forma desscendente.

SELECT nombre, apellido1, apellido2 FROM empleado
ORDER BY apellido1 ASC, nombre ASC;-- 15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.

SELECT nombre, presupuesto FROM departamento
ORDER BY presupuesto DESC
LIMIT 3;-- 16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.

SELECT nombre, presupuesto FROM departamento
ORDER BY presupuesto ASC
LIMIT 3;-- 17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.

SELECT nombre, gastos FROM departamento
ORDER BY gastos DESC
LIMIT 2;-- 18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.

SELECT nombre, gastos FROM departamento
ORDER BY gastos ASC
LIMIT 2;-- 19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.

SELECT * FROM empleado
LIMIT 2,5;-- 20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado
