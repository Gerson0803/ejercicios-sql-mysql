-- 1.4.6 Consultas multitabla (Composición externa)

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago
select * from cliente c left join pago p on p.codigo_cliente=c.codigo_cliente where id_transaccion IS NULL;

-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido
select * from cliente c left join pedido p on p.codigo_cliente=c.codigo_cliente where p.codigo_pedido IS NULL ;

-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y 
los que no han realizado ningún pedido
select * from cliente c left join pago p on p.codigo_cliente=c.codigo_cliente left join pedido pe on pe.codigo_cliente=c.codigo_cliente 
	where id_transaccion IS NULL and pe.codigo_pedido IS NULL;

-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada
select e.* from empleado e left join oficina o on o.codigo_oficina=e.codigo_oficina where o.codigo_oficina IS NULL;

-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado
SELECT e.*
FROM empleado e
LEFT JOIN cliente cl 
    ON e.codigo_empleado = cl.codigo_empleado_rep_ventas
WHERE cl.codigo_cliente IS NULL;

-- 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto 
con los datos de la oficina donde trabajan
SELECT e.*, o.*
FROM empleado e
LEFT JOIN cliente cl 
    ON e.codigo_empleado = cl.codigo_empleado_rep_ventas
LEFT JOIN oficina o on e.codigo_oficina=o.codigo_oficina
WHERE cl.codigo_cliente IS NULL;

-- 7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y 
los que no tienen un cliente asociado
SELECT e.* 
FROM empleado e 
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente cl ON cl.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE cl.codigo_cliente IS NULL 
   OR e.codigo_oficina IS NULL;
    
-- 8. Devuelve un listado de los productos que nunca han aparecido en un pedido
SELECT pr.*
FROM producto pr
LEFT JOIN detalle_pedido dp 
    ON pr.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

-- 9. Devuelve un listado de los productos que nunca han aparecido en un pedido. 
El resultado debe mostrar el nombre, la descripción y la imagen del producto
SELECT pr.nombre, gm.descripcion_html, gm.imagen
FROM producto pr
LEFT JOIN detalle_pedido dp 
    ON pr.codigo_producto = dp.codigo_producto
LEFT JOIN gama_producto gm 
    ON pr.gama = gm.gama
WHERE dp.codigo_producto IS NULL;

-- 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido 
los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales
SELECT o.*
FROM oficina o
WHERE o.codigo_oficina NOT IN (
    SELECT DISTINCT e.codigo_oficina
    FROM empleado e
    JOIN cliente c 
        ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    JOIN pedido p 
        ON c.codigo_cliente = p.codigo_cliente
    JOIN detalle_pedido dp 
        ON p.codigo_pedido = dp.codigo_pedido
    JOIN producto pr 
        ON dp.codigo_producto = pr.codigo_producto
    WHERE pr.gama = 'Frutales'
);

-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago
SELECT DISTINCT c.* 
FROM cliente c 
JOIN pedido p ON p.codigo_cliente = c.codigo_cliente 
LEFT JOIN pago pa ON pa.codigo_cliente = c.codigo_cliente 
WHERE pa.codigo_cliente IS NULL;

-- 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado
SELECT e.*, j.nombre AS nombre_jefe
FROM empleado e
LEFT JOIN cliente c 
    ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN empleado j 
    ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_cliente IS NULL;