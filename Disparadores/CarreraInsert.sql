DELIMITER $$
DROP TRIGGER IF EXISTS CarreraInsert $$ CREATE TRIGGER CarreraInsert
AFTER INSERT ON carrera
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "carrera");
END $$
