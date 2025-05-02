CREATE VIEW Semestre_Inscripcion AS
SELECT 
    i.No_Inscripcion,
    i.Fecha,
    i.Monto,
    i.Tipo_Inscripcion AS "Id-Tipo",
    el.Lapso,
    m.Nombre_Materia AS Materia,
    i.Semestre AS "No. Semestre",
    e.No_Escuela
FROM Inscripciones i
JOIN Tipo_Inscripcion t ON i.Tipo_Inscripcion = t.Id_Tipo
JOIN Inscripcion_Materias im ON i.No_Inscripcion = im.No_Inscripcion
JOIN Materias m ON im.Cod_Materia = m.Cod_Materia
JOIN Escuelas e ON m.No_Escuela = e.No_Escuela
JOIN Estudiantes_Lapso el ON i.CI_Estudiante = el.CI_Estudiante;
