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

SELECT * FROM persona;
START TRANSACTION;
DELETE FROM persona WHERE id_persona = 8;
ROLLBACK;