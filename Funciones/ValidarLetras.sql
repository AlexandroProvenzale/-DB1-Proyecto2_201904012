DELIMITER $$
DROP FUNCTION IF EXISTS ValidarLetras $$ CREATE FUNCTION ValidarLetras(
	cadena VARCHAR(255)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE valido BOOLEAN;
/* Validar con regexp*/
IF (SELECT REGEXP_INSTR(cadena, '[^a-zA-ZÀ-ÿ ]') = 0) THEN
	SELECT TRUE INTO valido;
ELSE
	SELECT FALSE INTO valido;
END IF;
RETURN valido;
END $$

SELECT ValidarLetras("Alexandro Provenzale Pérez!");