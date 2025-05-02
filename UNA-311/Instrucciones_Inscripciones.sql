USE Inscripciones;

--  Insertar Tipo_Inscripcion primero
INSERT INTO Tipo_Inscripcion (Id_Tipo, Descripcion) VALUES
(1, 'Regular'),
(2, 'Reincorporado'),
(3, 'Equivalencia');

--  Insertar Escuelas antes de Materias
INSERT INTO Escuelas (No_Escuela, Nombre_Escuela) VALUES
(47, 'Sistemas'),
(44, 'Mantenimiento'),
(41, 'Civil');

-- Insertar Estudiantes antes de Inscripciones
INSERT INTO Estudiantes (CI_Estudiante, Nombre, Apellido, Direccion) VALUES
(20100200, 'José', 'Carmona', 'Av. Bravo Edif. Socorro Petare'),
(21150210, 'Luis', 'González', 'Av. García Edif. Iris La California'),
(22110300, 'Abelardo', 'Gutiérrez', 'Calle. Santiago. Casa 8. La Urbina'),
(23105600, 'Sandra', 'Hernández', 'Calle la Línea. Casa 18 Catia'),
(21900300, 'Carlos', 'Urdaneta', 'Av. Boconó. Edif. Sucre. La florida'),
(22115116, 'María', 'Alvarado', 'Av. Gustavo. Edif. 505. Sebucan'),
(23450200, 'Agustín', 'Lara', 'Av. Colinas. Edif. Miguel. Colinas de Bello Monte'),
(20802050, 'Cristian', 'Cuevas', 'Calle Justa. Casa No. 30. El Llanito'),
(20100201, 'Josefina', 'López', 'Av. Circunvalación Edif. Posterior. Lomas del Este');

-- Insertar Estudiantes_Lapso después de Estudiantes
INSERT INTO Estudiantes_Lapso (CI_Estudiante, Lapso) VALUES
(20100200, '2010-01'),
(21150210, '2010-06'),
(22110300, '2011-01'),
(23105600, '2011-06'),
(21900300, '2012-01'),
(22115116, '2012-06'),
(23450200, '2013-01'),
(20802050, '2013-06'),
(20100201, '2014-01');

-- Insertar Materias después de Escuelas
INSERT INTO Materias (Cod_Materia, No_Semestre, No_Escuela, Nombre_Materia) VALUES
(1, 3, 47, 'Computación'),
(2, 4, 47, 'Física'),
(3, 6, 47, 'Matemática IV'),
(4, 3, 44, 'Matemática'),
(5, 4, 44, 'Física'),
(6, 6, 44, 'Electrónica'),
(7, 3, 41, 'Estadística'),
(8, 4, 41, 'Laboratorio'),
(9, 6, 41, 'Metodología');

-- Insertar Inscripciones después de Estudiantes
INSERT INTO Inscripciones (No_Inscripcion, Fecha, Monto, Tipo_Inscripcion, CI_Estudiante, Semestre) VALUES
(1, '2010-01-20', 15, 1, 20100200, 3),
(2, '2010-06-21', 20, 2, 21150210, 4),
(3, '2010-01-22', 25, 3, 22110300, 4),
(4, '2011-01-20', 15, 1, 23105600, 3),
(5, '2011-06-21', 20, 2, 21900300, 4),
(6, '2011-06-22', 25, 3, 22115116, 6),
(7, '2012-01-20', 15, 1, 23450200, 3),
(8, '2012-06-21', 20, 2, 20802050, 4),
(9, '2012-06-22', 25, 3, 20100201, 6);

-- Insertar Inscripcion_Materias después de Inscripciones
INSERT INTO Inscripcion_Materias (No_Inscripcion, Cod_Materia) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9);

