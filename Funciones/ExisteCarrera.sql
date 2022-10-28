DELIMITER $$
DROP FUNCTION IF EXISTS ExisteCarrera $$ CREATE FUNCTION ExisteCarrera(
	id_carrera int
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
SELECT EXISTS( SELECT 1 FROM carrera AS ca WHERE ca.id_carrera = id_carrera ) INTO existe;
RETURN existe;
END $$

SELECT ExisteCarrera(0);