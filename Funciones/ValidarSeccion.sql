DELIMITER $$
DROP FUNCTION IF EXISTS ValidarSeccion $$ CREATE FUNCTION ValidarSeccion(
	codigo_curso int,
	seccion char
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
if (SELECT 1 FROM curso_habilitado AS ch WHERE ch.codigo_curso = codigo_curso) THEN
	SELECT EXISTS( SELECT 1 FROM curso AS cu WHERE cu.codigo = codigo ) INTO existe;
	RETURN existe;
END IF;
SELECT 0 INTO existe;
RETURN existe;
END $$

SELECT ValidarSeccion(774, 'A');