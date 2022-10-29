DELIMITER $$
DROP TRIGGER IF EXISTS EstudianteInsert $$ CREATE TRIGGER EstudianteInsert
AFTER INSERT ON estudiante
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "estudiante");
END $$
