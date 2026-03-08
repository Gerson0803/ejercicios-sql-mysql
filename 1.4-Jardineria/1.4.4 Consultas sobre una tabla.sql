-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina, ciudad from oficina;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select telefono, ciudad from oficina where pais="España";

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1,apellido2,email from empleado where codigo_jefe=7

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email 
FROM empleado 
WHERE codigo_jefe IS NULL;
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1,apellido2,email from empleado where puesto !="Representante Ventas"

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select * from cliente where pais="Spain";

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct(estado) from pedido;

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
-- Utilizando la función YEAR de MySQL.
-- Utilizando la función DATE_FORMAT de MySQL.
-- Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT (codigo_cliente) from pago where year(fecha_pago)=2008;
SELECT DISTINCT (codigo_cliente) from pago where DATE_FORMAT(fecha_pago, '%Y')=2008;
SELECT DISTINCT codigo_cliente
FROM pago
WHERE SUBSTRING(fecha_pago, 1, 4) = '2008';

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha
--de entrega de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido 
WHERE fecha_entrega IS NOT NULL 
  AND fecha_entrega > fecha_esperada;


-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos
	-- cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- Utilizando la función ADDDATE de MySQL.
SELECT p.codigo_pedido,cl.codigo_cliente,p.fecha_entrega,fecha_esperada 
	from pedido p left join cliente cl on cl.codigo_cliente=p.codigo_cliente 
	WHERE fecha_entrega IS NOT NULL 
		AND fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);        
        
-- Utilizando la función DATEDIFF de MySQL.
SELECT p.codigo_pedido,cl.codigo_cliente,p.fecha_entrega,fecha_esperada 
	from pedido p left join cliente cl on cl.codigo_cliente=p.codigo_cliente 
		where p.fecha_entrega IS NOT NULL AND 
        DATEDIFF (p.fecha_esperada,p.fecha_entrega )>2;

-- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?si, de esta forma:  WHERE p.fecha_entrega > p.fecha_esperada + INTERVAL 2 DAY;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select* from pedido where YEAR(fecha_pedido)=2009 and estado="Rechazado";

-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
select * from pedido where Month(fecha_entrega)=1 and estado="Entregado";

-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. 
-- Ordene el resultado de mayor a menor.
SELECT * 
FROM pago 
WHERE YEAR(fecha_pago) = 2008 
  AND forma_pago = "Paypal"
ORDER BY total DESC;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago.Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT(forma_pago) from pago;

-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT * from producto where cantidad_en_stock>100 and gama="Ornamentales" order by precio_venta DESC;

-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT * 
FROM cliente 
WHERE ciudad = 'Madrid' 
  AND (codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30);