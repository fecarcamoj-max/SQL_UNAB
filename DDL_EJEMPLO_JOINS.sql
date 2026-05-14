-- Script para clase SQL: JOINS, UNION, IN, consultas anidadas y vistas
-- Compatible con MariaDB / MySQL

DROP DATABASE IF EXISTS clase_sql;
CREATE DATABASE clase_sql CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clase_sql;

-- =========================
-- TABLA: persona
-- =========================
CREATE TABLE persona (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    ciudad VARCHAR(50)
);

-- =========================
-- TABLA: inventario
-- =========================
CREATE TABLE inventario (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- =========================
-- TABLA: ventas
-- =========================
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    fecha_venta DATE NOT NULL,

    CONSTRAINT fk_ventas_persona
        FOREIGN KEY (id_persona)
        REFERENCES persona(id_persona),

    CONSTRAINT fk_ventas_inventario
        FOREIGN KEY (id_producto)
        REFERENCES inventario(id_producto)
);

-- =========================
-- INSERTS: persona
-- =========================
INSERT INTO persona (nombre, correo, ciudad) VALUES
('Juan Perez', 'juan@email.com', 'Santiago'),
('Maria Gonzalez', 'maria@email.com', 'Valparaiso'),
('Pedro Ramirez', 'pedro@email.com', 'Concepcion'),
('Ana Torres', 'ana@email.com', 'Santiago'),
('Luis Herrera', 'luis@email.com', 'La Serena'),
('Carolina Diaz', 'carolina@email.com', 'Temuco'),
('Fernanda Soto', 'fernanda@email.com', 'Rancagua'),
('Diego Morales', 'diego@email.com', 'Santiago');

-- =========================
-- INSERTS: inventario
-- =========================
INSERT INTO inventario (nombre_producto, categoria, precio, stock) VALUES
('Notebook Lenovo', 'Computacion', 650000, 10),
('Mouse Logitech', 'Accesorios', 15000, 50),
('Teclado Mecanico', 'Accesorios', 45000, 25),
('Monitor Samsung 24', 'Computacion', 120000, 15),
('Silla Gamer', 'Muebles', 180000, 8),
('Escritorio Oficina', 'Muebles', 95000, 12),
('Audifonos Sony', 'Audio', 55000, 30),
('Parlante Bluetooth', 'Audio', 35000, 20),
('Webcam HD', 'Accesorios', 28000, 18),
('Impresora Epson', 'Computacion', 150000, 6);

-- =========================
-- INSERTS: ventas
-- =========================
INSERT INTO ventas (id_persona, id_producto, cantidad, fecha_venta) VALUES
(1, 1, 1, '2026-05-01'),
(1, 2, 2, '2026-05-01'),
(2, 3, 1, '2026-05-02'),
(2, 4, 1, '2026-05-03'),
(3, 2, 3, '2026-05-04'),
(3, 7, 1, '2026-05-05'),
(4, 5, 1, '2026-05-06'),
(4, 6, 1, '2026-05-06'),
(5, 8, 2, '2026-05-07'),
(6, 1, 1, '2026-05-08'),
(6, 3, 2, '2026-05-09'),
(1, 7, 1, '2026-05-10'),
(7, 9, 1, '2026-05-11'),
(8, 10, 1, '2026-05-12'),
(8, 2, 1, '2026-05-12');


