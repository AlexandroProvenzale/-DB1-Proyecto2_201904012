CREATE DATABASE proyecto2;
USE proyecto2;

CREATE TABLE carrera(
		id_carrera int NOT NULL AUTO_INCREMENT,
		nombre varchar(255) NOT NULL,
		PRIMARY KEY(id_carrera)
);

CREATE TABLE estudiante(
		carnet bigint NOT NULL,
        nombre varchar(255) NOT NULL,
        apellido varchar(255) NOT NULL,
        fecha_nacimiento date NOT NULL,
        correo varchar(255),
        telefono int,
        direccion varchar(255),
        dpi bigint NOT NULL,
        id_carrera int NOT NULL,
        creditos int,
        fecha_creacion datetime,
        PRIMARY KEY(carnet),
        FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera)
);

CREATE TABLE docente(
		nombre varchar(255) NOT NULL,
        apellido varchar(255) NOT NULL,
        fecha_nacimiento date NOT NULL,
        correo varchar(255),
        telefono int,
        direccion varchar(255),
        dpi bigint NOT NULL,
        siif bigint NOT NULL,
        fecha_creacion datetime,
        PRIMARY KEY(siif)
);

CREATE TABLE curso(
		codigo int NOT NULL,
        nombre varchar(255) NOT NULL,
        creditos_necesarios int NOT NULL,
        creditos_otorga int NOT NULL,
        id_carrera int NOT NULL,
        obligatorio bool NOT NULL,
        PRIMARY KEY(codigo),
        FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera)
);

CREATE TABLE curso_habilitado(
		id_curso_habilitado int NOT NULL AUTO_INCREMENT,
        codigo_curso int NOT NULL,
        ciclo varchar(2) NOT NULL,
        docente bigint NOT NULL,
        cupo_max int NOT NULL,
        seccion char NOT NULL,
        ano year NOT NULL,
        asignados int DEFAULT 0,
        PRIMARY KEY(id_curso_habilitado),
        FOREIGN KEY (codigo_curso) REFERENCES curso(codigo),
        FOREIGN KEY (docente) REFERENCES docente(siif)
);

CREATE TABLE horario_curso(
		id_curso_habilitado int NOT NULL,
        dia int NOT NULL,
        horario varchar(255) NOT NULL,
        CONSTRAINT id_horario_curso PRIMARY KEY(id_curso_habilitado, dia, horario),
        FOREIGN KEY (id_curso_habilitado) REFERENCES curso_habilitado(id_curso_habilitado)
);

CREATE TABLE asignar_curso(
		id_asignar_curso int NOT NULL AUTO_INCREMENT,
		id_curso_habilitado int NOT NULL,
        carnet bigint NOT NULL,
        asignado bool NOT NULL,
        PRIMARY KEY(id_asignar_curso),
        FOREIGN KEY (id_curso_habilitado) REFERENCES curso_habilitado(id_curso_habilitado)
);

CREATE TABLE notas_estudiante(
		id_notas int NOT NULL AUTO_INCREMENT,
		id_curso_habilitado int NOT NULL,
        carnet bigint NOT NULL,
        nota int NOT NULL,
        PRIMARY KEY(id_notas),
        FOREIGN KEY (id_curso_habilitado) REFERENCES curso_habilitado(id_curso_habilitado)
);

CREATE TABLE acta(
		id_acta int NOT NULL AUTO_INCREMENT,
		id_curso_habilitado int NOT NULL,
        PRIMARY KEY(id_acta),
        FOREIGN KEY (id_curso_habilitado) REFERENCES curso_habilitado(id_curso_habilitado)
);

CREATE TABLE historial(
		fecha datetime NOT NULL,
        descripcion varchar(255) NOT NULL,
        tipo varchar(255) NOT NULL
);