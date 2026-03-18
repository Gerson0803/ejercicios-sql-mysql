-- 6.Muestra todos los diagnósticos con información completa (paciente, doctor, fecha, descripción y código CIE10)
SELECT p.nombre as pacientes, doc.nombre as doctor,d.fecha, d.descripcion, d.codigo_CIE10 FROM diagnostico d 
	JOIN paciente p on p.id=d.id_paciente
    JOIN doctor doc on d.id_medico=doc.id ;
    
-- 7.Lista las especialidades de cada doctor
SELECT d.nombre, d.apellidos, em.nombre AS especialidad
FROM doctor d
JOIN doctor_especialidad de ON d.id = de.id_doctor
JOIN especialidad_medica em ON de.id_especialidad = em.id
ORDER BY d.apellidos;

-- 8.Muestra todas las recetas con los medicamentos prescritos, incluyendo dosis y frecuencia
SELECT r.id AS receta, r.fecha_emision, 
       m.nombre AS medicamento, dr.dosis, dr.frecuencia
FROM receta r
JOIN detalle_receta dr ON r.id = dr.id_receta
JOIN medicamento m ON dr.id_medicamento = m.id
ORDER BY r.id;