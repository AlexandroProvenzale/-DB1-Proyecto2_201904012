DELIMITER $$

DROP PROCEDURE IF EXISTS IngresarNota $$ CREATE PROCEDURE IngresarNota(
	IN codigo_curso_in int,
    IN ciclo_in varchar(2),
    IN seccion_in char,
    IN carnet_in bigint,
    IN nota_in int
)

ing_nota:BEGIN
DECLARE idCursoHabilitado int DEFAULT 0;

/* Validar que el curso exista */
IF (NOT ExisteCurso(codigo_curso_in)) THEN
	SELECT "No existe este curso." AS ERROR;
    LEAVE ing_nota;
END IF;

/* Validar ciclo */
IF (NOT ValidarCiclo(ciclo_in)) THEN
	SELECT "El ciclo solo puede tener los siguientes valores: '1S', '2S', 'VJ', 'VD'." AS ERROR;
	LEAVE ing_nota;
END IF;

/* Validar entero positivo */
IF (NOT ValidarEnteroPositivo(carnet_in)) THEN
	SELECT "El carnet debe ser un valor entero positivo." AS ERROR;
	LEAVE ing_nota;
END IF;

/* Validar que exista estudiante */
IF (NOT ExisteEstudiante(carnet_in)) THEN
	SELECT "No existe el estudiante que se desea asignar." AS ERROR;
	LEAVE ing_nota;
END IF;

/* Validar que la sección exista */
SET idCursoHabilitado = ValidarExistenciaSeccion(codigo_curso_in, ciclo_in, seccion_in);
IF (idCursoHabilitado = 0) THEN
	SELECT "No existe este la sección seleccionada para este curso." AS ERROR;
    LEAVE ing_nota;
END IF;

/* Validar que el estudiante ya se encuentra asignado al curso */
SET @ValidarAsignacionSeccion=(SELECT EXISTS(SELECT 1 FROM asignar_curso AS ac WHERE ac.carnet = carnet_in AND ac.asignado = 1 AND ac.id_curso_habilitado = 
(SELECT ch.id_curso_habilitado FROM curso_habilitado AS ch WHERE ch.codigo_curso = codigo_curso_in
AND ch.ciclo = ciclo_in AND ch.seccion = seccion_in)));
IF (NOT @ValidarAsignacionSeccion) THEN
	SELECT "El estudiante no se encuentra asignado a esta sección del curso." AS ERROR;
    LEAVE ing_nota;
END IF;

/* Validar entero positivo en nota */
IF (NOT ValidarEnteroPositivo(nota_in)) THEN
	SELECT "La nota debe ser un valor entero positivo." AS ERROR;
	LEAVE ing_nota;
END IF;

/* Obtener id_asignar_curso */
SET @idAsignarCurso=(SELECT id_asignar_curso FROM asignar_curso WHERE id_curso_habilitado = idCursoHabilitado
AND carnet = carnet_in AND asignado = 1);

IF (SELECT EXISTS( SELECT 1 FROM notas_estudiante AS ne WHERE ne.id_asignar_curso = @idAsignarCurso )) THEN
	SELECT "La nota de este estudiante ya fue ingresada." AS ERROR;
	LEAVE ing_nota;
END IF;

INSERT INTO notas_estudiante(id_asignar_curso, nota)
VALUES (@idAsignarCurso, nota_in);

IF (nota_in >= 61) THEN
	SET @creditoss=(SELECT creditos_otorga FROM curso WHERE codigo = codigo_curso_in);
	UPDATE estudiante
	SET creditos = creditos + @creditoss
	WHERE carnet = carnet_in;
    SELECT CONCAT('El estudiante con carnet ', carnet_in,' completó el curso con una nota aprobatoria de ', nota_in, ' en el curso ', codigo_curso_in, '.') AS MENSAJE;
	LEAVE ing_nota;
END IF;

/* MENSAJE */
SELECT CONCAT('El estudiante con carnet ', carnet_in,' completó el curso con una nota desaprobatoria de ', nota_in, ' en el curso ', codigo_curso_in, '.') AS MENSAJE;

END $$