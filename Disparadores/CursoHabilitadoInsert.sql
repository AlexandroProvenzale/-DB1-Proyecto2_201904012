DELIMITER $$
DROP TRIGGER IF EXISTS CursoHabilitadoInsert $$ CREATE TRIGGER CursoHabilitadoInsert
AFTER INSERT ON curso_habilitado
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "curso_habilitado");
END $$
