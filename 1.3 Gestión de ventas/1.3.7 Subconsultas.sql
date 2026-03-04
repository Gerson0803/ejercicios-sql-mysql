-- 1.3.7.1 Con operadores básicos de comparación
-- 1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).
SELECT * from pedido p where p.id_cliente=(SELECT c.id from cliente c 
	WHERE c.nombre = 'Adela' AND c.apellido1 = 'Salas' AND c.apellido2 = 'Díaz');

-- 2. Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN).
SELECT * from pedido p where p.id_cliente=(SELECT co.id from comercial co where nombre="Salas" AND co.apellido="Sáez" )

-- 3. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN).
SELECT * 
FROM cliente c 
WHERE c.id = (
    SELECT p.id_cliente
    FROM pedido p
    WHERE YEAR(p.fecha) = 2019
      AND p.total = (
          SELECT MAX(p2.total)
          FROM pedido p2
          WHERE YEAR(p2.fecha) = 2019
      )
);

-- 4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.

SELECT p.fecha, p.total
FROM pedido p
WHERE p.id_cliente = (
    SELECT c.id
    FROM cliente c
    WHERE c.nombre = 'Pepe'
      AND c.apellido1 = 'Ruiz'
      AND c.apellido2 = 'Santana'
)
ORDER BY p.total ASC
LIMIT 1;
SELECT p.fecha, p.total FROM pedido p INNER JOIN cliente c ON p.id_cliente = c.id WHERE c.nombre = 'Pepe' AND c.apellido1 = 'Ruiz' AND c.apellido2 = 'Santana' ORDER BY p.total ASC LIMIT 1;

-- 5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que 
-- han realizado un pedido durante el año 2017 
--    con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año.
SELECT p.*,c.* FROM pedido p INNER JOIN cliente c ON p.id_cliente = c.id where year(p.fecha)=2017 and p.total>=
	(SELECT avg(p2.total) from pedido p2 WHERE YEAR(p2.fecha) = 2017);



-- 1.3.7.2 Subconsultas con ALL y ANY
-- 6. Devuelve el pedido más caro que existe en la tabla pedido sin hacer uso de MAX, ORDER BY ni LIMIT.
SELECT *
FROM pedido p
WHERE p.total >= ALL (
    SELECT p2.total
    FROM pedido p2
);

-- 7. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT *
FROM cliente c
WHERE c.id <> ALL (
    SELECT p.id_cliente
    FROM pedido p
);

-- 8. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT *
FROM comercial co
WHERE co.id <> ALL (
    SELECT p.id_comercial
    FROM pedido p
);

-- 1.3.7.3 Subconsultas con IN y NOT IN
-- 9. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT *
FROM cliente c
WHERE c.id NOT IN (
    SELECT p.id_cliente
    FROM pedido p
);

-- 10. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT *
FROM comercial co
WHERE co.id NOT IN (
    SELECT p.id_comercial
    FROM pedido p
);

-- 1.3.7.4 Subconsultas con EXISTS y NOT EXISTS
-- 11. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
SELECT *
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido p
    WHERE p.id_cliente = c.id
);

-- 12. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
SELECT *
FROM comercial co
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido p
    WHERE p.id_comercial = co.id
);
