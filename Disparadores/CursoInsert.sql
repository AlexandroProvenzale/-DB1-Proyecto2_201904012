DELIMITER $$
DROP TRIGGER IF EXISTS CursoInsert $$ CREATE TRIGGER CursoInsert
AFTER INSERT ON curso
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "curso");
END $$
