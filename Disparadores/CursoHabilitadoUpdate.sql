DELIMITER $$
DROP TRIGGER IF EXISTS CursoHabilitadoUpdate $$ CREATE TRIGGER CursoHabilitadoUpdate
AFTER UPDATE ON curso_habilitado
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha modificado un registro.", "curso_habilitado");
END $$
