--1. Devuelve un listado con todos los pedidos que se han realizado. 
--   Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.
SELECT * FROM pedido order by fecha DESC;

--2. Devuelve todos los datos de los dos pedidos de mayor valor.
SELECT * from pedido order by total DESC limit 2;

--3. Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. 
--   Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
SELECT DISTINCT(id_cliente) FROM pedido; 

--4. Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, 
--   cuya cantidad total sea superior a 500€.
SELECT * FROM pedido WHERE YEAR(fecha) = 2017 AND total > 500;

--5. Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.
SELECT nombre,apellido1,apellido2 from comercial where comision between 0.05 and 0.11;

--6. Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.
SELECT MAX(comision) as valor_mayor_comision from comercial

--7. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. 
--   El listado deberá estar ordenado alfabéticamente por apellidos y nombre.
select id,nombre,apellido1 from cliente where apellido2 IS NOT NULL order by apellido1,nombre;

--8. Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n 
--   y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.
SELECT nombre from cliente where nombre like "A%" and nombre like"%n" OR nombre like "P%" order by nombre 

--9. Devuelve un listado de los nombres de los clientes que no empiezan por A. 
--   El listado deberá estar ordenado alfabéticamente.
SELECT nombre from cliente where nombre NOT like "A%"  order by nombre 

--10. Devuelve un listado con los nombres de los comerciales que terminan por “o” o “O”. 
--    Tenga en cuenta que se deberán eliminar los nombres repetidos.
SELECT DISTINCT (nombre) from comercial where nombre like "%o"  order by nombre 