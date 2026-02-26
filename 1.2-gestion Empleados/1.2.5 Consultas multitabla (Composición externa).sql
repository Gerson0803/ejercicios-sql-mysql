-- 1.Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
Este listado también debe incluir los empleados que no tienen ningún departamento asociado.
SELECT * from  empleado e LEFT JOIN departamento d on e.id_departamento=d.id;

-- 2.Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
SELECT * from  empleado e LEFT JOIN departamento d on e.id_departamento=d.id WHERE d.id IS NULL;

-- 3.Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
SELECT DISTINCT d.nombre
FROM departamento d
LEFT JOIN empleado e ON d.id = e.id_departamento
WHERE e.id IS NULL;

-- 4.Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan.
el listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos 
que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
SELECT *
FROM departamento d
LEFT JOIN empleado e ON d.id = e.id_departamento order by d.nombre;

-- 5.Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que 
no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
-- Empleados sin departamento
SELECT e.id AS empleado_id, e.nombre AS empleado, d.nombre AS departamento
FROM empleado e
LEFT JOIN departamento d ON e.id_departamento = d.id
WHERE e.id_departamento IS NULL

UNION

-- Departamentos sin empleados
SELECT e.id AS empleado_id, e.nombre AS empleado, d.nombre AS departamento
FROM empleado e
RIGHT JOIN departamento d ON e.id_departamento = d.id
WHERE e.id IS NULL

ORDER BY departamento;