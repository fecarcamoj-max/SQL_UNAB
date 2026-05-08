# SQL DDL Lenguaje de Definición de Datos.
# Crear una base de datos.
create database diplomado_unab;

# Eliminar una base de datos.
DROP DATABASE diplomado_unab;

# Mostrar bases de datos en el servidor:
SHOW DATABASES;

# Seleccionar la base de datos.
USE diplomado_unab;

# Crear una tabla en el servidor Mariadb/Mysql.
DROP TABLE persona; #Eliminar tabla
CREATE TABLE persona(
	id bigint PRIMARY KEY auto_increment, # BIG INTEGER GRAN ENTERO
    rut varchar(20) UNIQUE, #varchar es texto con caracteres limitados.
    nombre TEXT, # TEXTO LARGO 1000 o más.
    apellido LONGTEXT, # Texto más largo que TEXT.
    fecha_nacimiento DATE, # YYYY-MM-DD
    fecha_hora_registro DATETIME, # YYYY-MM-DD HH:mm:s
    estatura double, # Tipo de dato de número con decimales.
    edad_actual int(3) NULL
);
# Muestra las tablas de la base de datos.
SHOW TABLES FROM diplomado_unab;#

# Mostrar las columnas de una tabla:
SHOW COLUMNS FROM persona;

#DML Lenguaje de Manipulación de datos.
SELECT * FROM persona; 

### Nuevos comandos de DDL.
# Agregar columna: ROL. (Admin, Vendedor, Mantencion)
ALTER TABLE persona -- ALTERAR/MODIFICAR TABLA
	ADD COLUMN rol varchar(30) default 'nuevo',
    MODIFY COLUMN edad_actual int(2) default 1; #CHANGE

SHOW COLUMNS FROM persona;

# DML INSERTAR VALORES EN LA TABLA persona:
INSERT persona 
(rut, nombre, apellido, fecha_nacimiento, fecha_hora_registro, estatura) 
VALUES
("123", "bob", "stark", "2025-01-01", "2026-05-07 13:45:00", 1.890),
("321", "rob", "stark", "2024-02-02", "2025-04-01 00:00:00", 1.710)
;

INSERT persona 
(rut, nombre, apellido, fecha_nacimiento, fecha_hora_registro, estatura) 
VALUES
("456", "TOP", "stark", "2025-03-01", "2021-05-07 13:12:00", 1.49),
("567", "IAN", "stark", "2024-04-02", "2019-04-01 00:00:00", 1.51)
;

### DML Lenguaje de manipulación de datos:
SELECT * FROM persona;

#Limit: Ver las primeras 2 filas
SELECT * FROM persona LIMIT 2;

#Elegir columnas específicas: Por ej: rut, nombre, apellido
SELECT rut, nombre, apellido FROM persona LIMIT 2;

# Ordenar de mayor a menor. // Traer los últ. 10 registros.
SELECT * FROM persona order by id DESC;

# Ordenar de menor a mayor.
SELECT * FROM persona order by fecha_nacimiento ASC;

SELECT * FROM persona;
# Filtros de información "WHERE".
# Mostrar a la persona de RUT 456
SELECT * FROM persona WHERE rut = "456";

# Mostrar a las personas que midan más de 1.60 mts
SELECT * FROM persona WHERE estatura > 1.60;
# Mostrar a las personas que midan igual o más que 1.51
SELECT * FROM persona WHERE estatura >= 1.51;
# Mostrar a las personas que midan entre 1.50 y 1.75 # + CONECTOR LÓGICO Y
SELECT * FROM persona WHERE estatura >= 1.50 AND estatura <= 1.75;
SELECT * FROM persona WHERE estatura between 1.50 AND 1.75; #>=1.50 y < 1.75

# Conector Lógico O - OR. 
# Mostrar a las personas que tengan por nombre rob ó bob
SELECT * FROM persona WHERE nombre = "rob" OR nombre = "bob";
SELECT * FROM persona WHERE nombre in ("rob", "bob"); # Contener

# Like.
# Mostrar a las personas que contengan una letra "b" en su nombre.
SELECT * FROM persona WHERE nombre LIKE 'b%'; # una b al inicio.
SELECT * FROM persona WHERE nombre LIKE '%b'; # una b al final.
SELECT * FROM persona WHERE nombre LIKE '%b%';# una b en cualquier posición.

# Operaciones de Agrupación en una tabla. (Agrupaciones).
# Cuántas filas tiene la tabla persona?
SELECT COUNT(*) FROM persona;
# IDEAL: Consulta óptima.
SELECT COUNT(id) FROM persona;
# IDEAL + ALIAS.
SELECT COUNT(ID) AS TOTAL_FILAS FROM persona;
# Mostrar columna nombre como "name_".
SELECT nombre AS name_ FROM persona;
# Mostrar la fecha máxima - ó la fecha más reciente.
SELECT MAX(fecha_nacimiento) FROM persona;
# Mostrar la fecha mínima. Mostrar la fecha de nacimiento más antigua
SELECT MIN(fecha_nacimiento) AS fecha_mas_antigua FROM persona;

#SUMAR TODAS LAS EDADES ACTUALES y las estaturas de las personas.
SELECT SUM(edad_actual) as SUMA_edades, SUM(estatura) FROM persona;

# MOSTRAR EL PROMEDIO DE LAS ESTATURAS.
SELECT AVG(estatura) AS PROMEDIO_ESTATURA FROM persona;

# Group By. # Stand By...
SELECT * FROM persona;
#Muestra cuántas veces aparece un apellido en específico.
SELECT apellido, count(*) FROM persona; #Respuesta INCORRECTA.
#respuesta correcta con GROUP BY:
SELECT apellido, count(*) FROM persona
GROUP BY apellido;
#Mostrar cuántas veces aparece un apellido, cuál es el promedio de 
#estatura por apellido con el total de filas al final.
SELECT apellido, count(*) as filas, avg(estatura) prom_est 
FROM persona
GROUP BY apellido WITH ROLLUP;

INSERT persona (rut, nombre, apellido, fecha_nacimiento, fecha_hora_registro,
estatura, edad_actual, rol) VALUES
("111", "rop", "POV", "2023-01-01", NULL, 1.60, 30, "admin"),
("222", "raf", "POV", "2019-01-01", NULL, 1.70, 40, "KAM");