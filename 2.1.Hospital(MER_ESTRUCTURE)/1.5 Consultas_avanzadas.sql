-- CONSULTAS AVANZADAS (16-20):

-- 16. Lista los medicamentos más recetados (ordenados por número de veces que aparecen en recetas)
SELECT m.nombre,count(dt.id) as numero_recetados
	from receta r 
	join detalle_receta dt on  r.id=dt.id_receta 
    join medicamento m on m.id=dt.id_medicamento group by m.nombre order by numero_recetados desc;

-- 17. Muestra las habitaciones que han sido más utilizadas (con mayor número de hospitalizaciones)
SELECT h.numero, h.tipo, COUNT(ho.id) AS numero_usos
FROM habitaciones h
LEFT JOIN hospitalizaciones ho ON h.id = ho.id_habitacion
GROUP BY h.id, h.numero, h.tipo
ORDER BY numero_usos DESC;
    
-- 18. Encuentra los doctores que tienen más de una especialidad
SELECT nombre,count(id_especialidad) as cantidad_especialidades 
	FROM doctor d join doctor_especialidad de on de.id_doctor=d.id group by nombre
    HAVING COUNT(id_especialidad)>1;

-- 19. Lista los pacientes que han sido hospitalizados más de una vez
SELECT nombre,count(h.id) as cantidad_hospitalizaciones from hospitalizaciones h 
	JOIN paciente p ON h.id_paciente=p.id GROUP BY p.id, p.nombre HAVING count(h.id)>1;

-- 20. Muestra todas las citas realizadas en marzo de 2025
SELECT *
FROM cita_medica
WHERE fecha_hora >= '2025-03-01'
  AND fecha_hora < '2025-04-01';