-- CONSULTAS BÁSICAS:
-- 1.Lista todos los pacientes ordenados por apellidos
SELECT * from paciente order by apellidos;

-- 2.Muestra todos los doctores con su departamento
SELECT d.nombre, d.apellidos, dh.nombre AS departamento
FROM doctor d
JOIN departamento_hospital dh ON d.id_departamento = dh.id;

-- 3.Lista todas las citas pendientes con información del paciente, doctor y motivo
SELECT d.nombre as nombre_doctor , p.nombre as nombre_paciente,cm.motivo
	FROM cita_medica cm JOIN doctor d on cm.id_doctor=d.id 
    JOIN paciente p on cm.id_paciente=p.id where estado like "pendiente";
    
-- 4.Muestra las habitaciones disponibles
SELECT * from habitaciones where disponible = 1;

-- 5.Lista los pacientes actualmente hospitalizados (sin fecha de alta) con su habitación
SELECT p.* from hospitalizaciones h
	JOIN paciente p on p.id=h.id_paciente where h.fecha_alta IS NULL;