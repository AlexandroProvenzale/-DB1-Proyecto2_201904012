DELIMITER $$
DROP FUNCTION IF EXISTS ExisteDocente $$ CREATE FUNCTION ExisteDocente(
	siif bigint
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
SELECT EXISTS( SELECT 1 FROM docente AS doc WHERE doc.siif = siif ) INTO existe;
RETURN existe;
END $$

SELECT ExisteDocente(201904012);