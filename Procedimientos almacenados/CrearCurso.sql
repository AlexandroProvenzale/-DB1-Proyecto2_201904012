DELIMITER $$

DROP PROCEDURE IF EXISTS CrearCurso $$ CREATE PROCEDURE CrearCurso(
	IN codigo_in int,
    IN nombre_in varchar(255),
    IN creditos_necesarios_in int,
    IN creditos_otorga_in int,
    IN id_carrera_in int,
    IN obligatorio_in bool
)

crear_curso:BEGIN

/* Ya existe */
IF (ExisteCurso(codigo_in)) THEN
	SELECT "Ya existe este curso." AS ERROR;
    LEAVE crear_curso;
END IF;

/* Validar letras */
IF (NOT ValidarLetras(nombre_in)) THEN
	SELECT "El nombre solo debe contener letras y espacios." AS ERROR;
	LEAVE crear_curso;
END IF;

IF (NOT ValidarEnteroPositivo(creditos_necesarios_in) OR NOT ValidarEnteroPositivo(creditos_otorga_in)) THEN
	SELECT "Los créditos necesarios y otorgados deben ser un valor entero positivo." AS ERROR;
	LEAVE crear_curso;
END IF;

/* Validar carrera existente */
IF (NOT ExisteCarrera(id_carrera_in)) THEN
	SELECT "La carrera ingresada no existe." AS ERROR;
	LEAVE crear_curso;
END IF;

INSERT INTO curso(codigo, nombre, creditos_necesarios, creditos_otorga, id_carrera, obligatorio)
VALUES (codigo_in, nombre_in, creditos_necesarios_in, creditos_otorga_in, id_carrera_in, obligatorio_in);

/* MENSAJE */
SELECT CONCAT('Curso ', nombre_in,' registrado con el código ', codigo_in, '.') AS MENSAJE;

END $$