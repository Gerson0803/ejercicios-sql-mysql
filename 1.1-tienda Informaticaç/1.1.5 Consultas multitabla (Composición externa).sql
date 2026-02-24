-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT *
FROM fabricante AS f 
LEFT JOIN producto AS p ON f.id = p.id_fabricante;

-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT *
FROM fabricante AS f 
LEFT JOIN producto AS p ON f.id = p.id_fabricante
WHERE p.id IS NULL;

-- 3. ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.
-- RESPUESTA: 
-- No, porque existe una restricción FOREIGN KEY que obliga a que cada producto tenga un id_fabricante válido
-- que exista en la tabla fabricante. Sin esta restricción, solo sería posible si:
-- 1. Se hizo una inserción forzada deshabilitando las restricciones de integridad referencial
-- 2. Se insertaron datos antes de crear la relación entre las tablas
-- 3. Se eliminó un fabricante sin eliminar sus productos (lo cual también violaría la integridad referencial)
-- En condiciones normales con la FOREIGN KEY activa, es imposible ingresar un producto sin un fabricante válido.