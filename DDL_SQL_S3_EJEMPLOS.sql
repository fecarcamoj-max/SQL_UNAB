DROP DATABASE diplomado_unab;
CREATE DATABASE diplomado_unab;
SHOW TABLES FROM diplomado_unab;

use diplomado_unab;
## DDL DATA DEFINITI LANGUAGE
DROP TABLE persona;
CREATE TABLE persona(
	id bigint Primary key auto_increment,
    nombre varchar(20) NOT NULL,# Texto de 20 caracteres
	apellido varchar(30) NOT NULL, #Texto de 30 caracteres.
    descripcion TEXT, # Texto más largo (+ 1000)
    resumen_labor LONGTEXT,
    fecha_nacimiento DATE, # YYYY-MM-DD #ej: 2026-05-12
    fecha_hora_ingreso DATETIME, # YYYY-MM-DD HH:mm:ss
    puntaje double, # Número real - número con decimales: ej: 20.5555555555...
    calificacion double #Número con 2 decimales. 20.56988
);
ALTER TABLE persona
	MODIFY COLUMN calificacion double;
SHOW TABLES FROM diplomado_unab;

# DML DATA MANIPULATION LANGUAGE -
SELECT * FROM persona;

# insertar datos en la tabla persona:::
INSERT persona (nombre, apellido, descripcion, fecha_nacimiento,
puntaje, calificacion) 
VALUES
("bob", "top", "muy bueno", '2000-10-01', 7.0, 4.0),
("rob", "stark", "excelente", '1990-10-01', 8.0,3.4);

SELECT * FROM persona;

# Filtros:::
SELECT nombre, apellido FROM persona where nombre = "bob";

SELECT * FROM persona WHERE descripcion like 'm%';
SELECT * FROM persona WHERE descripcion like '%e';
SELECT * FROM persona WHERE descripcion like '%e%';

# Ordenamiento::
SELECT * FROM persona ORDER BY ID ASC; # ORDEN POR DEFECTO
SELECT * FROM persona ORDER BY ID DESC; #ORDEN DESCENDENTE

#LIMITAR RESULTADOS.
SELECT * FROM persona LIMIT 1;

# Mostrar la última persona registrada en la tabla persona:
SELECT * FROM persona ORDER BY ID DESC LIMIT 1;

# Mostrar a las personas ordenadas de manera Desc por fecha_nac
SELECT * FROM persona ORDER BY fecha_nacimiento DESC;

# Mostrar a las personas nacidas sobre el año 1995.
SELECT * FROM persona WHERE fecha_nacimiento >= '1995-01-01';



