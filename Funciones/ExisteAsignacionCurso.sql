DELIMITER $$
DROP FUNCTION IF EXISTS ExisteAsignacionCurso $$ CREATE FUNCTION ExisteAsignacionCurso(
	id_curso_habilitado_in int,
    carnet_in bigint
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
SELECT EXISTS( SELECT 1 FROM asignar_curso AS ac WHERE ac.id_curso_habilitado = id_curso_habilitado_in
AND ac.carnet = carnet_in AND ac.asignado = 1) INTO existe;
RETURN existe;
END $$

SELECT ExisteAsignacionCurso(1, 201904012);