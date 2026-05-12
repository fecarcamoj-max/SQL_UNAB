DROP DATABASE diplomado_unab;
CREATE DATABASE diplomado_unab;
SHOW TABLES FROM diplomado_unab;

use diplomado_unab;
## DDL DATA DEFINITI LANGUAGE
CREATE TABLE persona(
	id bigint Primary key auto_increment,
    nombre varchar(20) NOT NULL,# Texto de 20 caracteres
	apellido varchar(30) NOT NULL, #Texto de 30 caracteres.
    descripcion TEXT, # Texto más largo (+ 1000)
    resumen_labor LONGTEXT,
    fecha_nacimiento DATE, # YYYY-MM-DD #ej: 2026-05-12
    fecha_hora_ingreso DATETIME, # YYYY-MM-DD HH:mm:ss
    puntaje double, # Número real - número con decimales: ej: 20.5555555555...
    calificacion decimal(2) #Número con 2 decimales. 20.56988
);
