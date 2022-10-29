DELIMITER $$

DROP PROCEDURE IF EXISTS AsignarCurso $$ CREATE PROCEDURE AsignarCurso(
	IN codigo_curso_in int,
    IN ciclo_in varchar(2),
    IN seccion_in char,
    IN carnet_in bigint
)

asig_curso:BEGIN
DECLARE idCursoHabilitado int DEFAULT 0;

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

/* Validar entero positivo */
IF (NOT ValidarEnteroPositivo(carnet_in)) THEN
	SELECT "El carnet debe ser un valor entero positivo." AS ERROR;
	LEAVE asig_curso;
END IF;

/* Validar que exista estudiante */
IF (NOT ExisteEstudiante(carnet_in)) THEN
	SELECT "No existe el estudiante que se desea asignar." AS ERROR;
	LEAVE asig_curso;
END IF;

/* Validar que el estudiante no se encuentra asignado al curso */
IF (ValidarAsignacionCurso(codigo_curso_in, ciclo_in, carnet_in)) THEN
	SELECT "El estudiante ya se encuentra asignado al curso." AS ERROR;
    LEAVE asig_curso;
END IF;

/* Validar que el estudiante tenga los créditos necesarios */
SET @creditos_necesarios_curso=(SELECT creditos_necesarios FROM curso WHERE codigo = codigo_curso_in);
SET @creditos_estudiante=(SELECT creditos FROM estudiante WHERE carnet = carnet_in);
IF (@creditos_necesarios_curso > @creditos_estudiante) THEN
	SELECT "El estudiante no cuenta con los créditos necesarios para llevar el curso." AS ERROR;
    LEAVE asig_curso;
END IF;

/* Validar que el curso pertenezca a la carrera del estudiante */
SET @id_carrera_curso=(SELECT id_carrera FROM curso WHERE codigo = codigo_curso_in);
SET @id_carrera_estudiante=(SELECT id_carrera FROM estudiante WHERE carnet = carnet_in);
IF (@id_carrera_curso != @id_carrera_estudiante AND @id_carrera_curso != 0) THEN
	SELECT "El curso no corresponde a su carrera o área común." AS ERROR;
    LEAVE asig_curso;
END IF;

/* Validar que la sección exista */
SET idCursoHabilitado = ValidarExistenciaSeccion(codigo_curso_in, ciclo_in, seccion_in);
IF (idCursoHabilitado = 0) THEN
	SELECT "No existe este la sección seleccionada para este curso." AS ERROR;
    LEAVE asig_curso;
END IF;

/* Validar que hay cupo */
SET @cupo_max_ch=(SELECT cupo_max FROM curso_habilitado WHERE id_curso_habilitado = idCursoHabilitado);
SET @asignados_ch=(SELECT asignados FROM curso_habilitado WHERE id_curso_habilitado = idCursoHabilitado);
IF (@cupo_max_ch = @asignados_ch) THEN
	SELECT "Se ha alcanzado el cupo máximo de estudiantes asignados a esta sección." AS ERROR;
    LEAVE asig_curso;
END IF;

INSERT INTO asignar_curso(id_curso_habilitado, carnet, asignado)
VALUES (idCursoHabilitado, carnet_in, 1);

UPDATE curso_habilitado
SET asignados = asignados + 1
WHERE id_curso_habilitado = idCursoHabilitado;

/* MENSAJE */
SELECT CONCAT('El estudiante con carnet ', carnet_in,' se asignó a la sección ', seccion_in, ' del curso ', codigo_curso_in, ' en el ciclo ', ciclo_in, '.') AS MENSAJE;

END $$