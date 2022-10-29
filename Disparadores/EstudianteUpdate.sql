DELIMITER $$
DROP TRIGGER IF EXISTS EstudianteUpdate $$ CREATE TRIGGER EstudianteUpdate
AFTER UPDATE ON estudiante
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha modificado un registro.", "estudiante");
END $$
