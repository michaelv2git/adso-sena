DROP DATABASE IF EXISTS self_join;
CREATE DATABASE self_join;
USE self_join;

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
    especialidad VARCHAR(100),
    id_jefe INT,
    FOREIGN KEY (id_jefe) REFERENCES instructor(id_instructor)
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

-- 3. INSERCIÓN DE DATOS DE PRUEBA
INSERT INTO sedes (id_sede, nombre_sede) VALUES
(1, 'Centro'),
(2, 'Norte'),
(3, 'Sur'),
(4, 'Virtual');

-- Instructores con jerarquía de jefes para los ejercicios
INSERT INTO instructor (id_instructor, nombre, apellido, edad, email, especialidad, id_jefe) VALUES
(1, 'Carlos', 'Gómez', 45, 'carlos.gomez@email.com', 'Base de Datos', NULL),    -- Jefe Director Supremo
(2, 'Laura', 'Martínez', 38, 'laura.martinez@email.com', 'Programación Web', 1), -- Su jefe es Carlos
(3, 'Pedro', 'Ruiz', 40, 'pedro.ruiz@email.com', 'Redes', 1),                     -- Su jefe es Carlos
(4, 'Andrés', 'Sánchez', 29, 'andres.sanchez@email.com', 'Frontend', 2),          -- Su jefe es Laura (Jefe 2do nivel: Carlos)
(5, 'Elena', 'Vargas', 31, 'elena.vargas@email.com', 'Backend', 2);              -- Su jefe es Laura (Jefe 2do nivel: Carlos)

INSERT INTO estudiantes (id_estudiante, nombre, apellido, edad, email, fecha_nacimiento, id_sede) VALUES
(101, 'Ana', 'Pérez', 22, 'ana.perez@email.com', '2001-05-15', 1),
(102, 'Luis', 'Rodríguez', 24, 'luis.rodriguez@email.com', '1999-11-20', 1),    -- Misma sede que Ana (Sede 1 - Centro)
(103, 'Sofía', 'Torres', 21, 'sofia.torres@email.com', '2002-08-10', 2),
(104, 'Mateo', 'Gómez', 23, 'mateo.gomez@email.com', '2000-03-12', 2);          -- Misma sede que Sofía (Sede 2 - Norte)

INSERT INTO curso (id_curso, nombre_curso, descripcion, id_instructor) VALUES
(501, 'SQL Avanzado', 'Bases de datos relacionales', 1),
(502, 'Desarrollo con React', 'Aplicaciones web interactivas', 2),
(503, 'Modelado de Datos', 'Diseño de bases de datos', 1),
(504, 'Redes y Seguridad', 'Fundamentos de networking', 3);

INSERT INTO matricula (id_matricula, id_estudiante, id_curso, fecha_matricula, estado) VALUES
(1001, 101, 501, '2026-02-01', 'Activa'), -- Ana en SQL Avanzado
(1002, 102, 501, '2026-02-02', 'Activa'), -- Luis en SQL Avanzado (Mismo curso que Ana)
(1003, 103, 502, '2026-02-03', 'Activa'), -- Sofía en React
(1004, 102, 503, '2026-02-04', 'Activa'); -- Luis también en Modelado (Ana y Luis misma sede, cursos diferentes)

-- Ejercicio 1

SELECT 
    i.id_instructor,
    CONCAT(i.nombre, ' ', i.apellido) AS instructor,
    CONCAT(jefe.nombre, ' ', jefe.apellido) AS instructor_jefe
FROM instructor AS i
LEFT JOIN instructor AS jefe 
    ON i.id_jefe = jefe.id_instructor;


-- Ejercicio 2

SELECT 
    e1.id_estudiante AS id_estudiante_1,
    CONCAT(e1.nombre, ' ', e1.apellido) AS estudiante_1,
    e2.id_estudiante AS id_estudiante_2,
    CONCAT(e2.nombre, ' ', e2.apellido) AS estudiante_2,
    s.nombre_sede
FROM estudiantes AS e1
INNER JOIN estudiantes AS e2 
    ON e1.id_sede = e2.id_sede 
   AND e1.id_estudiante < e2.id_estudiante
INNER JOIN sedes AS s 
    ON e1.id_sede = s.id_sede;


-- Ejercicio 3

SELECT 
    i.id_instructor,
    CONCAT(i.nombre, ' ', i.apellido) AS instructor,
    CONCAT(jefe.nombre, ' ', jefe.apellido) AS nombre_jefe
FROM instructor AS i
INNER JOIN instructor AS jefe 
    ON i.id_jefe = jefe.id_instructor;


-- Ejercicio 4

SELECT 
    c.nombre_curso,
    CONCAT(e1.nombre, ' ', e1.apellido) AS estudiante_1,
    CONCAT(e2.nombre, ' ', e2.apellido) AS estudiante_2
FROM matricula AS m1
INNER JOIN matricula AS m2 
    ON m1.id_curso = m2.id_curso 
   AND m1.id_estudiante < m2.id_estudiante
INNER JOIN estudiantes AS e1 ON m1.id_estudiante = e1.id_estudiante
INNER JOIN estudiantes AS e2 ON m2.id_estudiante = e2.id_estudiante
INNER JOIN curso AS c ON m1.id_curso = c.id_curso;


-- Ejercicio 5

SELECT 
    jefe.id_instructor AS id_jefe,
    CONCAT(jefe.nombre, ' ', jefe.apellido) AS instructor_jefe,
    COUNT(i.id_instructor) AS instructores_a_cargo
FROM instructor AS jefe
INNER JOIN instructor AS i 
    ON i.id_jefe = jefe.id_instructor
GROUP BY jefe.id_instructor, jefe.nombre, jefe.apellido;


-- Ejercicio 6

SELECT DISTINCT
    s.nombre_sede,
    CONCAT(e1.nombre, ' ', e1.apellido) AS estudiante_1,
    CONCAT(e2.nombre, ' ', e2.apellido) AS estudiante_2,
    c1.nombre_curso AS curso_estudiante_1,
    c2.nombre_curso AS curso_estudiante_2
FROM estudiantes AS e1
INNER JOIN estudiantes AS e2 
    ON e1.id_sede = e2.id_sede 
   AND e1.id_estudiante < e2.id_estudiante
INNER JOIN matricula AS m1 ON e1.id_estudiante = m1.id_estudiante
INNER JOIN matricula AS m2 ON e2.id_estudiante = m2.id_estudiante
INNER JOIN curso AS c1 ON m1.id_curso = c1.id_curso
INNER JOIN curso AS c2 ON m2.id_curso = c2.id_curso
INNER JOIN sedes AS s ON e1.id_sede = s.id_sede
WHERE m1.id_curso <> m2.id_curso;


-- Ejercicio 7

SELECT 
    i.id_instructor,
    CONCAT(i.nombre, ' ', i.apellido) AS instructor,
    CONCAT(jefe1.nombre, ' ', jefe1.apellido) AS jefe_directo,
    CONCAT(jefe2.nombre, ' ', jefe2.apellido) AS jefe_segundo_nivel
FROM instructor AS i
LEFT JOIN instructor AS jefe1 
    ON i.id_jefe = jefe1.id_instructor
LEFT JOIN instructor AS jefe2 
    ON jefe1.id_jefe = jefe2.id_instructor;


-- Ejercicio 8

SELECT 
    i.id_instructor,
    CONCAT(i.nombre, ' ', i.apellido) AS instructor,
    'Ciclo jerárquico detectado' AS observacion
FROM instructor AS i
INNER JOIN instructor AS jefe1 ON i.id_jefe = jefe1.id_instructor
INNER JOIN instructor AS jefe2 ON jefe1.id_jefe = jefe2.id_instructor
WHERE jefe2.id_jefe = i.id_instructor 
   OR jefe1.id_jefe = i.id_instructor;
