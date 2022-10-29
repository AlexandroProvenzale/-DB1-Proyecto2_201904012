DELIMITER $$
DROP TRIGGER IF EXISTS DocenteUpdate $$ CREATE TRIGGER DocenteUpdate
AFTER UPDATE ON docente
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha modificado un registro.", "docente");
END $$
