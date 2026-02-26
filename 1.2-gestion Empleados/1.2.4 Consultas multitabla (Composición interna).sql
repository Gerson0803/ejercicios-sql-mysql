1.2.4 Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

-- 1.Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
SELECT * FROM empleado e join departamento d where e.id_departamento=d.id

-- 2.Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, 
en primer lugar por el nombre del departamento (en orden alfabético) y 
en segundo lugar por los apellidos y el nombre de los empleados.
SELECT * FROM empleado e join departamento d on e.id_departamento=d.id order by d.nombre ,CONCAT_WS(' ', e.apellido1, e.apellido2),e.nombre

-- 3.Devuelve un listado con el identificador y el nombre del departamento, 
solamente de aquellos departamentos que tienen empleados.
SELECT distinct d.id,d.nombre from departamento d join empleado e on e.id_departamento=d.id;

-- 4.Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto 
actual del que dispone, solamente de aquellos departamentos que tienen empleados. 
El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial 
(columna presupuesto) el valor de los gastos que ha generado (columna gastos).
SELECT distinct d.id,d.nombre,(d.presupuesto-d.gastos) AS presupuesto_actual from departamento d 
	join empleado e on d.id=e.id_departamento;

-- 5.Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
SELECT d.nombre from departamento d join empleado e on d.id=e.id_departamento where nif="38382980M";

-- 6.Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
SELECT d.nombre from departamento d join empleado e on d.id=e.id_departamento 
	where concat_ws(' ',e.nombre,e.apellido1,apellido2)="Pepe Ruiz Santana"

-- 7.Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. 
Ordena el resultado alfabéticamente.
SELECT * FROM empleado e join departamento d on d.id=e.id_departamento WHERE d.nombre="I+D" order by e.nombre;

-- 8.Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas,
 Contabilidad o I+D. Ordena el resultado alfabéticamente.
SELECT * FROM empleado e join departamento d on d.id=e.id_departamento 
	WHERE d.nombre="I+D" or 
		  d.nombre="Sistemas" or
          d.nombre="Contabilidad"order by e.nombre;

-- 9.Devuelve una lista con el nombre de los empleados que tienen los 
departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
SELECT * FROM empleado e join departamento d on d.id=e.id_departamento 
	WHERE presupuesto NOT between 100000 AND 200000;

-- 10.Devuelve un listado con el nombre de los departamentos donde existe algún empleado 
cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
SELECT DISTINCT (d.nombre) FROM empleado e join departamento d on d.id=e.id_departamento where apellido2 IS NULL;