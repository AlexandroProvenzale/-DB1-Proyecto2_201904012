DELIMITER $$
DROP FUNCTION IF EXISTS ValidarAsignacionCurso $$ CREATE FUNCTION ValidarAsignacionCurso(
	id_curso_in int,
    ciclo_in varchar(2),
    carnet_in bigint
)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE existe bool;
-- Sentencias SQL
SELECT EXISTS(SELECT 1 FROM asignar_curso AS ac WHERE ac.carnet = carnet_in AND ac.asignado = 1 AND ac.id_curso_habilitado = 
(SELECT ch.id_curso_habilitado FROM curso_habilitado AS ch WHERE ch.codigo_curso = id_curso_in
AND ch.ciclo = ciclo_in)) INTO existe;

RETURN existe;
END $$

SELECT ValidarAsignacionCurso(774, '1S', 'a');