--1. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
SELECT SUM(total) as total_ventas_pedidos from pedido;

--2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT AVG(total) promedio_ventas from pedido as ;

--3. Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
SELECT COUNT(DISTINCT(id_comercial)) as total_comerciales from pedido; 

--4. Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT COUNT(id) as total_clientes from cliente;

--5. Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT MAX(total) as mayor_cantidad from pedido; 

--6. Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT MIN(total) as menor_cantidad from pedido; 

--7. Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
SELECT MAX(categoria),ciudad from cliente group by ciudad;

--8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. 
--   Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. 
--   Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. 
--   Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.
SELECT c.id AS id_cliente,
       c.nombre,
       c.apellido1,
       c.apellido2,
       p.fecha,
       p.total
FROM cliente c
JOIN pedido p 
  ON c.id = p.id_cliente
WHERE p.total = (
    SELECT MAX(p2.total)
    FROM pedido p2
    WHERE p2.id_cliente = c.id
      AND p2.fecha = p.fecha
)
ORDER BY c.id, p.fecha;

--9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, 
--   teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.
SELECT c.id AS id_cliente,
       c.nombre,
       c.apellido1,
       c.apellido2,
       p.fecha,
       p.total
FROM cliente c
JOIN pedido p 
 ON c.id = p.id_cliente
 WHERE p.total = (
 SELECT MAX(p2.total) from pedido p2 where p2.id_cliente=c.id and p2.fecha=p.fecha
 ) and p.total>2000;
 
--10. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. 
--    Muestra el identificador del comercial, nombre, apellidos y total.
SELECT co.id AS id_comercial,
       co.nombre,
       co.apellido1,
       co.apellido2,
       p.fecha,
       p.total
FROM comercial co
JOIN pedido p 
 ON co.id = p.id_comercial
WHERE p.fecha="2016-08-17" AND p.total=(
	SELECT MAX(p2.total) from pedido p2 where p2.id_comercial=co.id and p.fecha = p2.fecha
)


--11. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. 
--    Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. 
--    Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.
SELECT c.id,c.nombre,c.apellido1,c.apellido2, COUNT(p.id) as pedidos_realizados from cliente c 
	left join pedido p on c.id=p.id_cliente	
		group by c.id,c.nombre,c.apellido1,c.apellido2; 

--12. Devuelve un listado con el identificador de cliente, nombre y apellidos y 
el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.
SELECT c.id,c.nombre,c.apellido1,c.apellido2,COUNT(p.id) as pedidos_2017 from cliente c
	left join pedido p on c.id=p.id_cliente where year(p.fecha)=2017
    group by c.id,c.nombre,c.apellido1,c.apellido2;

--13. Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido
 -- y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. 
--    El resultado debe mostrar aquellos clientes que no han realizado ningún pedido 
--indicando que la máxima cantidad de sus pedidos realizados es 0. 
--    Puede hacer uso de la función IFNULL.
SELECT c.id,
       c.nombre,
       c.apellido1,
       IFNULL(MAX(p.total), 0) AS maximo_valor_pedido
FROM cliente c
LEFT JOIN pedido p 
  ON c.id = p.id_cliente
GROUP BY c.id, c.nombre, c.apellido1;


--14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
SELECT year(p.fecha)as año,max(p.total) as max_total from pedido p group by year(p.fecha) 
--15. Devuelve el número total de pedidos que se han realizado cada año.
SELECT year(p.fecha) as año , COUNT(DISTINCT(p.id)) as total_pedidos_año from pedido p group by year(p.fecha)
