-- CONSULTAS CON FUNCIONES DE AGREGACIÓN (9-12):

-- 9.Cuenta cuántos pacientes diferentes ha atendido cada doctor
SELECT d.nombre as id_doctor,count(DISTINCT p.id) as pacientes_distintos from paciente p 
	join cita_medica cm on p.id=cm.id_paciente
    join doctor d  on d.id=cm.id_doctor group by d.id;

-- 10.Muestra el número total de citas agrupadas por estado (pendiente/realizada/cancelada)
select estado,count(id) from cita_medica group by estado;

-- 11.Cuenta cuántas hospitalizaciones ha tenido cada paciente (solo los que tienen al menos una)
SELECT p.nombre, p.apellidos, COUNT(h.id) AS cantidad_hospitalizaciones
FROM paciente p
JOIN hospitalizaciones h ON p.id = h.id_paciente
GROUP BY p.id, p.nombre, p.apellidos;

-- 12.Muestra cuántos doctores hay en cada departamento
SELECT dh.nombre, count(doc.id) as cantidad_doctores from departamento_hospital dh
 join doctor doc on dh.id=doc.id_departamento group by dh.nombre;