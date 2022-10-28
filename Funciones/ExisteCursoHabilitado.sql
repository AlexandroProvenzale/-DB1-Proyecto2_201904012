DELIMITER $$
DROP FUNCTION IF EXISTS ExisteCursoHabilitado $$ CREATE FUNCTION ExisteCursoHabilitado(
	id_curso_habilitado int
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
SELECT EXISTS( SELECT 1 FROM curso_habilitado AS ch WHERE ch.id_curso_habilitado = id_curso_habilitado ) INTO existe;
RETURN existe;
END $$

SELECT ExisteCursoHabilitado(1);