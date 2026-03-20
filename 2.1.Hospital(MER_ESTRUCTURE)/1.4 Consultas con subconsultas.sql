-- CONSULTAS CON SUBCONSULTAS (13-15):

-- 13.Lista los pacientes que nunca han tenido una cita médica
SELECT * FROM paciente where id NOT IN (SELECT id_paciente from cita_medica);

-- 14.Muestra los doctores que no tienen ninguna cita asignada
SELECT * FROM doctor where id NOT IN (SELECT id_doctor from cita_medica);

-- 15.Encuentra el paciente con más tratamientos activos actualmente
SELECT p.nombre, p.apellidos, COUNT(t.id) AS tratamientos_activos
FROM paciente p
JOIN tratamiento t ON p.id = t.id_paciente
WHERE t.fecha_fin IS NULL OR t.fecha_fin >= CURDATE()
GROUP BY p.id, p.nombre, p.apellidos
ORDER BY tratamientos_activos DESC
LIMIT 1;