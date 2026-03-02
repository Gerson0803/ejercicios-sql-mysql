--1. Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. 
--    Este listado también debe incluir los clientes que no han realizado ningún pedido. 
--    El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.
SELECT * FROM cliente c left join pedido p on c.id=p.id_cliente order by c.apellido1,c.apellido2,c.nombre

--2. Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. 
--    Este listado también debe incluir los comerciales que no han realizado ningún pedido. 
--    El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.
SELECT * FROM comercial c left join pedido p on c.id=p.id_comercial order by c.apellido1,c.apellido2,c.nombre

--3. Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
SELECT * FROM cliente c left join pedido p on c.id=p.id_cliente where p.id IS NULL;

--4. Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
SELECT * FROM comercial c left join pedido p on c.id=p.id_comercial where p.id IS NULL

--5. Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. 
--    Ordene el listado alfabéticamente por los apellidos y el nombre. 
--    En el listado deberá diferenciar de algún modo los clientes y los comerciales.
SELECT 'CLIENTE' AS tipo, c.apellido1, c.apellido2, c.nombre 
    FROM cliente c LEFT JOIN pedido 
    p ON c.id = p.id_cliente WHERE p.id IS 
    NULL UNION SELECT 'COMERCIAL' AS tipo, co.apellido1, co.apellido2,
co.nombre FROM comercial co LEFT JOIN pedido p ON co.id = p.id_comercial 
WHERE p.id IS NULL 
ORDER BY apellido1, apellido2, nombre;

--6. ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.
-- Técnicamente sí, porque NATURAL JOIN une tablas por columnas con el mismo nombre. -- Sin embargo, no es recomendable: puede generar ambigüedad 
--si hay columnas iguales  que no representan la misma relación. -- Es más claro y seguro usar LEFT JOIN o 
--RIGHT JOIN con ON.