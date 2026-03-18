use hospital;
CREATE TABLE `paciente` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `dni` VARCHAR(255) UNIQUE,
  `nombre` VARCHAR(255),
  `apellidos` VARCHAR(255),
  `fecha_nacimiento` DATE,
  `telefono` VARCHAR(255),
  `direccion` VARCHAR(255),
  `email` VARCHAR(255),
  `numero_seguridad_social` VARCHAR(255) UNIQUE
);

CREATE TABLE `departamento_hospital` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255),
  `ubicacion` VARCHAR(255),
  `telefono_contacto` VARCHAR(255)
);

CREATE TABLE `especialidad_medica` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255),
  `descripcion` TEXT
);

CREATE TABLE `doctor` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `numero_colegiado` VARCHAR(255) UNIQUE,
  `nombre` VARCHAR(255),
  `apellidos` VARCHAR(255),
  `telefono` VARCHAR(255),
  `email` VARCHAR(255),
  `id_departamento` INT,
  FOREIGN KEY (`id_departamento`) REFERENCES `departamento_hospital` (`id`)
);

CREATE TABLE `doctor_especialidad` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `id_especialidad` INT,
  `id_doctor` INT,
  FOREIGN KEY (`id_especialidad`) REFERENCES `especialidad_medica` (`id`),
  FOREIGN KEY (`id_doctor`) REFERENCES `doctor` (`id`)
);

CREATE TABLE `habitaciones` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `numero` VARCHAR(255) UNIQUE,
  `tipo` VARCHAR(255),
  `piso` INT,
  `disponible` BOOLEAN DEFAULT TRUE
);

CREATE TABLE `cita_medica` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fecha_hora` DATETIME,
  `motivo` TEXT,
  `estado` VARCHAR(50),
  `id_doctor` INT,
  `id_paciente` INT,
  FOREIGN KEY (`id_doctor`) REFERENCES `doctor` (`id`),
  FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`)
);

CREATE TABLE `hospitalizaciones` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fecha_ingreso` DATE,
  `fecha_alta` DATE,
  `motivo` TEXT,
  `id_habitacion` INT,
  `id_paciente` INT,
  FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id`),
  FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`)
);

CREATE TABLE `diagnostico` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fecha` DATE,
  `descripcion` TEXT,
  `codigo_CIE10` VARCHAR(50),
  `id_medico` INT,
  `id_paciente` INT,
  `id_cita_medica` INT,
  FOREIGN KEY (`id_medico`) REFERENCES `doctor` (`id`),
  FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`),
  FOREIGN KEY (`id_cita_medica`) REFERENCES `cita_medica` (`id`)
);

CREATE TABLE `tratamiento` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre_medicamento` VARCHAR(255),
  `dosis` VARCHAR(100),
  `frecuencia` VARCHAR(100),
  `fecha_inicio` DATE,
  `fecha_fin` DATE,
  `id_medico` INT,
  `id_paciente` INT,
  FOREIGN KEY (`id_medico`) REFERENCES `doctor` (`id`),
  FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`)
);

CREATE TABLE `receta` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fecha_emision` DATE,
  `id_tratamiento` INT,
  FOREIGN KEY (`id_tratamiento`) REFERENCES `tratamiento` (`id`)
);

CREATE TABLE `medicamento` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255),
  `laboratorio` VARCHAR(255),
  `tipo` VARCHAR(100)
);

CREATE TABLE `detalle_receta` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `dosis` VARCHAR(100),
  `frecuencia` VARCHAR(100),
  `id_receta` INT,
  `id_medicamento` INT,
  FOREIGN KEY (`id_receta`) REFERENCES `receta` (`id`),
  FOREIGN KEY (`id_medicamento`) REFERENCES `medicamento` (`id`)
);

-- DEPARTAMENTOS
INSERT INTO departamento_hospital (nombre, ubicacion, telefono_contacto) VALUES
('Urgencias', 'Planta Baja - Ala A', '912345001'),
('Cardiología', 'Planta 2 - Ala B', '912345002'),
('Pediatría', 'Planta 3 - Ala C', '912345003'),
('Traumatología', 'Planta 1 - Ala A', '912345004'),
('Oncología', 'Planta 4 - Ala B', '912345005');

-- ESPECIALIDADES
INSERT INTO especialidad_medica (nombre, descripcion) VALUES
('Cardiología', 'Especialidad médica que se ocupa de las enfermedades del corazón'),
('Pediatría', 'Especialidad médica que estudia al niño y sus enfermedades'),
('Traumatología', 'Especialidad quirúrgica que se dedica al estudio de las lesiones del aparato locomotor'),
('Oncología', 'Especialidad médica que estudia y trata las neoplasias'),
('Medicina General', 'Atención médica general y preventiva');

-- DOCTORES
INSERT INTO doctor (numero_colegiado, nombre, apellidos, telefono, email, id_departamento) VALUES
('28/28/12345', 'Carlos', 'Ramírez López', '666123456', 'cramirez@hospital.com', 2),
('28/28/12346', 'Ana', 'Martínez García', '666123457', 'amartinez@hospital.com', 3),
('28/28/12347', 'Pedro', 'González Ruiz', '666123458', 'pgonzalez@hospital.com', 4),
('28/28/12348', 'Laura', 'Fernández Santos', '666123459', 'lfernandez@hospital.com', 5),
('28/28/12349', 'Miguel', 'Torres Díaz', '666123460', 'mtorres@hospital.com', 1);

-- RELACIÓN DOCTOR-ESPECIALIDAD
INSERT INTO doctor_especialidad (id_especialidad, id_doctor) VALUES
(1, 1), -- Carlos es Cardiólogo
(2, 2), -- Ana es Pediatra
(3, 3), -- Pedro es Traumatólogo
(4, 4), -- Laura es Oncóloga
(5, 5), -- Miguel es Médico General
(1, 5); -- Miguel también tiene especialidad en Cardiología

-- PACIENTES
INSERT INTO paciente (dni, nombre, apellidos, fecha_nacimiento, telefono, direccion, email, numero_seguridad_social) VALUES
('12345678A', 'Juan', 'Pérez Rodríguez', '1980-05-15', '611222333', 'Calle Mayor 10, Madrid', 'jperez@email.com', '281234567890'),
('23456789B', 'María', 'López Fernández', '1992-08-22', '622333444', 'Av. Constitución 25, Madrid', 'mlopez@email.com', '282345678901'),
('34567890C', 'José', 'García Martínez', '1975-12-03', '633444555', 'Plaza España 5, Madrid', 'jgarcia@email.com', '283456789012'),
('45678901D', 'Carmen', 'Sánchez Ruiz', '2010-03-18', '644555666', 'Calle Alcalá 100, Madrid', 'csanchez@email.com', '284567890123'),
('56789012E', 'Antonio', 'Hernández Gil', '1988-07-30', '655666777', 'Gran Vía 45, Madrid', 'ahernandez@email.com', '285678901234');

-- HABITACIONES
INSERT INTO habitaciones (numero, tipo, piso, disponible) VALUES
('101', 'Individual', 1, TRUE),
('102', 'Doble', 1, TRUE),
('201', 'Individual', 2, FALSE),
('202', 'UCI', 2, TRUE),
('301', 'Doble', 3, TRUE);

-- CITAS MÉDICAS
INSERT INTO cita_medica (fecha_hora, motivo, estado, id_doctor, id_paciente) VALUES
('2025-03-10 09:00:00', 'Revisión cardiológica', 'realizada', 1, 1),
('2025-03-11 10:30:00', 'Control pediatría', 'realizada', 2, 4),
('2025-03-12 11:00:00', 'Dolor de rodilla', 'realizada', 3, 3),
('2025-03-20 15:00:00', 'Consulta oncología', 'pendiente', 4, 2),
('2025-03-21 16:30:00', 'Revisión general', 'pendiente', 5, 5);

-- DIAGNÓSTICOS
INSERT INTO diagnostico (fecha, descripcion, codigo_CIE10, id_medico, id_paciente, id_cita_medica) VALUES
('2025-03-10', 'Hipertensión arterial leve', 'I10', 1, 1, 1),
('2025-03-11', 'Faringitis aguda', 'J02.9', 2, 4, 2),
('2025-03-12', 'Esguince de rodilla', 'S83.4', 3, 3, 3);

-- TRATAMIENTOS
INSERT INTO tratamiento (nombre_medicamento, dosis, frecuencia, fecha_inicio, fecha_fin, id_medico, id_paciente) VALUES
('Enalapril', '10mg', 'Una vez al día', '2025-03-10', '2025-06-10', 1, 1),
('Amoxicilina', '500mg', 'Cada 8 horas', '2025-03-11', '2025-03-18', 2, 4),
('Ibuprofeno', '600mg', 'Cada 8 horas', '2025-03-12', '2025-03-19', 3, 3);

-- MEDICAMENTOS
INSERT INTO medicamento (nombre, laboratorio, tipo) VALUES
('Enalapril', 'Sandoz', 'Antihipertensivo'),
('Amoxicilina', 'Normon', 'Antibiótico'),
('Ibuprofeno', 'Cinfa', 'Antiinflamatorio'),
('Paracetamol', 'Kern Pharma', 'Analgésico'),
('Omeprazol', 'Alter', 'Protector gástrico');

-- RECETAS
INSERT INTO receta (fecha_emision, id_tratamiento) VALUES
('2025-03-10', 1),
('2025-03-11', 2),
('2025-03-12', 3);

-- DETALLE RECETAS
INSERT INTO detalle_receta (dosis, frecuencia, id_receta, id_medicamento) VALUES
('10mg', 'Una vez al día por la mañana', 1, 1),
('500mg', 'Cada 8 horas durante 7 días', 2, 2),
('600mg', 'Cada 8 horas después de las comidas', 3, 3),
('20mg', 'Cada 24 horas en ayunas', 3, 5); -- Omeprazol adicional con el ibuprofeno

-- HOSPITALIZACIONES
INSERT INTO hospitalizaciones (fecha_ingreso, fecha_alta, motivo, id_habitacion, id_paciente) VALUES
('2025-03-05', '2025-03-08', 'Observación post-operatoria', 3, 1),
('2025-03-13', NULL, 'Neumonía grave', 4, 5); -- Aún hospitalizado