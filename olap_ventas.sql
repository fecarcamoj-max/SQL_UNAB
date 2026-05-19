
CREATE DATABASE olap_ventas;
USE olap_ventas;

CREATE TABLE dim_tiempo (
    tiempo_id INT PRIMARY KEY,
    fecha DATE,
    anio INT,
    mes INT,
    nombre_mes VARCHAR(20),
    trimestre INT
);

INSERT INTO dim_tiempo VALUES
(1,'2024-01-15',2024,1,'Enero',1),
(2,'2024-02-20',2024,2,'Febrero',1),
(3,'2024-03-10',2024,3,'Marzo',1),
(4,'2024-04-05',2024,4,'Abril',2),
(5,'2024-05-18',2024,5,'Mayo',2);

CREATE TABLE dim_producto (
    producto_id INT PRIMARY KEY,
    nombre_producto VARCHAR(50),
    categoria VARCHAR(50)
);

INSERT INTO dim_producto VALUES
(1,'Laptop','Tecnología'),
(2,'Mouse','Tecnología'),
(3,'Escritorio','Muebles'),
(4,'Silla','Muebles');

CREATE TABLE dim_cliente (
    cliente_id INT PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    ciudad VARCHAR(50)
);

INSERT INTO dim_cliente VALUES
(1,'Juan Pérez','Santiago'),
(2,'María López','Valparaíso'),
(3,'Pedro Gómez','Concepción');

CREATE TABLE fact_ventas (
    venta_id INT PRIMARY KEY AUTO_INCREMENT,
    tiempo_id INT,
    producto_id INT,
    cliente_id INT,
    cantidad INT,
    total_venta DECIMAL(10,2),
    FOREIGN KEY (tiempo_id) REFERENCES dim_tiempo(tiempo_id),
    FOREIGN KEY (producto_id) REFERENCES dim_producto(producto_id),
    FOREIGN KEY (cliente_id) REFERENCES dim_cliente(cliente_id)
);

INSERT INTO fact_ventas (tiempo_id, producto_id, cliente_id, cantidad, total_venta) VALUES
(1,1,1,1,800),
(1,2,1,2,40),
(2,1,2,1,780),
(2,4,3,2,300),
(3,3,1,1,250),
(3,2,2,3,60),
(4,1,3,1,820),
(4,4,1,1,150),
(5,3,2,2,500),
(5,2,3,1,20);
