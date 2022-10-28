DELIMITER $$
DROP FUNCTION IF EXISTS ValidarEnteroPositivo $$ CREATE FUNCTION ValidarEnteroPositivo(
	entero int
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE valido BOOLEAN;
-- Sentencias SQL
IF (SELECT NOT REGEXP_INSTR(entero, '[^0-9]') = 0) THEN
	SELECT FALSE INTO valido;
	RETURN valido;
END IF;

IF (entero >= 0) THEN
	SELECT TRUE INTO valido;
ELSE
	SELECT FALSE INTO valido;
END IF;
RETURN valido;
END $$

SELECT ValidarEnteroPositivo(201904012);