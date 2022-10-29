DELIMITER $$

DROP PROCEDURE IF EXISTS DesasignarCurso $$ CREATE PROCEDURE DesasignarCurso(
	IN codigo_curso_in int,
    IN ciclo_in varchar(2),
    IN seccion_in char,
    IN carnet_in bigint
)

desasig_curso:BEGIN
DECLARE idCursoHabilitado int DEFAULT 0;

/* Validar que el curso exista */
IF (NOT ExisteCurso(codigo_curso_in)) THEN
	SELECT "No existe este curso." AS ERROR;
    LEAVE desasig_curso;
END IF;

/* Validar ciclo */
IF (NOT ValidarCiclo(ciclo_in)) THEN
	SELECT "El ciclo solo puede tener los siguientes valores: '1S', '2S', 'VJ', 'VD'." AS ERROR;
	LEAVE desasig_curso;
END IF;

/* Validar entero positivo */
IF (NOT ValidarEnteroPositivo(carnet_in)) THEN
	SELECT "El carnet debe ser un valor entero positivo." AS ERROR;
	LEAVE desasig_curso;
END IF;

/* Validar que exista estudiante */
IF (NOT ExisteEstudiante(carnet_in)) THEN
	SELECT "No existe el estudiante que se desea asignar." AS ERROR;
	LEAVE desasig_curso;
END IF;

/* Validar que la sección exista */
SET idCursoHabilitado = ValidarExistenciaSeccion(codigo_curso_in, ciclo_in, seccion_in);
IF (idCursoHabilitado = 0) THEN
	SELECT "No existe este la sección seleccionada para este curso." AS ERROR;
    LEAVE desasig_curso;
END IF;

/* Validar que el estudiante ya se encuentra asignado al curso */
SET @ValidarAsignacionSeccion=(SELECT EXISTS(SELECT 1 FROM asignar_curso AS ac WHERE ac.carnet = carnet_in AND ac.asignado = 1 AND ac.id_curso_habilitado = 
(SELECT ch.id_curso_habilitado FROM curso_habilitado AS ch WHERE ch.codigo_curso = codigo_curso_in
AND ch.ciclo = ciclo_in AND ch.seccion = seccion_in)));
IF (NOT @ValidarAsignacionSeccion) THEN
	SELECT "El estudiante no se encuentra asignado a esta sección del curso." AS ERROR;
    LEAVE desasig_curso;
END IF;

/* Actualizar estado de asignado a desasignado */
SET @idAsignarCurso=(SELECT id_asignar_curso FROM asignar_curso WHERE id_curso_habilitado = idCursoHabilitado
AND carnet = carnet_in AND asignado = 1);
UPDATE asignar_curso
SET asignado = 0
WHERE id_asignar_curso = @idAsignarCurso;

UPDATE curso_habilitado
SET asignados = asignados - 1
WHERE id_curso_habilitado = idCursoHabilitado;

/* MENSAJE */
SELECT CONCAT('El estudiante con carnet ', carnet_in,' se desasignó de la sección ', seccion_in, ' del curso ', codigo_curso_in, ' en el ciclo ', ciclo_in, '.') AS MENSAJE;

END $$