CREATE DATABASE ejemplo_unab;
USE ejemplo_unab;

CREATE TABLE persona(
	id bigint PRIMARY KEY auto_increment,
    nombre text
);

CREATE TABLE ventas(
	id bigint PRIMARY KEY auto_increment,
    producto text,
    total_dinero double,
    id_persona bigint, # Campo Nuevo Que guardará el valor del ID de la tabla persona.
    foreign key (id_persona) references persona(id)
);