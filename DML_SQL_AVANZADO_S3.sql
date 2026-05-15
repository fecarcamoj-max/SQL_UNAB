#### Materia de la S3. Consultas Avanzadas en SQL.
use clase_sql;

SELECT * FROM ventas;

# Muestra las ventas con los datos de la persona.
SELECT * FROM ventas, persona
WHERE ventas.id_persona = persona.id_persona;

# INNER JOIN (Intersección)
SELECT * FROM ventas
INNER JOIN persona 
ON ventas.id_persona = persona.id_persona;

# LEFT JOIN (Unión a la izquierda).
SELECT * FROM ventas as v 
LEFT JOIN persona as p 
ON v.id_persona = p.id_persona;

### EXTRA 
/*
SELECT * FROM persona;
START TRANSACTION; # Iniciar transaccion de manera segura.
DELETE FROM persona WHERE id_persona = 8;
ROLLBACK; # Volver atrás
COMMIT; # Confirmar el cambio
*/
SELECT * FROM persona;
/*
START TRANSACTION;
INSERT INTO persona (nombre, correo, ciudad)
VALUES ("Rob Stark", "rob@stark.cl", "Winterfell");
COMMIT;
*/

# Right Join::::

SELECT * FROM ventas v
RIGHT JOIN persona p
ON p.id_persona = v.id_persona;

# SELF JOIN 
SELECT * FROM persona as p1, persona as p2
WHERE p1.ciudad = p2.ciudad and p1.id_persona != p2.id_persona;
# Hacer parejas con personas que vivan en la misma ciudad.
# Pendiente: No mostrar duplicidad cruzada.
# Forma óptima de hacer un SELF JOIN.
SELECT * FROM persona p1 
INNER JOIN persona p2 
ON p1.ciudad = p2.ciudad and p1.id_persona != p2.id_persona
;

# Operador Sindical : Union...
SELECT * FROM persona p1
UNION # Unir dos tablas y sacar los duplicados. 
SELECT * FROM persona p2;

# Union ALL
SELECT * FROM persona p1
UNION ALL
SELECT * FROM persona p2;

SELECT * FROM ventas;
# Union.
SELECT id_persona, ciudad FROM persona
UNION ALL
SELECT id_persona, cantidad FROM ventas;

# Consulta ANIDADA
SELECT * FROM persona;
SELECT * FROM ventas;

# Muestra a las personas QUE NO TENGAN VENTAS.
SELECT * FROM persona
WHERE id_persona NOT IN  # 3 segundos
	(SELECT id_persona FROM ventas); # 20 segundos.
# Creación de vistas y tablas respaldos
CREATE TABLE id_persona_venta AS
SELECT distinct id_persona FROM ventas;

SELECT * FROM id_persona_venta;

# Consulta optimizada:::
SELECT * FROM persona
WHERE id_persona IN (SELECT id_persona FROM id_persona_venta);

