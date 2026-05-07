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

