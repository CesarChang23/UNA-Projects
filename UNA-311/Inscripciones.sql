CREATE DATABASE IF NOT EXISTS Inscripciones;
USE Inscripciones;

-- Crear Tipo_Inscripcion primero, ya que Inscripciones lo usa
CREATE TABLE Tipo_Inscripcion (
    Id_Tipo INT PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL
);

-- Crear Estudiantes
CREATE TABLE Estudiantes (
    CI_Estudiante INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100) NOT NULL
);

-- Crear Inscripciones después de definir Estudiantes y Tipo_Inscripcion
CREATE TABLE Inscripciones (
    No_Inscripcion INT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Tipo_Inscripcion INT NOT NULL,
    CI_Estudiante INT NOT NULL,
    Semestre INT NOT NULL,
    FOREIGN KEY (CI_Estudiante) REFERENCES Estudiantes(CI_Estudiante),
    FOREIGN KEY (Tipo_Inscripcion) REFERENCES Tipo_Inscripcion(Id_Tipo)
);

-- Crear Estudiantes_Lapso
CREATE TABLE Estudiantes_Lapso (
    CI_Estudiante INT,
    Lapso VARCHAR(50),
    PRIMARY KEY (CI_Estudiante, Lapso),
    FOREIGN KEY (CI_Estudiante) REFERENCES Estudiantes(CI_Estudiante)
);

-- Crear Escuelas
CREATE TABLE Escuelas (
    No_Escuela INT PRIMARY KEY,
    Nombre_Escuela VARCHAR(100) NOT NULL
); 

-- Crear Materias con referencia a Escuelas
CREATE TABLE Materias (
    Cod_Materia INT PRIMARY KEY,
    No_Semestre INT NOT NULL,
    No_Escuela INT NOT NULL,
    Nombre_Materia VARCHAR(100) NOT NULL,
    FOREIGN KEY (No_Escuela) REFERENCES Escuelas(No_Escuela)
);

-- Crear Inscripcion_Materias 
CREATE TABLE Inscripcion_Materias (
    No_Inscripcion INT,
    Cod_Materia INT,
    PRIMARY KEY (No_Inscripcion, Cod_Materia),
    FOREIGN KEY (No_Inscripcion) REFERENCES Inscripciones(No_Inscripcion) ON DELETE CASCADE,
    FOREIGN KEY (Cod_Materia) REFERENCES Materias(Cod_Materia) ON DELETE CASCADE
);
