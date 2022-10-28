DELIMITER $$

DROP PROCEDURE IF EXISTS AsignarCurso $$ CREATE PROCEDURE AsignarCurso(
	IN codigo_curso_in int,
    IN ciclo_in varchar(2),
    IN seccion_in char,
    IN carnet bigint
)

asig_curso:BEGIN

DECLARE idAsigCurso int DEFAULT 0;
SET idAsigCurso = ObtenerIdCursoHab(codigo_curso_in, ciclo_in, seccion_in);
/* Validar que el curso habilitado exista */
IF (idAsigCurso = 0) THEN
	SELECT "No se hizo match con la relación de curso habilitado por medio del año actual, ciclo y sección." AS ERROR;
    LEAVE asig_curso;
END IF;

/* Validar que el curso exista */
IF (NOT ExisteCurso(codigo_curso_in)) THEN
	SELECT "No existe este curso." AS ERROR;
    LEAVE asig_curso;
END IF;

/* Validar ciclo */
IF (NOT ValidarCiclo(ciclo_in)) THEN
	SELECT "El ciclo solo puede tener los siguientes valores: '1S', '2S', 'VJ', 'VD'." AS ERROR;
	LEAVE asig_curso;
END IF;

/* Validar docente */
IF (NOT ExisteDocente(docente_in)) THEN
	SELECT "No existe el docente ingresado." AS ERROR;
	LEAVE asig_curso;
END IF;

/* Validar entero positivo */
IF (NOT ValidarEnteroPositivo(cupo_max_in)) THEN
	SELECT "El cupo máximo debe ser un valor entero positivo." AS ERROR;
	LEAVE asig_curso;
END IF;

INSERT INTO curso_habilitado(codigo_curso, ciclo, docente, cupo_max, seccion, ano, asignados)
VALUES (codigo_curso_in, ciclo_in, docente_in, cupo_max_in, seccion_in, YEAR(CURDATE()), 0);

/* MENSAJE */
SELECT CONCAT('Curso de código ', codigo_curso_in,' habilitado con la sección ', seccion_in, '. Id del curso = ', curso_habilitado.id_curso_habilitado, '.') AS MENSAJE;

END $$