DELIMITER $$
DROP FUNCTION IF EXISTS ValidarCiclo $$ CREATE FUNCTION ValidarCiclo(
	ciclo varchar(2)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
if (UPPER(ciclo) != '1S' AND UPPER(ciclo) != '2S' AND UPPER(ciclo) != 'VJ' AND UPPER(ciclo) != 'VD') THEN
	SELECT 0 INTO existe;
RETURN existe;
END IF;
SELECT 1 INTO existe;
RETURN existe;
END $$

SELECT ValidarCiclo('vd');