DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarAsignados $$ CREATE PROCEDURE ConsultarAsignados(
    IN codigo_curso_in int,
    IN ciclo_in varchar(2),
    IN ano_in int,
    IN seccion_in char
)

cons_asig:BEGIN
DECLARE idCursoHabilitado int DEFAULT 0;

/* Validar que el curso exista */
IF (NOT ExisteCurso(codigo_curso_in)) THEN
	SELECT "No existe este curso." AS ERROR;
    LEAVE cons_asig;
END IF;

/* Validar ciclo */
IF (NOT ValidarCiclo(ciclo_in)) THEN
	SELECT "El ciclo solo puede tener los siguientes valores: '1S', '2S', 'VJ', 'VD'." AS ERROR;
	LEAVE cons_asig;
END IF;

/* Validar entero positivo */
IF (NOT ValidarEnteroPositivo(ano_in)) THEN
	SELECT "El año debe ser un valor entero positivo." AS ERROR;
	LEAVE cons_asig;
END IF;

/* Validar que la sección exista */
SET idCursoHabilitado = ValidarExistenciaSeccionA(codigo_curso_in, ciclo_in, ano_in, seccion_in);
IF (idCursoHabilitado = 0 OR idCursoHabilitado = null) THEN
	SELECT "No existe este la sección seleccionada para este curso." AS ERROR;
    LEAVE cons_asig;
END IF;

SELECT es.carnet AS Carnet, CONCAT(es.nombre, ' ', es.apellido) AS NombreComleto, es.creditos AS Creditos
FROM asignar_curso as ac INNER JOIN estudiante as es
ON ac.carnet = es.carnet AND ac.id_curso_habilitado = idCursoHabilitado AND ac.asignado = 1;

END $$