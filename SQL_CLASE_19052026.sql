use clase_sql;

SELECT * FROM inventario; # Maestra Productos.
SELECT * FROM persona; # Maestra Clientes
SELECT * FROM ventas; # Ventas

### Mostrar Producto que se vendió (nombre) junto con 
### La persona que lo compró (nombre).
SELECT * FROM ventas as v
INNER JOIN inventario as i ON i.id_producto = v.id_producto
INNER JOIN persona as p ON p.id_persona = v.id_persona
;

# Agrupamiento - Group By (2 tablas... > 2)

# Mostrar el producto que más se vendió:
SELECT i.nombre_producto, SUM(v.cantidad), i.precio 
FROM ventas as v 
INNER JOIN inventario as i ON i.id_producto = v.id_producto
GROUP BY i.nombre_producto
ORDER BY SUM(v.cantidad) DESC
LIMIT 1
;
SELECT * FROM ventas where id_producto = 2;
SELECT * FROM inventario;
# Mostrar el producto que menos se vendió y mostrar 
# quienes compraron (nombre): ########## Pendiente por Terminar.
SELECT i.nombre_producto, SUM(v.cantidad), GROUP_CONCAT(p.nombre) 
FROM ventas v
INNER JOIN inventario as i ON v.id_producto = i.id_producto
INNER JOIN persona as p ON v.id_persona = p.id_persona
GROUP BY i.nombre_producto
ORDER BY SUM(v.cantidad) DESC;

# Mismo ejercicio anterior pero por categoría:
SELECT i.categoria, SUM(v.cantidad), GROUP_CONCAT(p.nombre) 
FROM ventas v
INNER JOIN inventario as i ON v.id_producto = i.id_producto
INNER JOIN persona as p ON v.id_persona = p.id_persona
GROUP BY i.categoria
ORDER BY SUM(v.cantidad) DESC;


### Crear respaldos de tablas en otras bases de datos.