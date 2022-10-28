DELIMITER $$

DROP PROCEDURE IF EXISTS RegistrarEstudiante $$ CREATE PROCEDURE RegistrarEstudiante(
	IN carnet_in bigint,
    IN nombre_in varchar(255),
    IN apellido_in varchar(255),
    IN fecha_nacimiento_in date,
    IN correo_in varchar(255),
    IN telefono_in int,
    IN direccion_in varchar(255),
    IN dpi_in bigint,
    IN carrera_in int
)

reg_est:BEGIN

/* Ya existe */
IF (ExisteEstudiante(carnet_in)) THEN
	SELECT "Ya existe este estudiante." AS ERROR;
    LEAVE reg_est;
END IF;

/* Validar letras */
IF (NOT ValidarLetras(nombre_in) OR NOT ValidarLetras(apellido_in)) THEN
	SELECT "El nombre y apellido solo debe contener letras y espacios." AS ERROR;
	LEAVE reg_est;
END IF;

/* Validar correo */
IF (NOT ValidarCorreo(correo_in)) THEN
	SELECT "El correo no cumple con un formato válido." AS ERROR;
	LEAVE reg_est;
END IF;

/* Validar carrera existente */
IF (NOT ExisteCarrera(carrera_in)) THEN
	SELECT "La carrera ingresada no existe." AS ERROR;
	LEAVE reg_est;
END IF;

INSERT INTO estudiante(carnet, nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_creacion)
VALUES (carnet_in, nombre_in, apellido_in, fecha_nacimiento_in, correo_in, telefono_in, direccion_in, dpi_in, carrera_in, 0, NOW());

/* MENSAJE */
SELECT CONCAT('Estudiante ', nombre_in, ' ', apellido_in, ' registrado con el carnet ', carnet_in, '.') AS MENSAJE;

END $$