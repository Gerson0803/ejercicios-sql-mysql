--1.2.7.1 Con operadores básicos de comparación
-- 1.Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).
SELECT * from empleado where id_departamento=(SELECT id from departamento where nombre="Sistemas");

-- 2.Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.
SELECT nombre,presupuesto from departamento 
	order by presupuesto DESC limit 1 ; 
    
-- 3.Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
SELECT nombre,presupuesto from departamento 
	order by presupuesto ASC limit 1 ; 

--1.2.7.2 Subconsultas con ALL y ANY
-- 4.Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. 
Sin hacer uso de MAX, ORDER BY ni LIMIT.
SELECT nombre, presupuesto 
FROM departamento d1
WHERE presupuesto > ALL (
    SELECT presupuesto 
    FROM departamento d2 
    WHERE d2.id <> d1.id
);

-- 5.Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MIN, ORDER BY ni LIMIT.
SELECT nombre, presupuesto 
FROM departamento d1
WHERE presupuesto < ALL (
    SELECT presupuesto 
    FROM departamento d2 
    WHERE d2.id <> d1.id AND d2.presupuesto IS NOT NULL
);

-- 6.Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).
SELECT nombre 
FROM departamento d
WHERE d.id = ANY (SELECT id_departamento FROM empleado);

-- 7.Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando ALL o ANY).
SELECT nombre 
FROM departamento d
WHERE d.id <> ALL (SELECT id_departamento FROM empleado);

--1.2.7.3 Subconsultas con IN y NOT IN
-- 8.Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).
	SELECT nombre from departamento where id IN(SELECT id_departamento from empleado WHERE id_departamento IS NOT NULL);
-- 9.Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).
	SELECT nombre from departamento where id NOT IN(SELECT id_departamento from empleado WHERE id_departamento IS NOT NULL);

--1.2.7.4 Subconsultas con EXISTS y NOT EXISTS
-- 10.Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).
SELECT nombre 
FROM departamento d
WHERE EXISTS (
    SELECT 1 
    FROM empleado e 
    WHERE e.id_departamento = d.id
);

-- 11.Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).
SELECT nombre 
FROM departamento d
WHERE NOT EXISTS (
    SELECT 1 
    FROM empleado e 
    WHERE e.id_departamento = d.id
);