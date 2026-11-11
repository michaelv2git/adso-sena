CREATE DATABASE IF NOT EXISTS cross_join;
USE cross_join;

DROP TABLE IF EXISTS matricula;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS estudiantes;
DROP TABLE IF EXISTS instructor;
DROP TABLE IF EXISTS sedes;

CREATE TABLE sedes (
    id_sede INT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL
);

CREATE TABLE instructor (
    id_instructor INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    email VARCHAR(100),
    especialidad VARCHAR(100)
);

CREATE TABLE estudiantes (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    email VARCHAR(100),
    fecha_nacimiento DATE,
    id_sede INT NOT NULL,
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
);

CREATE TABLE curso (
    id_curso INT PRIMARY KEY,
    nombre_curso VARCHAR(50),
    descripcion TEXT,
    id_instructor INT,
    FOREIGN KEY (id_instructor) REFERENCES instructor(id_instructor)
);

CREATE TABLE matricula (
    id_matricula INT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha_matricula DATE,
    estado VARCHAR(20),
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);


INSERT INTO sedes (id_sede, nombre_sede) VALUES
(1, 'Centro'),
(2, 'Norte'),
(3, 'Sur'),
(4, 'Virtual');

INSERT INTO instructor (id_instructor, nombre, apellido, edad, email, especialidad) VALUES
(1, 'Carlos', 'Gómez', 45, 'carlos.gomez@email.com', 'Base de Datos'),
(2, 'Laura', 'Martínez', 38, 'laura.martinez@email.com', 'Programación Web'),
(3, 'Pedro', 'Ruiz', 40, 'pedro.ruiz@email.com', 'Redes');

INSERT INTO estudiantes (id_estudiante, nombre, apellido, edad, email, fecha_nacimiento, id_sede) VALUES
(101, 'Ana', 'Pérez', 22, 'ana.perez@email.com', '2001-05-15', 1),
(102, 'Luis', 'Rodríguez', 24, 'luis.rodriguez@email.com', '1999-11-20', 2),
(103, 'Sofía', 'Torres', 21, 'sofia.torres@email.com', '2002-08-10', 3);

INSERT INTO curso (id_curso, nombre_curso, descripcion, id_instructor) VALUES
(501, 'SQL Avanzado', 'Bases de datos relacionales', 1),
(502, 'Desarrollo con React', 'Aplicaciones web interactivas', 2),
(503, 'Modelado de Datos', 'Diseño de bases de datos', 1);

INSERT INTO matricula (id_matricula, id_estudiante, id_curso, fecha_matricula, estado) VALUES
(1001, 101, 501, '2026-02-01', 'Activa'),
(1002, 102, 502, '2026-02-03', 'Activa');

-- EJERCICIO 1

SELECT 
    c.id_curso,
    c.nombre_curso,
    s.id_sede,
    s.nombre_sede
FROM curso AS c
CROSS JOIN sedes AS s;


-- EJERCICIO 2

SELECT 
    e.id_estudiante,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    i.id_instructor,
    CONCAT(i.nombre, ' ', i.apellido) AS instructor
FROM estudiantes AS e
CROSS JOIN instructor AS i;


-- EJERCICIO 3 (Respuesta teórica abajo en las explicaciones)

/*

1. `SELECT * FROM cursos, sedes;`
   - Representa un CROSS JOIN implícito (Producto Cartesiano).
   - Combina absolutamente TODAS las filas de la tabla 'cursos' con TODAS las filas de la tabla 'sedes', sin importar si están relacionadas o no.
   - Si hay 3 cursos y 4 sedes, el resultado devolverá exactamente 12 filas (3 x 4).

2. `SELECT * FROM cursos INNER JOIN sedes ON cursos.id_sede = sedes.id_sede;`
   - Representa un INNER JOIN explícito.
   - Solo devuelve los registros donde la clave 'id_sede' de la tabla 'cursos' COINCIDA exactamente con la clave 'id_sede' de la tabla 'sedes'.
   - Filtra el resultado para mostrar únicamente la sede a la que pertenece formalmente cada curso, descartando las combinaciones no relacionadas.
*/

-- EJERCICIO 4

SELECT 
    c.id_curso,
    c.nombre_curso,
    i.id_instructor,
    CONCAT(i.nombre, ' ', i.apellido) AS instructor
FROM curso AS c
CROSS JOIN instructor AS i
WHERE c.id_instructor = i.id_instructor;


-- EJERCICIO 5

SELECT 
    c.id_curso,
    c.nombre_curso,
    s.id_sede,
    s.nombre_sede,
    'Disponible' AS estado_planeacion
FROM curso AS c
CROSS JOIN sedes AS s;


-- EJERCICIO 6

SELECT 
    c.nombre_curso,
    s.nombre_sede,
    CONCAT(i.nombre, ' ', i.apellido) AS instructor
FROM curso AS c
CROSS JOIN sedes AS s
CROSS JOIN instructor AS i;
