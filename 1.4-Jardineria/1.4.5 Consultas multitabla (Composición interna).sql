--1.4.5 Consultas multitabla (Composición interna)
-- 1. Devuelve un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas
select c.nombre_cliente, e.nombre as nombre_RDV, e.apellido1 as apellido_RDV from empleado e join cliente c on 
	e.codigo_empleado=codigo_empleado_rep_ventas where puesto='Representante Ventas';

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas
SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
JOIN pago pag ON c.codigo_cliente = pag.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado where puesto='Representante Ventas';

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
LEFT JOIN pago pag ON c.codigo_cliente = pag.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE pag.codigo_cliente IS NULL;

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes 
junto con la ciudad de la oficina a la que pertenece el representante
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
JOIN pago pag ON c.codigo_cliente = pag.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
    
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes
 junto con la ciudad de la oficina a la que pertenece el representante
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
LEFT JOIN pago pag ON c.codigo_cliente = pag.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE pag.codigo_cliente IS NULL;

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada
SELECT DISTINCT o.linea_direccion1
FROM oficina o
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada';

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes 
junto con la ciudad de la oficina a la que pertenece el representante
SELECT c.nombre_cliente,e.nombre as nombre_representante, o.ciudad
  from cliente  c 
	join empleado e on e.codigo_empleado=c.codigo_empleado_rep_ventas
	join oficina o on o.codigo_oficina=e.codigo_oficina
    where puesto ='Representante Ventas';
    
-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes
SELECT e.nombre AS empleado,
       j.nombre AS jefe
FROM empleado e
LEFT JOIN empleado j
       ON e.codigo_jefe = j.codigo_empleado;

-- 9. Devuelve un listado que muestre el nombre de cada empleado, el nombre de su jefe y el nombre del jefe de su jefe
SELECT e.nombre AS empleado,
       j.nombre AS jefe,
       jj.nombre AS jefe_del_jefe
FROM empleado e
LEFT JOIN empleado j
       ON e.codigo_jefe = j.codigo_empleado
LEFT JOIN empleado jj
       ON j.codigo_jefe = jj.codigo_empleado;

-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido
SELECT DISTINCT cl.nombre_cliente from cliente cl join pedido p on p.codigo_cliente = cl.codigo_cliente
	Where fecha_entrega>fecha_esperada;

-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente
SELECT DISTINCT cl.nombre_cliente, pr.gama
FROM cliente cl 
JOIN pedido pe ON pe.codigo_cliente = cl.codigo_cliente
JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
ORDER BY cl.nombre_cliente, pr.gama;