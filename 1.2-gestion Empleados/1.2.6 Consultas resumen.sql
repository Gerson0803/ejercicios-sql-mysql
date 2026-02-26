-- 1.Calcula la suma del presupuesto de todos los departamentos.
SELECT SUM(presupuesto) as suma_presupuesto from departamento;

-- 2.Calcula la media del presupuesto de todos los departamentos.
SELECT AVG(presupuesto) as media_presupuesto from departamento;

-- 3.Calcula el valor mínimo del presupuesto de todos los departamentos.
SELECT MIN(presupuesto) as presupuesto_mas_bajo from departamento;

-- 4.Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
SELECT id,nombre,presupuesto as presupuesto_mas_bajo from departamento where presupuesto=(SELECT MIN(presupuesto) from departamento);

-- 5.Calcula el valor máximo del presupuesto de todos los departamentos.
SELECT MAX(presupuesto) as presupuesto_mas_bajo from departamento;

-- 6.Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
SELECT id,nombre,presupuesto as presupuesto_mas_bajo from departamento where presupuesto=(SELECT MAX(presupuesto) from departamento);

-- 7.Calcula el número total de empleados que hay en la tabla empleado.
SELECT COUNT(*) from empleado;

-- 8.Calcula el número de empleados que no tienen NULL en su segundo apellido.
SELECT COUNT(*) from empleado where apellido2 IS NOT NULL;

-- 9.Calcula el número de empleados que hay en cada departamento. 
Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de 
empleados que tiene asignados.
SELECT d.nombre,COUNT(id_departamento) as numero_empleados from  empleado e JOIN departamento d on e.id_departamento=d.id group by id_departamento;

-- 10.Calcula el nombre de los departamentos que tienen más de 2 empleados. 
El resultado debe tener dos columnas, una con el nombre del departamento y otra con el número de empleados 
que tiene asignados.
SELECT d.nombre,COUNT(id_departamento) as numero_empleados 
		from  empleado e JOIN departamento d on e.id_departamento=d.id group by id_departamento 
		HAVING COUNT(id_departamento)>2;

-- 11.Calcula el número de empleados que trabajan en cada uno de los departamentos. 
El resultado de esta consulta también tiene que incluir aquellos departamentos
que no tienen ningún empleado asociado.
SELECT d.nombre,COUNT(id_departamento) as numero_empleados 
		from  departamento d LEFT JOIN  empleado e on e.id_departamento=d.id group by id_departamento,d.nombre;

-- 12.Calcula el número de empleados que trabajan en cada unos de los 
departamentos que tienen un presupuesto mayor a 200000 euros.
SELECT d.nombre,COUNT(id_departamento) as cantidad_empleados from departamento d join empleado e on e.id_departamento=d.id 
	WHERE d.presupuesto>200000 group by d.nombre;