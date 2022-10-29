DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarDesasignacion $$ CREATE PROCEDURE ConsultarDesasignacion(
    IN codigo_curso_in int,
    IN ciclo_in varchar(2),
    IN ano_in int,
    IN seccion_in char
)

cons_desasig:BEGIN
DECLARE idCursoHabilitado int DEFAULT 0;

/* Validar que el curso exista */
IF (NOT ExisteCurso(codigo_curso_in)) THEN
	SELECT "No existe este curso." AS ERROR;
    LEAVE cons_desasig;
END IF;

/* Validar ciclo */
IF (NOT ValidarCiclo(ciclo_in)) THEN
	SELECT "El ciclo solo puede tener los siguientes valores: '1S', '2S', 'VJ', 'VD'." AS ERROR;
	LEAVE cons_desasig;
END IF;

/* Validar entero positivo */
IF (NOT ValidarEnteroPositivo(ano_in)) THEN
	SELECT "El año debe ser un valor entero positivo." AS ERROR;
	LEAVE cons_desasig;
END IF;

/* Validar que la sección exista */
SET idCursoHabilitado = ValidarExistenciaSeccionA(codigo_curso_in, ciclo_in, ano_in, seccion_in);
IF (idCursoHabilitado = 0) THEN
	SELECT "No existe este la sección seleccionada para este curso." AS ERROR;
    LEAVE cons_desasig;
END IF;

SELECT ch.codigo_curso AS 'Código de Curso', ch.seccion AS 'Sección', 
(CASE 
	WHEN ch.ciclo = '1S' THEN 'PRIMER SEMESTRE'
    WHEN ch.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
    WHEN ch.ciclo = 'VJ' THEN 'VACACIONES DE JUNO'
    ELSE 'VACACIONES DE DICIEMBRE'
END) AS Ciclo, ch.ano AS 'año', COUNT(IF(ac.asignado, 1, NULL)) AS 'Cantidad de estudiantes que llevaron el curso',
COUNT(IF(ac.asignado, 0, NULL)) AS 'Cantidad de estudiantes que se desasignaron', 
(COUNT(IF(ac.asignado, 0, NULL))/COUNT(ac.asignado)) AS 'Porcentaje de desasignación'
FROM asignar_curso as ac INNER JOIN curso_habilitado AS ch ON ac.id_curso_habilitado = ch.id_curso_habilitado
AND ac.id_curso_habilitado = idCursoHabilitado;

END $$