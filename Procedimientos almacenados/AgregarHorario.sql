DELIMITER $$

DROP PROCEDURE IF EXISTS AgregarHorario $$ CREATE PROCEDURE AgregarHorario(
	IN id_curso_habilitado_in int,
    IN dia_in int,
    IN horario_in varchar(255)
)

agr_horario:BEGIN

/* Validar si existe id de curso habilitado */
IF (NOT ExisteCursoHabilitado(id_curso_habilitado_in)) THEN
	SELECT "No existe un curso habilitado con este id." AS ERROR;
    LEAVE agr_horario;
END IF;

/* Validar dominio del día */
IF (dia_in > 7 OR dia_in < 1) THEN
	SELECT "El día debe estar dentro del dominio [1, 7]." AS ERROR;
	LEAVE agr_horario;
END IF;

INSERT INTO horario_curso(id_curso_habilitado, dia, horario)
VALUES (id_curso_habilitado_in, dia_in, horario_in);

/* MENSAJE */
SELECT CONCAT('Horario para el curso habilitado con id ', id_curso_habilitado_in,' registrado para el día ', dia_in, ' a las ', horario_in, ' horas.') AS MENSAJE;

END $$