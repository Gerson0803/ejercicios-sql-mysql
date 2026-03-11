-- 1.4.7 Consultas resumen
-- 1. ¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) from empleado; 

-- 2. ¿Cuántos clientes tiene cada país?
SELECT pais,count(*) as cantidad from cliente group by pais;

-- 3. ¿Cuál fue el pago medio en 2009?
select avg(total) as AVG_2009 from pago where year(fecha_pago)=2009;

-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT estado,count(*) as cantidad from pedido group by estado;

-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MAX(precio_venta) as mas_caro, MIN(precio_venta) as mas_barato from producto;

-- 6. Calcula el número de clientes que tiene la empresa.
SELECT  COUNT(codigo_cliente) as total_clientes from cliente;

-- 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
SELECT  COUNT(codigo_cliente) as total_clientes from cliente where ciudad='Madrid';

-- 8. Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M.
select ciudad, count(*) as clientes from cliente where ciudad like "M%" group by ciudad;

-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
select codigo_empleado_rep_ventas, count(codigo_cliente) from cliente group by codigo_empleado_rep_ventas ;

-- 10. Calcula el número de clientes que no tiene asignado representante de ventas.
select COUNT(*) as cliente_sin_codigo_empleado_rep_ventas from cliente where codigo_empleado_rep_ventas IS NULL;

-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
El listado deberá mostrar el nombre y los apellidos de cada cliente.
SELECT cl.codigo_cliente,nombre_cliente,MAX(fecha_pago) as mas_reciente,MIN(fecha_pago) as mas_antigua
 from cliente cl join pago p on p.codigo_cliente= cl.codigo_cliente group by cl.codigo_cliente;

-- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT p.codigo_pedido,COUNT(DISTINCT codigo_producto) as productos_distintos FROM pedido p join detalle_pedido dp on p.codigo_pedido=dp.codigo_pedido 
	group by p.codigo_pedido;

-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
SELECT p.codigo_pedido, SUM(dp.cantidad) AS cantidad_total
FROM pedido p 
JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido 
GROUP BY p.codigo_pedido;

-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se 
han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT pr.nombre, 
       SUM(dp.cantidad) AS unidades_vendidas
FROM detalle_pedido dp
JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
GROUP BY dp.codigo_producto, pr.nombre
ORDER BY unidades_vendidas DESC
LIMIT 20;

-- 15. La facturación que ha tenido la empresa en toda la historia, 
indicando la base imponible, el IVA y el total facturado.
SELECT SUM(precio_unidad * cantidad) AS base_imponible,
       SUM(precio_unidad * cantidad) * 0.21 AS iva,
       SUM(precio_unidad * cantidad) * 1.21 AS total_facturado
	FROM pedido p join detalle_pedido dp on p.codigo_pedido=dp.codigo_pedido;

-- 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
SELECT codigo_producto,SUM(precio_unidad * cantidad) AS base_imponible,
       SUM(precio_unidad * cantidad) * 0.21 AS iva,
       SUM(precio_unidad * cantidad) * 1.21 AS total_facturado
	FROM detalle_pedido dp  group by codigo_producto;

-- 17. La misma información que en la pregunta anterior, pero agrupada por código de producto
 filtrada por los códigos que empiecen por OR.
SELECT codigo_producto,SUM(precio_unidad * cantidad) AS base_imponible,
       SUM(precio_unidad * cantidad) * 0.21 AS iva,
       SUM(precio_unidad * cantidad) * 1.21 AS total_facturado
	FROM detalle_pedido dp  where codigo_producto like "Or%" group by codigo_producto;

-- 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. 
Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
SELECT p.nombre, 
       SUM(dp.cantidad) AS unidades_vendidas,
       SUM(dp.precio_unidad * dp.cantidad) AS base_imponible,
       SUM(dp.precio_unidad * dp.cantidad) * 0.21 AS iva,
       SUM(dp.precio_unidad * dp.cantidad) * 1.21 AS total_facturado
FROM detalle_pedido dp 
JOIN producto p ON p.codigo_producto = dp.codigo_producto 
GROUP BY p.codigo_producto, p.nombre
HAVING SUM(dp.precio_unidad * dp.cantidad) > 3000;

-- 19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que 
aparecen en la tabla pagos.
SELECT YEAR(fecha_pago) AS año,
       SUM(total) AS suma_total_pagos
FROM pago 
GROUP BY YEAR(fecha_pago)
ORDER BY año;