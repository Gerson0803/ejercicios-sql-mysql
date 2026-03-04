-- 1. Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. 
--    El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
SELECT id,nombre,apellido1, apellido2 from cliente where id IN(SELECT DISTINCT(id_cliente) from pedido ) order by nombre;

-- 2. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
--    El resultado debe mostrar todos los datos de los pedidos y del cliente. 
--    El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
SELECT * from cliente c join pedido p on c.id=p.id_cliente order by c.nombre;

-- 3. Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. 
--    El resultado debe mostrar todos los datos de los pedidos y de los comerciales. 
--    El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.
SELECT * from comercial c join pedido p on c.id=p.id_comercial order by c.nombre;

-- 4. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado 
--    y con los datos de los comerciales asociados a cada pedido.
SELECT * 
FROM cliente cl
LEFT JOIN pedido p ON cl.id = p.id_cliente
LEFT JOIN comercial c ON p.id_comercial = c.id;

-- 5. Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, 
--    cuya cantidad esté entre 300 € y 1000 €.
SELECT * 
FROM cliente cl JOIN pedido p ON cl.id = p.id_cliente where  year(p.fecha)=2017 and total between 300 and 1000;

-- 6. Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido 
--    realizado por María Santana Moreno.
SELECT c.nombre, c.apellido1, c.apellido2 
FROM cliente cl
JOIN pedido p ON cl.id = p.id_cliente
JOIN comercial c ON p.id_comercial = c.id WHERE CONCAT_WS(" ",cl.nombre,cl.apellido1,cl.apellido2)="María Santana Moreno";
	
-- 7. Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.
SELECT DISTINCT cl.nombre 
FROM cliente cl
JOIN pedido p ON cl.id = p.id_cliente
JOIN comercial c ON p.id_comercial = c.id 
WHERE CONCAT_WS(" ", c.nombre, c.apellido1, c.apellido2) = "Daniel Sáez Vega";