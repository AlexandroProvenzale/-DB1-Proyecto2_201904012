DELIMITER $$
DROP TRIGGER IF EXISTS NotasEstudianteInsert $$ CREATE TRIGGER NotasEstudianteInsert
AFTER INSERT ON notas_estudiante
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "notas_estudiante");
END $$
