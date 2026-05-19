-- ============================================================
-- Northwind simplificado para MariaDB / MySQL
-- Base preparada para resolver la práctica SQL adjunta.
-- Ejecutar completo en MariaDB/MySQL.
-- ============================================================

DROP DATABASE IF EXISTS northwind_practica;
CREATE DATABASE northwind_practica
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE northwind_practica;

-- ============================================================
-- DDL
-- ============================================================

CREATE TABLE categories (
  CategoryID INT NOT NULL AUTO_INCREMENT,
  CategoryName VARCHAR(100) NOT NULL,
  Description TEXT NULL,
  PRIMARY KEY (CategoryID)
) ENGINE=InnoDB;

CREATE TABLE suppliers (
  SupplierID INT NOT NULL AUTO_INCREMENT,
  CompanyName VARCHAR(120) NOT NULL,
  ContactName VARCHAR(100) NULL,
  ContactTitle VARCHAR(100) NULL,
  Address VARCHAR(200) NULL,
  City VARCHAR(80) NULL,
  Region VARCHAR(80) NULL,
  PostalCode VARCHAR(30) NULL,
  Country VARCHAR(80) NULL,
  Phone VARCHAR(50) NULL,
  PRIMARY KEY (SupplierID)
) ENGINE=InnoDB;

CREATE TABLE products (
  ProductID INT NOT NULL AUTO_INCREMENT,
  ProductName VARCHAR(150) NOT NULL,
  SupplierID INT NULL,
  CategoryID INT NULL,
  QuantityPerUnit VARCHAR(100) NULL,
  UnitPrice DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  UnitsInStock SMALLINT NOT NULL DEFAULT 0,
  UnitsOnOrder SMALLINT NOT NULL DEFAULT 0,
  ReorderLevel SMALLINT NOT NULL DEFAULT 0,
  Discontinued TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (ProductID),
  CONSTRAINT fk_products_suppliers
    FOREIGN KEY (SupplierID) REFERENCES suppliers(SupplierID),
  CONSTRAINT fk_products_categories
    FOREIGN KEY (CategoryID) REFERENCES categories(CategoryID)
) ENGINE=InnoDB;

CREATE TABLE customers (
  CustomerID CHAR(5) NOT NULL,
  CompanyName VARCHAR(120) NOT NULL,
  ContactName VARCHAR(100) NULL,
  ContactTitle VARCHAR(100) NULL,
  Address VARCHAR(200) NULL,
  City VARCHAR(80) NULL,
  Region VARCHAR(80) NULL,
  PostalCode VARCHAR(30) NULL,
  Country VARCHAR(80) NULL,
  Phone VARCHAR(50) NULL,
  Fax VARCHAR(50) NULL,
  PRIMARY KEY (CustomerID)
) ENGINE=InnoDB;

CREATE TABLE employees (
  EmployeeID INT NOT NULL AUTO_INCREMENT,
  LastName VARCHAR(80) NOT NULL,
  FirstName VARCHAR(80) NOT NULL,
  Title VARCHAR(100) NULL,
  BirthDate DATE NULL,
  HireDate DATE NULL,
  Address VARCHAR(200) NULL,
  City VARCHAR(80) NULL,
  Region VARCHAR(80) NULL,
  PostalCode VARCHAR(30) NULL,
  Country VARCHAR(80) NULL,
  HomePhone VARCHAR(50) NULL,
  ReportsTo INT NULL,
  PRIMARY KEY (EmployeeID),
  CONSTRAINT fk_employees_reports_to
    FOREIGN KEY (ReportsTo) REFERENCES employees(EmployeeID)
) ENGINE=InnoDB;

CREATE TABLE shippers (
  ShipperID INT NOT NULL AUTO_INCREMENT,
  CompanyName VARCHAR(120) NOT NULL,
  Phone VARCHAR(50) NULL,
  PRIMARY KEY (ShipperID)
) ENGINE=InnoDB;

CREATE TABLE orders (
  OrderID INT NOT NULL,
  CustomerID CHAR(5) NULL,
  EmployeeID INT NULL,
  OrderDate DATE NULL,
  RequiredDate DATE NULL,
  ShippedDate DATE NULL,
  ShipVia INT NULL,
  Freight DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  ShipName VARCHAR(120) NULL,
  ShipAddress VARCHAR(200) NULL,
  ShipCity VARCHAR(80) NULL,
  ShipRegion VARCHAR(80) NULL,
  ShipPostalCode VARCHAR(30) NULL,
  ShipCountry VARCHAR(80) NULL,
  PRIMARY KEY (OrderID),
  CONSTRAINT fk_orders_customers
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
  CONSTRAINT fk_orders_employees
    FOREIGN KEY (EmployeeID) REFERENCES employees(EmployeeID),
  CONSTRAINT fk_orders_shippers
    FOREIGN KEY (ShipVia) REFERENCES shippers(ShipperID)
) ENGINE=InnoDB;

CREATE TABLE order_details (
  OrderID INT NOT NULL,
  ProductID INT NOT NULL,
  UnitPrice DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  Quantity SMALLINT NOT NULL DEFAULT 1,
  Discount DECIMAL(4,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (OrderID, ProductID),
  CONSTRAINT fk_order_details_orders
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
    ON DELETE CASCADE,
  CONSTRAINT fk_order_details_products
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
) ENGINE=InnoDB;

-- Índices útiles para joins y búsquedas de la práctica
CREATE INDEX idx_products_category ON products(CategoryID);
CREATE INDEX idx_orders_customer ON orders(CustomerID);
CREATE INDEX idx_orders_employee ON orders(EmployeeID);
CREATE INDEX idx_order_details_product ON order_details(ProductID);
CREATE INDEX idx_customers_country ON customers(Country);

-- ============================================================
-- INSERTS
-- ============================================================

INSERT INTO categories (CategoryID, CategoryName, Description) VALUES
(1, 'Bebidas', 'Refrescos, cafés, tés, cervezas y ales'),
(2, 'Condimentos', 'Salsas dulces y saladas, especias y aderezos'),
(3, 'Confitería', 'Postres, dulces y panes dulces'),
(4, 'Lácteos', 'Quesos'),
(5, 'Granos/Cereales', 'Panes, galletas, pasta y cereales'),
(6, 'Carnes/Aves', 'Carnes preparadas'),
(7, 'Frutas/Verduras', 'Frutas secas y productos de soja'),
(8, 'Pescados/Mariscos', 'Pescados y mariscos');

INSERT INTO suppliers
(SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone) VALUES
(1, 'Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', NULL, 'EC1 4SD', 'UK', '(171) 555-2222'),
(2, 'New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822'),
(3, 'Grandma Kelly''s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735'),
(4, 'Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai Musashino-shi', 'Tokyo', NULL, '100', 'Japan', '(03) 3555-5011'),
(5, 'Cooperativa de Quesos Las Cabras', 'Antonio del Valle', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54'),
(6, 'Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', NULL, '545', 'Japan', '(06) 431-7877'),
(7, 'Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St.', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343'),
(8, 'Nord-Ost-Fisch Handelsgesellschaft mbH', 'Sven Petersen', 'Coordinator Foreign Markets', 'Frahmredder 112a', 'Cuxhaven', NULL, '27478', 'Germany', '(04721) 8713');

INSERT INTO products
(ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued) VALUES
(1, 'Chai', 1, 1, '10 cajas x 20 bolsas', 18.00, 39, 0, 10, 0),
(2, 'Chang', 1, 1, '24 botellas x 12 oz', 19.00, 17, 40, 25, 0),
(3, 'Aniseed Syrup', 1, 2, '12 botellas x 550 ml', 10.00, 13, 70, 25, 0),
(4, 'Chef Anton''s Cajun Seasoning', 2, 2, '48 frascos x 6 oz', 22.00, 53, 0, 0, 0),
(5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 cajas', 21.35, 0, 0, 0, 1),
(6, 'Grandma''s Boysenberry Spread', 3, 2, '12 frascos x 8 oz', 25.00, 120, 0, 25, 0),
(7, 'Uncle Bob''s Organic Dried Pears', 3, 7, '12 paquetes x 1 lb', 30.00, 15, 0, 10, 0),
(8, 'Northwoods Cranberry Sauce', 3, 2, '12 frascos x 12 oz', 40.00, 6, 0, 10, 0),
(9, 'Mishi Kobe Niku', 4, 6, '18 paquetes x 500 g', 97.00, 29, 0, 0, 1),
(10, 'Ikura', 4, 8, '12 frascos x 200 ml', 31.00, 31, 0, 0, 0),
(11, 'Queso Cabrales', 5, 4, '1 kg paquete', 21.00, 22, 30, 30, 0),
(12, 'Queso Manchego La Pastora', 5, 4, '10 paquetes x 500 g', 38.00, 86, 0, 0, 0),
(13, 'Konbu', 6, 8, '2 kg caja', 6.00, 24, 0, 5, 0),
(14, 'Tofu de larga duración', 6, 7, '40 paquetes x 100 g', 23.25, 8, 0, 15, 0),
(15, 'Genen Shouyu', 6, 2, '24 botellas x 250 ml', 15.50, 39, 0, 5, 0),
(16, 'Pavlova', 7, 3, '32 cajas x 500 g', 17.45, 29, 0, 10, 0),
(17, 'Alice Mutton', 7, 6, '20 latas x 1 kg', 39.00, 0, 0, 0, 1),
(18, 'Carnarvon Tigers', 7, 8, '16 paquetes x 500 g', 62.50, 42, 0, 0, 0),
(19, 'Teatime Chocolate Biscuits', 7, 3, '10 cajas x 12 piezas', 9.20, 25, 0, 5, 0),
(20, 'Sir Rodney''s Marmalade', 7, 3, '30 cajas regalo', 81.00, 40, 0, 0, 0),
(21, 'Gnocchi di nonna Alice', 7, 5, '24 paquetes x 250 g', 38.00, 21, 10, 30, 0),
(22, 'Ravioli Angelo', 7, 5, '24 paquetes x 250 g', 19.50, 36, 0, 20, 0),
(23, 'Nord-Ost Matjeshering', 8, 8, '10 frascos x 200 g', 25.89, 10, 0, 15, 0),
(24, 'Rössle Sauerkraut', 7, 7, '25 latas x 825 g', 45.60, 26, 0, 0, 1);

INSERT INTO customers
(CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax) VALUES
('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany', '030-0074321', '030-0076545'),
('ANATR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Owner', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico', '(5) 555-4729', '(5) 555-3745'),
('ANTON', 'Antonio Moreno Taquería', 'Antonio Moreno', 'Owner', 'Mataderos 2312', 'México D.F.', NULL, '05023', 'Mexico', '(5) 555-3932', NULL),
('AROUT', 'Around the Horn', 'Thomas Hardy', 'Sales Representative', '120 Hanover Sq.', 'London', NULL, 'WA1 1DP', 'UK', '(171) 555-7788', '(171) 555-6750'),
('BERGS', 'Berglunds snabbköp', 'Christina Berglund', 'Order Administrator', 'Berguvsvägen 8', 'Luleå', NULL, 'S-958 22', 'Sweden', '0921-12 34 65', '0921-12 34 67'),
('BLAUS', 'Blauer See Delikatessen', 'Hanna Moos', 'Sales Representative', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany', '0621-08460', '0621-08924'),
('BLONP', 'Blondesddsl père et fils', 'Frédérique Citeaux', 'Marketing Manager', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France', '88.60.15.31', '88.60.15.32'),
('BONAP', 'Bon app''', 'Laurence Lebihan', 'Owner', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France', '91.24.45.40', '91.24.45.41'),
('BOTTM', 'Bottom-Dollar Markets', 'Elizabeth Lincoln', 'Accounting Manager', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada', '(604) 555-4729', '(604) 555-3745'),
('CACTU', 'Cactus Comidas para llevar', 'Patricio Simpson', 'Sales Agent', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina', '(1) 135-5555', '(1) 135-4892'),
('CENTC', 'Centro comercial Moctezuma', 'Francisco Chang', 'Marketing Manager', 'Sierras de Granada 9993', 'México D.F.', NULL, '05022', 'Mexico', '(5) 555-3392', '(5) 555-7293'),
('CHOPS', 'Chop-suey Chinese', 'Yang Wang', 'Owner', 'Hauptstr. 29', 'Bern', NULL, '3012', 'Switzerland', '0452-076545', NULL),
('COMMI', 'Comércio Mineiro', 'Pedro Afonso', 'Sales Associate', 'Av. dos Lusíadas, 23', 'São Paulo', 'SP', '05432-043', 'Brazil', '(11) 555-7647', NULL),
('DUMON', 'Du monde entier', 'Janine Labrune', 'Owner', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France', '40.67.88.88', '40.67.89.89'),
('SEVES', 'Seven Seas Imports', 'Hari Kumar', 'Sales Manager', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK', '(171) 555-1717', '(171) 555-5646');

INSERT INTO employees
(EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, ReportsTo) VALUES
(1, 'Davolio', 'Nancy', 'Sales Representative', '1968-12-08', '1992-05-01', '507 - 20th Ave. E.', 'Seattle', 'WA', '98122', 'USA', '(206) 555-9857', NULL),
(2, 'Fuller', 'Andrew', 'Vice President, Sales', '1952-02-19', '1992-08-14', '908 W. Capital Way', 'Tacoma', 'WA', '98401', 'USA', '(206) 555-9482', NULL),
(3, 'Leverling', 'Janet', 'Sales Representative', '1963-08-30', '1992-04-01', '722 Moss Bay Blvd.', 'Kirkland', 'WA', '98033', 'USA', '(206) 555-3412', 2),
(4, 'Peacock', 'Margaret', 'Sales Representative', '1958-09-19', '1993-05-03', '4110 Old Redmond Rd.', 'Redmond', 'WA', '98052', 'USA', '(206) 555-8122', 2),
(5, 'Buchanan', 'Steven', 'Sales Manager', '1955-03-04', '1993-10-17', '14 Garrett Hill', 'London', NULL, 'SW1 8JR', 'UK', '(71) 555-4848', 2);

INSERT INTO shippers (ShipperID, CompanyName, Phone) VALUES
(1, 'Speedy Express', '(503) 555-9831'),
(2, 'United Package', '(503) 555-3199'),
(3, 'Federal Shipping', '(503) 555-9931');

INSERT INTO orders
(OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight,
 ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry) VALUES
(10248, 'ALFKI', 5, '1996-07-04', '1996-08-01', '1996-07-16', 3, 32.38, 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
(10249, 'ANATR', 1, '1996-07-05', '1996-08-16', '1996-07-10', 1, 11.61, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico'),
(10250, 'ANTON', 4, '1996-07-08', '1996-08-05', '1996-07-12', 2, 65.83, 'Antonio Moreno Taquería', 'Mataderos 2312', 'México D.F.', NULL, '05023', 'Mexico'),
(10251, 'AROUT', 3, '1996-07-08', '1996-08-05', '1996-07-15', 1, 41.34, 'Around the Horn', '120 Hanover Sq.', 'London', NULL, 'WA1 1DP', 'UK'),
(10252, 'BERGS', 4, '1996-07-09', '1996-08-06', '1996-07-11', 2, 51.30, 'Berglunds snabbköp', 'Berguvsvägen 8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
(10263, 'ALFKI', 3, '1996-07-23', '1996-08-20', '1996-07-31', 3, 146.06, 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
(10320, 'BONAP', 5, '1996-10-03', '1996-10-31', '1996-10-18', 3, 34.57, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
(10445, 'CHOPS', 3, '1997-02-13', '1997-03-13', '1997-02-20', 1, 9.30, 'Chop-suey Chinese', 'Hauptstr. 29', 'Bern', NULL, '3012', 'Switzerland'),
(10510, 'COMMI', 4, '1997-04-18', '1997-05-16', '1997-04-28', 3, 367.63, 'Comércio Mineiro', 'Av. dos Lusíadas, 23', 'São Paulo', 'SP', '05432-043', 'Brazil'),
(10625, 'DUMON', 1, '1997-08-08', '1997-09-05', '1997-08-14', 2, 43.90, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France'),
(10710, 'BOTTM', 2, '1997-10-20', '1997-11-17', '1997-10-23', 1, 4.98, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10869, 'SEVES', NULL, '1998-02-04', '1998-03-04', '1998-02-09', 1, 143.28, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');

INSERT INTO order_details (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
(10248, 11, 14.00, 12, 0.00),
(10248, 16, 9.80, 10, 0.00),
(10248, 19, 9.20, 5, 0.00),
(10249, 14, 18.60, 9, 0.00),
(10249, 1, 18.00, 10, 0.00),
(10250, 14, 18.60, 15, 0.05),
(10250, 4, 22.00, 10, 0.00),
(10251, 22, 19.50, 6, 0.05),
(10252, 20, 81.00, 40, 0.05),

-- Pedido solicitado en el ejercicio 3
(10263, 16, 13.90, 60, 0.25),
(10263, 24, 36.40, 28, 0.00),
(10263, 23, 25.89, 60, 0.25),

-- Compras del producto "Tofu de larga duración"
(10320, 14, 23.25, 30, 0.00),
(10445, 14, 23.25, 20, 0.10),
(10510, 14, 23.25, 25, 0.05),
(10625, 14, 23.25, 10, 0.00),
(10710, 14, 23.25, 18, 0.00),

-- Pedido solicitado en el ejercicio 5
(10869, 10, 31.00, 40, 0.00),
(10869, 18, 62.50, 30, 0.00),
(10869, 21, 38.00, 21, 0.00);

-- ============================================================
-- CONSULTAS DE VALIDACIÓN PARA LOS 10 EJERCICIOS
-- ============================================================

-- 1. Media de precios unitarios de todos los productos
SELECT AVG(UnitPrice) AS promedio_precio_unitario
FROM products;

-- 2. Todos los transportistas
SELECT *
FROM shippers;

-- 3. Nombres de productos en el pedido #10263
SELECT p.ProductName
FROM order_details od
JOIN products p ON p.ProductID = od.ProductID
WHERE od.OrderID = 10263;

-- 4. Número de productos en cada categoría
SELECT
  c.CategoryID,
  c.CategoryName,
  COUNT(p.ProductID) AS numero_productos
FROM categories c
LEFT JOIN products p ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY c.CategoryID;

-- 5. Ventas totales antes del descuento en el pedido #10869
SELECT
  od.OrderID,
  SUM(od.UnitPrice * od.Quantity) AS ventas_totales_antes_descuento
FROM order_details od
WHERE od.OrderID = 10869
GROUP BY od.OrderID;

-- 6. Productos con menos de 15 unidades, sin unidades pedidas y no descatalogados
SELECT
  ProductID,
  ProductName,
  UnitsInStock
FROM products
WHERE UnitsInStock < 15
  AND UnitsOnOrder = 0
  AND Discontinued = 0
ORDER BY UnitsInStock ASC, ProductName ASC;

-- 7. Ventas totales antes del descuento por empleado
SELECT
  e.EmployeeID,
  CONCAT(e.FirstName, ' ', e.LastName) AS empleado,
  SUM(od.UnitPrice * od.Quantity) AS ventas_totales_antes_descuento
FROM employees e
JOIN orders o ON o.EmployeeID = e.EmployeeID
JOIN order_details od ON od.OrderID = o.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY ventas_totales_antes_descuento DESC;

-- 8. Nombre del producto más caro por UnitPrice, sin intervención manual
SELECT ProductName, UnitPrice
FROM products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM products);

-- Alternativa si se quiere una sola fila aunque haya empates:
-- SELECT ProductName, UnitPrice
-- FROM products
-- ORDER BY UnitPrice DESC
-- LIMIT 1;

-- 9. Cantidad de países distintos de clientes
SELECT COUNT(DISTINCT Country) AS cantidad_paises_clientes
FROM customers;

-- 10. Empresas que compraron "Tofu de larga duración" y países de procedencia, ordenado por país
SELECT DISTINCT
  c.CompanyName,
  c.Country
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN order_details od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
WHERE p.ProductName = "Tofu de larga duración"
ORDER BY c.Country, c.CompanyName;
