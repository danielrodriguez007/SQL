use university;


CREATE TABLE departamento (
    id INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE persona (
    id INT IDENTITY PRIMARY KEY,
    nif VARCHAR(9) UNIQUE,
    nombre VARCHAR(25) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    ciudad VARCHAR(25) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(9),
    fecha_nacimiento DATE NOT NULL,
    sexo VARCHAR(1) NOT NULL,
    tipo VARCHAR(11) NOT NULL
);
 
CREATE TABLE profesor (
    id_profesor INT IDENTITY PRIMARY KEY,
    id_departamento INT  NOT NULL,
    FOREIGN KEY (id_profesor) REFERENCES persona(id),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);
 
 CREATE TABLE grado (
    id INT IDENTITY  PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
 
CREATE TABLE asignatura (
    id INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos FLOAT  NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    curso TINYINT NOT NULL,
    cuatrimestre TINYINT  NOT NULL,
    id_profesor INT ,
    id_grado INT NOT NULL,
    FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor),
    FOREIGN KEY(id_grado) REFERENCES grado(id)
);
 
CREATE TABLE curso_escolar (
    id INT IDENTITY PRIMARY KEY,
    anyo_inicio VARCHAR(5) NOT NULL,
    anyo_fin VARCHAR(5) NOT NULL
);

CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno INT IDENTITY NOT NULL,
    id_asignatura INT  NOT NULL,
    id_curso_escolar INT  NOT NULL,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    FOREIGN KEY (id_alumno) REFERENCES persona(id),
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
    FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);

/* Departamento */
INSERT INTO [dbo].[departamento] VALUES
(1, 'Inform�tica'),
(2, 'Matem�ticas'),
(3, 'Econom�a y Empresa'),
(4, 'Educaci�n'),
(5, 'Agronom�a'),
(6, 'Qu�mica y F�sica'),
(7, 'Filolog�a'),
(8, 'Derecho'),
(9, 'Biolog�a y Geolog�a');

 
 /* Persona */
INSERT INTO [dbo].[persona] VALUES
(1,'26902806M', 'Salvador', 'S�nchez', 'P�rez', 'Almer�a', 'C/ Real del barrio alto', '950254837', '1991/03/28', 'H', 'alumno'),
(2, '89542419S', 'Juan', 'Saez', 'Vega', 'Almer�a', 'C/ Mercurio', '618253876', '1992/08/08', 'H', 'alumno'),
(3, '11105554G', 'Zoe', 'Ramirez', 'Gea', 'Almer�a', 'C/ Marte', '618223876', '1979/08/19', 'M', 'profesor'),
(4, '17105885A', 'Pedro', 'Heller', 'Pagac', 'Almer�a', 'C/ Estrella fugaz', NULL, '2000/10/05', 'H', 'alumno'),
(5, '38223286T', 'David', 'Schmidt', 'Fisher', 'Almer�a', 'C/ Venus', '678516294', '1978/01/19', 'H', 'profesor'),
(6, '04233869Y', 'Jos�', 'Koss', 'Bayer', 'Almer�a', 'C/ J�piter', '628349590', '1998/01/28', 'H', 'alumno'),
(7, '97258166K', 'Ismael', 'Strosin', 'Turcotte', 'Almer�a', 'C/ Neptuno', NULL, '1999/05/24', 'H', 'alumno'),
(8, '79503962T', 'Cristina', 'Lemke', 'Rutherford', 'Almer�a', 'C/ Saturno', '669162534', '1977/08/21', 'M', 'profesor'),
(9, '82842571K', 'Ram�n', 'Herzog', 'Tremblay', 'Almer�a', 'C/ Urano', '626351429', '1996/11/21', 'H', 'alumno'),
(10, '61142000L', 'Esther', 'Spencer', 'Lakin', 'Almer�a', 'C/ Plut�n', NULL, '1977/05/19', 'M', 'profesor'),
(11, '46900725E', 'Daniel', 'Herman', 'Pacocha', 'Almer�a', 'C/ Andarax', '679837625', '1997/04/26', 'H', 'alumno'),
(12, '85366986W', 'Carmen', 'Streich', 'Hirthe', 'Almer�a', 'C/ Almanzora', NULL, '1971-04-29', 'M', 'profesor'),
(13, '73571384L', 'Alfredo', 'Stiedemann', 'Morissette', 'Almer�a', 'C/ Guadalquivir', '950896725', '1980/02/01', 'H', 'profesor'),
(14, '82937751G', 'Manolo', 'Hamill', 'Kozey', 'Almer�a', 'C/ Duero', '950263514', '1977/01/02', 'H', 'profesor'),
(15, '80502866Z', 'Alejandro', 'Kohler', 'Schoen', 'Almer�a', 'C/ Tajo', '668726354', '1980/03/14', 'H', 'profesor'),
(16, '10485008K', 'Antonio', 'Fahey', 'Considine', 'Almer�a', 'C/ Sierra de los Filabres', NULL, '1982/03/18', 'H', 'profesor'),
(17, '85869555K', 'Guillermo', 'Ruecker', 'Upton', 'Almer�a', 'C/ Sierra de G�dor', NULL, '1973/05/05', 'H', 'profesor'),
(18, '04326833G', 'Micaela', 'Monahan', 'Murray', 'Almer�a', 'C/ Veleta', '662765413', '1976/02/25', 'H', 'profesor'),
(19, '11578526G', 'Inma', 'Lakin', 'Yundt', 'Almer�a', 'C/ Picos de Europa', '678652431', '1998/09/01', 'M', 'alumno'),
(20, '79221403L', 'Francesca', 'Schowalter', 'Muller', 'Almer�a', 'C/ Quinto pino', NULL, '1980/10/31', 'H', 'profesor'),
(21, '79089577Y', 'Juan', 'Guti�rrez', 'L�pez', 'Almer�a', 'C/ Los pinos', '678652431', '1998/01/01', 'H', 'alumno'),
(22, '41491230N', 'Antonio', 'Dom�nguez', 'Guerrero', 'Almer�a', 'C/ Cabo de Gata', '626652498', '1999/02/11', 'H', 'alumno'),
(23, '64753215G', 'Irene', 'Hern�ndez', 'Mart�nez', 'Almer�a', 'C/ Zapillo', '628452384', '1996/03/12', 'M', 'alumno'),
(24, '85135690V', 'Sonia', 'Gea', 'Ruiz', 'Almer�a', 'C/ Mercurio', '678812017', '1995/04/13', 'M', 'alumno');
 
/* Profesor */
INSERT INTO profesor VALUES (3, 1);
INSERT INTO profesor VALUES (5, 2);
INSERT INTO profesor VALUES (8, 3);
INSERT INTO profesor VALUES (10, 4);
INSERT INTO profesor VALUES (12, 4);
INSERT INTO profesor VALUES (13, 6);
INSERT INTO profesor VALUES (14, 1);
INSERT INTO profesor VALUES (15, 2);
INSERT INTO profesor VALUES (16, 3);
INSERT INTO profesor VALUES (17, 4);
INSERT INTO profesor VALUES (18, 5);
INSERT INTO profesor VALUES (20, 6);
 
 /* Grado */
INSERT INTO grado VALUES (1, 'Grado en Ingenier�a Agr�cola (Plan 2015)');
INSERT INTO grado VALUES (2, 'Grado en Ingenier�a El�ctrica (Plan 2014)');
INSERT INTO grado VALUES (3, 'Grado en Ingenier�a Electr�nica Industrial (Plan 2010)');
INSERT INTO grado VALUES (4, 'Grado en Ingenier�a Inform�tica (Plan 2015)');
INSERT INTO grado VALUES (5, 'Grado en Ingenier�a Mec�nica (Plan 2010)');
INSERT INTO grado VALUES (6, 'Grado en Ingenier�a Qu�mica Industrial (Plan 2010)');
INSERT INTO grado VALUES (7, 'Grado en Biotecnolog�a (Plan 2015)');
INSERT INTO grado VALUES (8, 'Grado en Ciencias Ambientales (Plan 2009)');
INSERT INTO grado VALUES (9, 'Grado en Matem�ticas (Plan 2010)');
INSERT INTO grado VALUES (10, 'Grado en Qu�mica (Plan 2009)');
 
/* Asignatura */
INSERT INTO asignatura VALUES (1, '�lgegra lineal y matem�tica discreta', 6, 'b�sica', 1, 1, 3, 4);
INSERT INTO asignatura VALUES (2, 'C�lculo', 6, 'b�sica', 1, 1, 14, 4);
INSERT INTO asignatura VALUES (3, 'F�sica para inform�tica', 6, 'b�sica', 1, 1, 3, 4);
INSERT INTO asignatura VALUES (4, 'Introducci�n a la programaci�n', 6, 'b�sica', 1, 1, 14, 4);
INSERT INTO asignatura VALUES (5, 'Organizaci�n y gesti�n de empresas', 6, 'b�sica', 1, 1, 3, 4);
INSERT INTO asignatura VALUES (6, 'Estad�stica', 6, 'b�sica', 1, 2, 14, 4);
INSERT INTO asignatura VALUES (7, 'Estructura y tecnolog�a de computadores', 6, 'b�sica', 1, 2, 3, 4);
INSERT INTO asignatura VALUES (8, 'Fundamentos de electr�nica', 6, 'b�sica', 1, 2, 14, 4);
INSERT INTO asignatura VALUES (9, 'L�gica y algor�tmica', 6, 'b�sica', 1, 2, 3, 4);
INSERT INTO asignatura VALUES (10, 'Metodolog�a de la programaci�n', 6, 'b�sica', 1, 2, 14, 4);
INSERT INTO asignatura VALUES (11, 'Arquitectura de Computadores', 6, 'b�sica', 2, 1, 3, 4);
INSERT INTO asignatura VALUES (12, 'Estructura de Datos y Algoritmos I', 6, 'obligatoria', 2, 1, 3, 4);
INSERT INTO asignatura VALUES (13, 'Ingenier�a del Software', 6, 'obligatoria', 2, 1, 14, 4);
INSERT INTO asignatura VALUES (14, 'Sistemas Inteligentes', 6, 'obligatoria', 2, 1, 3, 4);
INSERT INTO asignatura VALUES (15, 'Sistemas Operativos', 6, 'obligatoria', 2, 1, 14, 4);
INSERT INTO asignatura VALUES (16, 'Bases de Datos', 6, 'b�sica', 2, 2, 14, 4);
INSERT INTO asignatura VALUES (17, 'Estructura de Datos y Algoritmos II', 6, 'obligatoria', 2, 2, 14, 4);
INSERT INTO asignatura VALUES (18, 'Fundamentos de Redes de Computadores', 6 ,'obligatoria', 2, 2, 3, 4);
INSERT INTO asignatura VALUES (19, 'Planificaci�n y Gesti�n de Proyectos Inform�ticos', 6, 'obligatoria', 2, 2, 3, 4);
INSERT INTO asignatura VALUES (20, 'Programaci�n de Servicios Software', 6, 'obligatoria', 2, 2, 14, 4);
INSERT INTO asignatura VALUES (21, 'Desarrollo de interfaces de usuario', 6, 'obligatoria', 3, 1, 14, 4);
INSERT INTO asignatura VALUES (22, 'Ingenier�a de Requisitos', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (23, 'Integraci�n de las Tecnolog�as de la Informaci�n en las Organizaciones', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (24, 'Modelado y Dise�o del Software 1', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (25, 'Multiprocesadores', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (26, 'Seguridad y cumplimiento normativo', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (27, 'Sistema de Informaci�n para las Organizaciones', 6, 'optativa', 3, 1, NULL, 4); 
INSERT INTO asignatura VALUES (28, 'Tecnolog�as web', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (29, 'Teor�a de c�digos y criptograf�a', 6, 'optativa', 3, 1, NULL, 4);
INSERT INTO asignatura VALUES (30, 'Administraci�n de bases de datos', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (31, 'Herramientas y M�todos de Ingenier�a del Software', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (32, 'Inform�tica industrial y rob�tica', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (33, 'Ingenier�a de Sistemas de Informaci�n', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (34, 'Modelado y Dise�o del Software 2', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (35, 'Negocio Electr�nico', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (36, 'Perif�ricos e interfaces', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (37, 'Sistemas de tiempo real', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (38, 'Tecnolog�as de acceso a red', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (39, 'Tratamiento digital de im�genes', 6, 'optativa', 3, 2, NULL, 4);
INSERT INTO asignatura VALUES (40, 'Administraci�n de redes y sistemas operativos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (41, 'Almacenes de Datos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (42, 'Fiabilidad y Gesti�n de Riesgos', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (43, 'L�neas de Productos Software', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (44, 'Procesos de Ingenier�a del Software 1', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (45, 'Tecnolog�as multimedia', 6, 'optativa', 4, 1, NULL, 4);
INSERT INTO asignatura VALUES (46, 'An�lisis y planificaci�n de las TI', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (47, 'Desarrollo R�pido de Aplicaciones', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (48, 'Gesti�n de la Calidad y de la Innovaci�n Tecnol�gica', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (49, 'Inteligencia del Negocio', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (50, 'Procesos de Ingenier�a del Software 2', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (51, 'Seguridad Inform�tica', 6, 'optativa', 4, 2, NULL, 4);
INSERT INTO asignatura VALUES (52, 'Biologia celular', 6, 'b�sica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (53, 'F�sica', 6, 'b�sica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (54, 'Matem�ticas I', 6, 'b�sica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (55, 'Qu�mica general', 6, 'b�sica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (56, 'Qu�mica org�nica', 6, 'b�sica', 1, 1, NULL, 7);
INSERT INTO asignatura VALUES (57, 'Biolog�a vegetal y animal', 6, 'b�sica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (58, 'Bioqu�mica', 6, 'b�sica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (59, 'Gen�tica', 6, 'b�sica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (60, 'Matem�ticas II', 6, 'b�sica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (61, 'Microbiolog�a', 6, 'b�sica', 1, 2, NULL, 7);
INSERT INTO asignatura VALUES (62, 'Bot�nica agr�cola', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (63, 'Fisiolog�a vegetal', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (64, 'Gen�tica molecular', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (65, 'Ingenier�a bioqu�mica', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (66, 'Termodin�mica y cin�tica qu�mica aplicada', 6, 'obligatoria', 2, 1, NULL, 7);
INSERT INTO asignatura VALUES (67, 'Biorreactores', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (68, 'Biotecnolog�a microbiana', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (69, 'Ingenier�a gen�tica', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (70, 'Inmunolog�a', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (71, 'Virolog�a', 6, 'obligatoria', 2, 2, NULL, 7);
INSERT INTO asignatura VALUES (72, 'Bases moleculares del desarrollo vegetal', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (73, 'Fisiolog�a animal', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (74, 'Metabolismo y bios�ntesis de biomol�culas', 6, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (75, 'Operaciones de separaci�n', 6, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (76, 'Patolog�a molecular de plantas', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (77, 'T�cnicas instrumentales b�sicas', 4.5, 'obligatoria', 3, 1, NULL, 7);
INSERT INTO asignatura VALUES (78, 'Bioinform�tica', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (79, 'Biotecnolog�a de los productos hortofrut�culas', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (80, 'Biotecnolog�a vegetal', 6, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (81, 'Gen�mica y prote�mica', 4.5, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (82, 'Procesos biotecnol�gicos', 6, 'obligatoria', 3, 2, NULL, 7);
INSERT INTO asignatura VALUES (83, 'T�cnicas instrumentales avanzadas', 4.5, 'obligatoria', 3, 2, NULL, 7);

/* Curso escolar */
INSERT INTO curso_escolar VALUES (1, 2014, 2015);
INSERT INTO curso_escolar VALUES (2, 2015, 2016);
INSERT INTO curso_escolar VALUES (3, 2016, 2017);
INSERT INTO curso_escolar VALUES (4, 2017, 2018);
INSERT INTO curso_escolar VALUES (5, 2018, 2019);

/* Alumno se matricula en asignatura */
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (1, 3, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (2, 3, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 1, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 2, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (4, 3, 1);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 1, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 2, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 3, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 4, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 5, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 6, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 7, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 8, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 9, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (24, 10, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 1, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 2, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 3, 5);
INSERT INTO alumno_se_matricula_asignatura VALUES (23, 4, 5);

*********************************************************************************************************************************************************************************************************************
SELECT CONCAT(P.NOMBRE,' ', P.APELLIDO1,' ',P.APELLIDO2) AS NOMBRE, PR.ID_PROFESOR AS ID_PROFESOR, D.NOMBRE AS DEPARTAMENTO
FROM PERSONA P
INNER JOIN PROFESOR PR
ON P.ID = PR.ID_PROFESOR
INNER JOIN DEPARTAMENTO D
ON  PR.ID_DEPARTAMENTO = D.ID;
*********************************************************************************************************************************************************************************************************************
WITH A�OS AS (
SELECT ANYO_INICIO, ANYO_FIN,DATEDIFF(YEAR,ANYO_INICIO, ANYO_FIN) AS CANT_A�OS,
CASE
	WHEN ANYO_INICIO=2014 THEN 'IT�S 2014'
	WHEN ANYO_INICIO=2015 THEN 'INCREDIBLE 20-15'
	WHEN ANYO_INICIO=2016 THEN 'HELLO 16'
	ELSE 'IT�S TOO LATE'
END OBSERVATION
FROM CURSO_ESCOLAR
)
SELECT CANT_A�OS, OBSERVATION FROM A�OS;
*********************************************************************************************************************************************************************************************************************
WITH MATERIAS AS 
(
	SELECT NOMBRE, TIPO, ISNULL(ID_PROFESOR,0) AS ID_PROFESOR,CREDITOS,
	DENSE_RANK() OVER(PARTITION BY TIPO ORDER BY CREDITOS) AS RANKING
	FROM ASIGNATURA
)
SELECT
M.NOMBRE, M.TIPO,
CONCAT(P.NOMBRE,' ', P.APELLIDO1,' ',P.APELLIDO2) AS PROFESOR,
RANKING
FROM PERSONA P
RIGHT JOIN MATERIAS M
ON
P.ID = M.ID_PROFESOR
;
*********************************************************************************************************************************************************************************************************************
WITH PERSONAS AS(
	SELECT
	ID,
	CONCAT(NOMBRE,' ', APELLIDO1,' ',APELLIDO2) AS NOMBRE,
	TIPO,
	FECHA_NACIMIENTO,
	DATEDIFF(YEAR,FECHA_NACIMIENTO,GETDATE()) AS YEARS
	FROM PERSONA
)
SELECT P.*, P1.* FROM PERSONAS P
JOIN PERSONAS P1
ON P.ID = P1.ID
WHERE P.ID = P1.ID AND P1.YEARS > 30
;
*********************************************************************************************************************************************************************************************************************
CREATE TABLE #temp_personas(
ID INT,
NOMBRE VARCHAR(100),
TIPO VARCHAR(50),
FECHA_NACIMIENTO DATE,
YEARSOLD INT
)

INSERT INTO #TEMP_PERSONAS
	SELECT
	ID,
	CONCAT(NOMBRE,' ', APELLIDO1,' ',APELLIDO2),
	TIPO,
	FECHA_NACIMIENTO,
	DATEDIFF(YEAR,FECHA_NACIMIENTO,GETDATE())
	FROM PERSONA

SELECT *, AVG(YEARSOLD) OVER(PARTITION BY TIPO) AS AVG_AGES FROM #TEMP_PERSONAS
ORDER BY TIPO, YEARSOLD;

*********************************************************************************************************************************************************************************************************************
CREATE TABLE #TEMP_ALUMNOSCREDITOS(
NOMBRE VARCHAR(100),
ASIGNATURA VARCHAR(100),
CREDITOS INT,
TOTAL_CREDITOS INT,
OBSERVACION VARCHAR(200)
)

INSERT INTO #TEMP_ALUMNOSCREDITOS
	SELECT CONCAT(P.NOMBRE,' ',P.APELLIDO1,' ',APELLIDO2) AS NOMBRE,
		   A.NOMBRE AS ASIGNATURA,
		   A.CREDITOS,
		   SUM(A.CREDITOS) OVER(PARTITION BY M.ID_ALUMNO) AS TOTAL_CREDITOS,
	CASE
		WHEN SUM(A.CREDITOS) OVER(PARTITION BY M.ID_ALUMNO) < 20 THEN 'INSCRIBIR MAS CREDITOS'
		WHEN SUM(A.CREDITOS) OVER(PARTITION BY M.ID_ALUMNO) < 50 THEN 'CREDITOS COMPLETOS'
		ELSE 'SOBREPASADO LIMITE DE CREDITOS'
	END AS OBSERVACION
	FROM MATRICULA M
	INNER JOIN PERSONA P
	ON
		M.ID_ALUMNO = P.ID
	INNER JOIN ASIGNATURA A
	ON
		M.ID_ASIGNATURA = A.ID

SELECT DISTINCT NOMBRE, TOTAL_CREDITOS, OBSERVACION FROM #TEMP_ALUMNOSCREDITOS
ORDER BY TOTAL_CREDITOS
*********************************************************************************************************************************************************************************************************************
SELECT
PR.ID_PROFESOR,
CONCAT(P.NOMBRE,' ',P.APELLIDO1,' ',P.APELLIDO2) AS PROFESOR,
STUFF(
	(SELECT A.NOMBRE + ' '
	 FROM ASIGNATURA
	 WHERE NOMBRE = A.NOMBRE
	 FOR XML PATH (''))
	 ,1,0,'') AS ASIGNATURA,
P.SEXO
FROM PERSONA P
JOIN PROFESOR PR
ON
P.ID = PR.ID_PROFESOR
JOIN ASIGNATURA A
ON
PR.ID_DEPARTAMENTO = A.ID
WHERE P.TIPO LIKE 'PROFESOR'
;
*********************************************************************************************************************************************************************************************************************
USE UNIVERSITY;
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM ASIGNATURA;

