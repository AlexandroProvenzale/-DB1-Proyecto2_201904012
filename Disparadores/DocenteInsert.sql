DELIMITER $$
DROP TRIGGER IF EXISTS DocenteInsert $$ CREATE TRIGGER DocenteInsert
AFTER INSERT ON docente
FOR EACH ROW
BEGIN
-- Sentencias SQL
	INSERT INTO historial VALUES (SYSDATE(), "Se ha insertado un nuevo registro.", "docente");
END $$
