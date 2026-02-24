-- 1. Calcula el número total de productos que hay en la tabla productos.
SELECT COUNT(*) FROM producto;

-- 2. Calcula el número total de fabricantes que hay en la tabla fabricante.
SELECT COUNT(*) FROM fabricante;

-- 3. Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.
SELECT COUNT(DISTINCT id_fabricante) FROM producto;

-- 4. Calcula la media del precio de todos los productos.
SELECT AVG(precio) AS media_precio FROM producto;

-- 5. Calcula el precio más barato de todos los productos.
SELECT MIN(precio) FROM producto;

-- 6. Calcula el precio más caro de todos los productos.
SELECT MAX(precio) FROM producto;

-- 7. Lista el nombre y el precio del producto más barato.
SELECT nombre, precio 
FROM producto
WHERE precio = (SELECT MIN(precio) FROM producto);

-- 8. Lista el nombre y el precio del producto más caro.
SELECT nombre, precio 
FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto);

-- 9. Calcula la suma de los precios de todos los productos.
SELECT SUM(precio) FROM producto;

-- 10. Calcula el número de productos que tiene el fabricante Asus.
SELECT COUNT(*) 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre = "Asus";

-- 11. Calcula la media del precio de todos los productos del fabricante Asus.
SELECT AVG(p.precio) 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre = "Asus";

-- 12. Calcula el precio más barato de todos los productos del fabricante Asus.
SELECT p.nombre AS nombre_producto,
       f.nombre AS nombre_fabricante,
       p.precio
FROM producto p
JOIN fabricante f ON f.id = p.id_fabricante
WHERE f.nombre = 'Asus'
  AND p.precio = (
      SELECT MIN(precio) 
      FROM producto 
      WHERE id_fabricante = f.id
  );

-- 13. Calcula el precio más caro de todos los productos del fabricante Asus.
SELECT p.nombre AS nombre_producto,
       f.nombre AS nombre_fabricante,
       p.precio
FROM producto p
JOIN fabricante f ON f.id = p.id_fabricante
WHERE f.nombre = 'Asus'
  AND p.precio = (
      SELECT MAX(precio) 
      FROM producto 
      WHERE id_fabricante = f.id
  );

-- 14. Calcula la suma de todos los productos del fabricante Asus.
SELECT SUM(precio) 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE f.nombre = "Asus";

-- 15. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
SELECT MAX(precio) AS "precio_maximo",
       MIN(precio) AS "precio_minimo",
       AVG(precio) AS "precio_medio",
       COUNT(precio) AS "total_productos"
FROM producto p
JOIN fabricante f ON f.id = p.id_fabricante
WHERE f.nombre = 'Crucial';

-- ============================================
-- CONSULTAS RESUMEN CON GROUP BY Y HAVING
-- ============================================

-- 16. Muestra el número total de productos que tiene cada uno de los fabricantes. 
-- El listado también debe incluir los fabricantes que no tienen ningún producto. 
-- El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. 
-- Ordene el resultado descendentemente por el número de productos.
SELECT f.nombre, COUNT(p.id) AS "cantidad_productos"
FROM fabricante f 
LEFT JOIN producto p ON f.id = p.id_fabricante
GROUP BY f.nombre 
ORDER BY COUNT(p.id) DESC;

-- 17. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
-- El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
SELECT f.nombre,
       MAX(p.precio) AS "precio_maximo",
       MIN(p.precio) AS "precio_minimo",
       AVG(p.precio) AS "precio_medio"
FROM fabricante f 
LEFT JOIN producto p ON f.id = p.id_fabricante
GROUP BY f.nombre;

-- 18. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes 
-- que tienen un precio medio superior a 200€. 
-- No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente.
SELECT MAX(p.precio) AS "precio_maximo",
       MIN(p.precio) AS "precio_minimo",
       AVG(p.precio) AS "precio_medio",
       COUNT(p.id) AS "total_productos"
FROM fabricante f 
JOIN producto p ON p.id_fabricante = f.id
GROUP BY f.id
HAVING AVG(p.precio) > 200;

-- 19. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio 
-- y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
-- Es necesario mostrar el nombre del fabricante.
SELECT f.nombre,
       MAX(p.precio) AS "precio_maximo",
       MIN(p.precio) AS "precio_minimo",
       AVG(p.precio) AS "precio_medio",
       COUNT(p.id) AS "total_productos"
FROM fabricante f 
JOIN producto p ON p.id_fabricante = f.id
GROUP BY f.id, f.nombre
HAVING AVG(p.precio) > 200;

-- 20. Calcula el número de productos que tienen un precio mayor o igual a 180€.
SELECT COUNT(*) FROM producto WHERE precio >= 180;

-- 21. Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
SELECT id_fabricante, COUNT(*) AS total_productos 
FROM producto 
WHERE precio >= 180 
GROUP BY id_fabricante;

-- 22. Lista el precio medio de los productos de cada fabricante, mostrando solamente el identificador del fabricante.
SELECT id_fabricante, AVG(precio) AS precio_medio 
FROM producto 
GROUP BY id_fabricante;

-- 23. Lista el precio medio de los productos de cada fabricante, mostrando solamente el nombre del fabricante.
SELECT f.nombre, AVG(p.precio) AS precio_medio 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
GROUP BY f.nombre;

-- 24. Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
SELECT f.nombre, AVG(p.precio) AS promedio_productos 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
GROUP BY f.nombre 
HAVING AVG(p.precio) >= 150;

-- 25. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
SELECT f.nombre, COUNT(p.id) AS cantidad_productos 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
GROUP BY f.nombre 
HAVING COUNT(p.id) >= 2;

-- 26. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno 
-- con un precio superior o igual a 220€. 
-- No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
SELECT f.nombre, COUNT(p.id) AS cantidad_productos 
FROM producto p 
JOIN fabricante f ON f.id = p.id_fabricante 
WHERE p.precio >= 220
GROUP BY f.nombre;

-- 27. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno 
-- con un precio superior o igual a 220€. 
-- El listado debe mostrar el nombre de todos los fabricantes, es decir, 
-- si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ 
-- deberá aparecer en el listado con un valor igual a 0 en el número de productos.
SELECT f.nombre,
       COUNT(CASE WHEN p.precio >= 220 THEN 1 END) AS cantidad_productos
FROM fabricante f
LEFT JOIN producto p ON f.id = p.id_fabricante
GROUP BY f.nombre;

-- 28. Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000€.
SELECT f.nombre,
       SUM(p.precio) AS suma_precios
FROM producto p
JOIN fabricante f ON f.id = p.id_fabricante
GROUP BY f.nombre
HAVING SUM(p.precio) > 1000;

-- 29. Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. 
-- El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. 
-- El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.
SELECT f.nombre AS fabricante,
       p.nombre AS producto,
       p.precio
FROM producto p
JOIN fabricante f ON f.id = p.id_fabricante
WHERE p.precio = (
    SELECT MAX(p2.precio)
    FROM producto p2
    WHERE p2.id_fabricante = f.id
)
ORDER BY f.nombre ASC;