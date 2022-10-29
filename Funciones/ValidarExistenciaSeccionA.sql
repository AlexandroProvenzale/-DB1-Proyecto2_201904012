DELIMITER $$
DROP FUNCTION IF EXISTS ValidarExistenciaSeccionA $$ CREATE FUNCTION ValidarExistenciaSeccionA(
	id_curso int,
    ciclo varchar(2),
    ano int,
    seccion char
)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE existe INT;
-- Sentencias SQL
SELECT ch.id_curso_habilitado
FROM curso_habilitado AS ch
WHERE EXISTS
(SELECT 1 FROM curso_habilitado AS ch WHERE ch.codigo_curso = id_curso AND ch.ciclo = UPPER(ciclo) AND ch.seccion = UPPER(seccion) AND ch.ano = ano)
INTO existe;
RETURN existe;
END $$

SELECT ValidarExistenciaSeccionA(774, '1S', 2022, 'a');