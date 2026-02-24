
-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * 
FROM producto 
WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = "Lenovo");

-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo.
-- (Sin utilizar INNER JOIN).
SELECT * 
FROM producto 
WHERE precio = (
    SELECT MAX(precio) 
    FROM producto 
    WHERE id_fabricante = (
        SELECT id 
        FROM fabricante 
        WHERE nombre = "Lenovo"
    )
);

-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre, precio 
FROM producto 
WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = "Lenovo")
ORDER BY precio DESC 
LIMIT 1;

-- 4. Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT nombre 
FROM producto 
WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = "Hewlett-Packard")
ORDER BY precio ASC 
LIMIT 1;

-- 5. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
SELECT *
FROM producto
WHERE precio >= (
    SELECT MAX(precio)
    FROM producto
    WHERE id_fabricante = (
        SELECT id
        FROM fabricante
        WHERE nombre = 'Lenovo'
    )
);

-- 6. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * 
FROM producto p1 
JOIN fabricante f ON p1.id_fabricante = f.id 
WHERE precio > (
    SELECT AVG(precio) 
    FROM producto p2 
    WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = "Asus")
) 
AND f.nombre = "Asus";

-- ============================================
-- SUBCONSULTAS CON ALL Y ANY
-- ============================================

-- 7. Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.
SELECT * 
FROM producto 
WHERE precio >= ALL(SELECT precio FROM producto);

-- 8. Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.
SELECT * 
FROM producto 
WHERE precio <= ALL(SELECT precio FROM producto);

-- 9. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
SELECT nombre 
FROM fabricante 
WHERE id = ANY(SELECT id_fabricante FROM producto);

-- 10. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).
SELECT nombre 
FROM fabricante 
WHERE id != ALL(SELECT id_fabricante FROM producto);

-- ============================================
-- SUBCONSULTAS CON IN Y NOT IN
-- ============================================

-- 11. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre 
FROM fabricante 
WHERE id IN (SELECT id_fabricante FROM producto);

-- 12. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre 
FROM fabricante 
WHERE id NOT IN (SELECT id_fabricante FROM producto);

-- ============================================
-- SUBCONSULTAS CON EXISTS Y NOT EXISTS
-- ============================================

-- 13. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
SELECT nombre 
FROM fabricante f
WHERE EXISTS (
    SELECT 1 
    FROM producto p
    WHERE p.id_fabricante = f.id
);

-- 14. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
SELECT nombre 
FROM fabricante f
WHERE NOT EXISTS (
    SELECT 1 
    FROM producto p
    WHERE p.id_fabricante = f.id
);