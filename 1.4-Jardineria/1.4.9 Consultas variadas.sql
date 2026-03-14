-- 1.4.9 Consultas variadas
-- 1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. 
--    Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
SELECT nombre_cliente, COUNT(p.codigo_pedido) AS cantidad_pedidos 
FROM cliente cl 
LEFT JOIN pedido p ON p.codigo_cliente = cl.codigo_cliente
GROUP BY cl.codigo_cliente, cl.nombre_cliente;


-- 2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. 
--    Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
SELECT cl.codigo_cliente,COALESCE(SUM(p.total), 0)
 as total_pagado from cliente cl left join pago p on  
	p.codigo_cliente=cl.codigo_cliente group by cl.codigo_cliente;

-- 3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
SELECT cl.nombre_cliente,
       cl.codigo_cliente
FROM cliente cl
JOIN pedido pe 
       ON pe.codigo_cliente = cl.codigo_cliente
WHERE YEAR(pe.fecha_pedido) = 2008
GROUP BY cl.codigo_cliente, cl.nombre_cliente
ORDER BY cl.nombre_cliente ASC;

-- 4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas 
--y el número de teléfono de la oficina del representante de ventas, 
de aquellos clientes que no hayan realizado ningún pago.
SELECT cl.nombre_cliente,
       e.nombre AS nombre_representante,
       e.apellido1,
       o.telefono
       from cliente cl join empleado e ON cl.codigo_empleado_rep_ventas = e.codigo_empleado
join oficina o 
       ON e.codigo_oficina = o.codigo_oficina
       WHERE cl.codigo_cliente NOT IN (
    SELECT p.codigo_cliente
    FROM pago p
);

-- 5. Devuelve el listado de clientes donde aparezca el nombre del cliente,
-- el nombre y primer apellido de su representante de ventas 
--    y la ciudad donde está su oficina.
SELECT cl.nombre_cliente,
       e.nombre AS nombre_representante,
       e.apellido1,
       o.ciudad 
FROM cliente cl 
JOIN empleado e ON cl.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de 
-- aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre,
       e.apellido1,
       e.apellido2,  -- ✅ Faltaba
       e.puesto,      -- ✅ Faltaba
       o.telefono     -- ✅ No codigo_oficina
FROM empleado e 
LEFT JOIN cliente cl ON cl.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
WHERE cl.codigo_empleado_rep_ventas IS NULL;

-- 7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
SELECT o.ciudad, COUNT(e.codigo_empleado) AS cantidad_empleados 
FROM oficina o 
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
GROUP BY o.ciudad;