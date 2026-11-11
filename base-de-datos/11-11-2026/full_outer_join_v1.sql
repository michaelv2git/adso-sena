CREATE DATABASE IF NOT EXISTS actividad_join;
USE actividad_join;

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

INSERT INTO instructor (id_instructor, nombre, apellido, email, especialidad) VALUES
(1, 'Carlos', 'Gómez', 'carlos.gomez@email.com', 'Base de Datos'),
(2, 'Laura', 'Martínez', 'laura.martinez@email.com', 'Programación Web'),
(3, 'Pedro', 'Ruiz', 'pedro.ruiz@email.com', 'Redes');

INSERT INTO estudiantes (id_estudiante, nombre, apellido, email, fecha_nacimiento, id_sede) VALUES
(101, 'Ana', 'Pérez', 'ana.perez@email.com', '2001-05-15', 1),
(102, 'Luis', 'Rodríguez', 'luis.rodriguez@email.com', '1999-11-20', 2),
(103, 'Sofía', 'Torres', 'sofia.torres@email.com', '2002-08-10', 3);

INSERT INTO curso (id_curso, nombre_curso, descripcion, id_instructor) VALUES
(501, 'SQL Avanzado', 'Bases de datos relacionales', 1),
(502, 'Desarrollo con React', 'Aplicaciones web interactivas', 2),
(503, 'Modelado de Datos', 'Diseño de bases de datos', 1);

INSERT INTO matricula (id_matricula, id_estudiante, id_curso, fecha_matricula, estado) VALUES
(1001, 101, 501, '2026-02-01', 'Activa'),
(1002, 102, 502, '2026-02-03', 'Activa');

SELECT 
    e.id_estudiante,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    c.id_curso,
    c.nombre_curso,
    'Estudiante sin matrícula' AS estado_registro
FROM estudiantes AS e
LEFT JOIN matricula AS m 
    ON e.id_estudiante = m.id_estudiante
LEFT JOIN curso AS c 
    ON m.id_curso = c.id_curso
WHERE m.id_matricula IS NULL

UNION

SELECT 
    e.id_estudiante,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    c.id_curso,
    c.nombre_curso,
    'Curso sin matrícula' AS estado_registro
FROM estudiantes AS e
RIGHT JOIN matricula AS m 
    ON e.id_estudiante = m.id_estudiante
RIGHT JOIN curso AS c 
    ON m.id_curso = c.id_curso
WHERE m.id_matricula IS NULL;
