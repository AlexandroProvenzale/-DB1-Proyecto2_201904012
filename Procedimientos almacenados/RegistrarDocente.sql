DELIMITER $$

DROP PROCEDURE IF EXISTS RegistrarDocente $$ CREATE PROCEDURE RegistrarDocente(
    IN nombre_in varchar(255),
    IN apellido_in varchar(255),
    IN fecha_nacimiento_in date,
    IN correo_in varchar(255),
    IN telefono_in int,
    IN direccion_in varchar(255),
    IN dpi_in bigint,
    IN siif_in bigint
)

reg_doc:BEGIN

/* Ya existe */
IF (ExisteDocente(siif_in)) THEN
	SELECT "Ya existe este docente." AS ERROR;
    LEAVE reg_doc;
END IF;

/* Validar letras */
IF (NOT ValidarLetras(nombre_in) OR NOT ValidarLetras(apellido_in)) THEN
	SELECT "El nombre y apellido solo debe contener letras y espacios." AS ERROR;
	LEAVE reg_doc;
END IF;

/* Validar correo */
IF (NOT ValidarCorreo(correo_in)) THEN
	SELECT "El correo no cumple con un formato válido." AS ERROR;
	LEAVE reg_doc;
END IF;


INSERT INTO docente(nombre, apellido, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion)
VALUES (nombre_in, apellido_in, fecha_nacimiento_in, correo_in, telefono_in, direccion_in, dpi_in, siif_in, NOW());

/* MENSAJE */
SELECT CONCAT('Docente ', nombre_in, ' ', apellido_in, ' registrado con el siif ', siif_in, '.') AS MENSAJE;

END $$