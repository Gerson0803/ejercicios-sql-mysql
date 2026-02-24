-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT p.nombre, p.precio, f.nombre 
FROM producto AS p 
JOIN fabricante AS f ON f.id = p.id_fabricante;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
-- Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre AS "nombre_producto", p.precio, f.nombre AS "nombre_fabricante" 
FROM producto AS p 
JOIN fabricante AS f ON f.id = p.id_fabricante 
ORDER BY f.nombre ASC;

-- 3. Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, 
-- de todos los productos de la base de datos.
SELECT p.id, p.nombre, f.id, f.nombre 
FROM producto AS p 
JOIN fabricante AS f ON f.id = p.id_fabricante;

-- 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre AS "nombre_producto", p.precio, f.nombre AS "nombre_fabricante" 
FROM producto AS p 
JOIN fabricante AS f ON f.id = p.id_fabricante 
ORDER BY precio 
LIMIT 1;

-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre AS "nombre_producto", p.precio, f.nombre AS "nombre_fabricante" 
FROM producto AS p 
JOIN fabricante AS f ON f.id = p.id_fabricante
WHERE p.precio = (
    SELECT MAX(precio) FROM producto
);

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre LIKE "%Lenovo%";

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT * 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre LIKE "%Crucial%" AND p.precio > 200;

-- 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. 
-- Sin utilizar el operador IN.
SELECT * 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre LIKE "%Asus%" OR
      f.nombre LIKE "%Hewlett-Packard%" OR
      f.nombre LIKE "%Seagate%";

-- 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. 
-- Utilizando el operador IN.
SELECT * 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre IN ("Asus", "Hewlett-Packard", "Seagate");

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
SELECT f.id, p.id, p.nombre AS "nombre_producto", p.precio 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre LIKE "%e";

-- 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT f.id,
       p.nombre AS "nombre_producto",
       p.precio,
       f.nombre AS "nombre_fabricante"
FROM producto AS p
JOIN fabricante AS f ON f.id = p.id_fabricante
WHERE LOWER(TRIM(f.nombre)) LIKE '%w%';

-- 12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. 
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre AS "nombre_producto",
       p.precio,
       f.nombre AS "nombre_fabricante"
FROM producto AS p
JOIN fabricante AS f ON f.id = p.id_fabricante
WHERE p.precio >= 180 
ORDER BY p.precio DESC, p.nombre ASC;

-- 13. Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT DISTINCT
       f.id AS "identificador_fabricante",
       f.nombre AS "nombre_fabricante"
FROM producto AS p
JOIN fabricante AS f ON f.id = p.id_fabricante;