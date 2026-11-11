-- 1. Recrear la base de datos desde cero 
DROP DATABASE IF EXISTS escuela_db;
CREATE DATABASE escuela_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE escuela_db;

-- 2. Crear las tablas
CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL
);

CREATE TABLE matriculas (
    estudiante_id INT,
    curso_id INT,
    PRIMARY KEY (estudiante_id, curso_id),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE CASCADE
);

-- 3. Insertar datos de prueba
INSERT INTO estudiantes (nombre) VALUES
('Ana Pérez'),
('Carlos Gómez'),
('Elena Ruiz'),
('David Torres');

INSERT INTO cursos (titulo) VALUES
('Matemáticas I'),
('Historia Universal'),
('Programación Básica'),
('Física General');

INSERT INTO matriculas (estudiante_id, curso_id) VALUES
(1, 1), -- Ana en Matemáticas
(1, 2), -- Ana en Historia
(2, 1); -- Carlos en Matemáticas

-- 4. Estudiantes y cursos sin matrícula 
SELECT
    'Estudiante sin matrícula' AS tipo,
    e.id AS entidad_id,
    e.nombre AS descripcion
FROM estudiantes e
LEFT JOIN matriculas m ON e.id = m.estudiante_id
WHERE m.estudiante_id IS NULL

UNION

SELECT
    'Curso sin matrícula' AS tipo,
    c.id AS entidad_id,
    c.titulo AS descripcion
FROM cursos c
LEFT JOIN matriculas m ON c.id = m.curso_id
WHERE m.curso_id IS NULL;
