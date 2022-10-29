DELIMITER $$
DROP TRIGGER IF EXISTS AsignarCursoUpdate $$ CREATE TRIGGER AsignarCursoUpdate
AFTER UPDATE ON asignar_curso
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha modificado un registro.", "asignar_curso");
END $$
