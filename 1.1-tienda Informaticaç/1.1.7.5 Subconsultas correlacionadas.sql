-- ============================================
-- SUBCONSULTAS CORRELACIONADAS
-- ============================================

-- 15. Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
SELECT f.nombre AS fabricante,
       p.nombre AS producto,
       p.precio
FROM fabricante f 
JOIN producto p ON f.id = p.id_fabricante
WHERE p.precio = (
    SELECT MAX(p2.precio) 
    FROM producto p2 
    WHERE p2.id_fabricante = f.id
);

-- 16. Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.
SELECT f.nombre AS fabricante,
       p.nombre AS producto,
       p.precio
FROM fabricante f 
JOIN producto p ON f.id = p.id_fabricante
WHERE p.precio >= (
    SELECT AVG(p2.precio) 
    FROM producto p2 
    WHERE p2.id_fabricante = f.id
);

-- 17. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT f.nombre AS fabricante,
       p.nombre AS producto,
       p.precio
FROM producto p
JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Lenovo'
  AND p.precio = (
      SELECT MAX(p2.precio)
      FROM producto p2
      WHERE p2.id_fabricante = f.id
  );

-- ============================================
-- SUBCONSULTAS (En la cláusula HAVING)
-- ============================================

-- 18. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT f.nombre, COUNT(*) AS total_productos
FROM producto p
JOIN fabricante f ON f.id = p.id_fabricante
GROUP BY f.nombre
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM producto p2
    JOIN fabricante f2 ON f2.id = p2.id_fabricante
    WHERE f2.nombre = 'Lenovo'
);