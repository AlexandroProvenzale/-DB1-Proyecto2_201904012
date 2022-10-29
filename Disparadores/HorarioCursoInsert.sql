DELIMITER $$
DROP TRIGGER IF EXISTS HorarioCursoInsert $$ CREATE TRIGGER HorarioCursoInsert
AFTER INSERT ON horario_curso
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "horario_curso");
END $$
