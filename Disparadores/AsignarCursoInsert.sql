DELIMITER $$
DROP TRIGGER IF EXISTS AsignarCursoInsert $$ CREATE TRIGGER AsignarCursoInsert
AFTER INSERT ON asignar_curso
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "asignar_curso");
END $$