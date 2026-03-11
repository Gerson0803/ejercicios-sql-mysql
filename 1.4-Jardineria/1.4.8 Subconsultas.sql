-- 1.4.8 Subconsultas

-- 1.4.8.1 Con operadores básicos de comparación
-- 1.Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente FROM cliente where limite_credito=(
	select max(limite_credito) from cliente
);

-- 2.Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre FROM producto where precio_venta= (
	SELECT MAX(precio_venta) from producto
);

-- 3.Devuelve el nombre del producto del que se han vendido más unidades. 
-- (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)
SELECT nombre
FROM producto
WHERE codigo_producto = (
    SELECT codigo_producto
    FROM detalle_pedido
    GROUP BY codigo_producto
    ORDER BY SUM(cantidad) DESC
    LIMIT 1
);


-- 4.Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. 
-- (Sin utilizar INNER JOIN).
SELECT nombre_cliente, limite_credito
FROM cliente c
WHERE limite_credito > (
    SELECT SUM(total)
    FROM pago p
    WHERE p.codigo_cliente = c.codigo_cliente
);



-- 5. Devuelve el producto que más unidades tiene en stock.
SELECT * from producto where cantidad_en_stock=(
	SELECT max(cantidad_en_stock)  from producto
);

-- 6. Devuelve el producto que menos unidades tiene en stock.
SELECT * from producto where cantidad_en_stock=(
	SELECT min(cantidad_en_stock)  from producto
);

-- 7.Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
);