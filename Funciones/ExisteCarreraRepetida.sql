DELIMITER $$
DROP FUNCTION IF EXISTS ExisteCarreraRepetida $$ CREATE FUNCTION ExisteCarreraRepetida(
	nombre_carrera varchar(255)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
-- Sentencias SQL
SELECT EXISTS( SELECT 1 FROM carrera AS ca WHERE ca.nombre = nombre_carrera ) INTO existe;
RETURN existe;
END $$

SELECT ExisteCarreraRepetida("Área Común");