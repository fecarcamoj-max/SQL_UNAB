use clase_sql;

SELECT * FROM id_persona_venta;
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

### Crear respaldos de tablas en otras bases de datos.