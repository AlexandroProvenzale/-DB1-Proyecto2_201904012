DELIMITER $$
DROP FUNCTION IF EXISTS ExisteEstudiante $$ CREATE FUNCTION ExisteEstudiante(
	carnet bigint
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
SELECT EXISTS( SELECT 1 FROM estudiante AS es WHERE es.carnet = carnet ) INTO existe;
RETURN existe;
END $$

SELECT ExisteEstudiante(201904012);