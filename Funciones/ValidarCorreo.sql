DELIMITER $$
DROP FUNCTION IF EXISTS ValidarCorreo $$ CREATE FUNCTION ValidarCorreo(
	cadena VARCHAR(255)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE valido BOOLEAN;
/* Validar con regexp*/
IF (SELECT REGEXP_INSTR(cadena, '[^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$]') = 0) THEN
	SELECT TRUE INTO valido;
ELSE
	SELECT FALSE INTO valido;
END IF;
RETURN valido;
END $$

SELECT ValidarCorreo('ale@asdmf.com');