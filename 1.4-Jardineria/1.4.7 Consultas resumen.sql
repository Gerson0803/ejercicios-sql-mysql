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
