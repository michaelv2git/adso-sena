CREATE DATABASE IF NOT EXISTS Michael_Henao;
USE Michael_Henao;

DROP TABLE IF EXISTS transacciones;
DROP TABLE IF EXISTS cuentas;
DROP TABLE IF EXISTS comercios;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    ciudad VARCHAR(40) DEFAULT 'Bogotá',
    localidad VARCHAR(40),
    fecha_registro DATE NOT NULL,
    id_referido INT DEFAULT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE cuentas (
    id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    saldo DECIMAL(12,2) DEFAULT 0.00,
    tipo_cuenta VARCHAR(20) DEFAULT 'Ahorro digital',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE comercios (
    id_comercio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_comercio VARCHAR(60) NOT NULL,
    categoria VARCHAR(30),
    ciudad VARCHAR(40)
);

CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT NOT NULL,
    id_comercio INT,
    valor DECIMAL(12,2) NOT NULL,
    fecha_transaccion DATE NOT NULL,
    tipo VARCHAR(20),
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta),
    FOREIGN KEY (id_comercio) REFERENCES comercios(id_comercio)
);

INSERT INTO clientes (nombre, apellido, ciudad, localidad, fecha_registro, id_referido)
values 
('Juan', 'Barbosa', 'Bogotá D.C.', 'Puente Aranda', '2026-10-29', NULL),
('David', 'Abril', 'Bogotá D.C.', 'Suba', '2026-10-29', NULL),
('Nelson', 'Aguirre', 'Bogotá D.C.', 'Puente Aranda', '2026-10-29', NULL),
('David', 'Meneses', 'Bogotá D.C.', 'Puente Aranda', '2026-10-29', NULL),
('Sergio', 'Castañeda', 'Bogotá D.C.', 'Engativá', '2026-02-10', NULL);

INSERT INTO comercios (nombre_comercio, categoria, ciudad)
values 
('Don Benítez', 'Cadena de restaurantes', 'Bogotá D.C.'),
('PPC', 'Cadena de restaurantes', 'Bogotá D.C.'),
('KFC', 'Cadena de restaurantes', 'Bogotá D.C.'),
('El corral', 'Cadena de restaurantes', 'Bogotá D.C.'),
('McDonalds', 'Cadena de restaurantes', 'Bogotá D.C.');

INSERT INTO cuentas (id_cliente, saldo, tipo_cuenta)
values 
(1, 200000, 'Ahorros'),
(2, 25000, 'Corriente'),
(3, 500000, 'Corriente'),
(4, 50000, 'Ahorros'),
(5, 70000, 'Ahorros');

INSERT INTO transacciones (id_cuenta, id_comercio, valor, fecha_transaccion, tipo)
values 
(1, 1, 200000, '2026-10-30', 'Factura electrónica'),
(2, 2, 200000, '2026-10-30', 'Factura electrónica'),
(3, 3, 200000, '2026-10-30', 'Factura electrónica'),
(4, 4, 200000, '2026-10-30', 'Factura electrónica'),
(5, 5, 200000, '2026-10-30', 'Factura electrónica');

SELECT nombre, apellido, ciudad, localidad, fecha_registro FROM clientes
ORDER BY fecha_registro DESC
LIMIT 5;

SELECT COUNT(*) AS total_transacciones FROM transacciones;

SELECT SUM(valor) AS total_don_benitez FROM transacciones WHERE id_comercio = 1;

SELECT AVG(saldo) AS saldo_promedio FROM cuentas;

SELECT id_comercio, SUM(valor) AS total_gastado
FROM transacciones
GROUP BY id_comercio
ORDER BY total_gastado DESC;

UPDATE nombre_tabla
SET columna = nuevo_valor
WHERE condicion;

UPDATE cuentas
SET saldo = saldo + 50000
WHERE id_cuenta = 2;

SELECT * FROM clientes
ORDER BY fecha_registro ASC
LIMIT 2;
