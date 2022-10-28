DELIMITER $$
DROP FUNCTION IF EXISTS ObtenerIdCursoHab $$ CREATE FUNCTION ObtenerIdCursoHab(
	id_curso int,
    ciclo varchar(2),
    seccion char
)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE idCursoHab int;
-- Sentencias SQL
SELECT ch.id_curso_habilitado
FROM curso_habilitado AS ch
WHERE EXISTS
(SELECT 1 FROM curso_habilitado AS ch WHERE ch.codigo_curso = id_curso AND ch.ciclo = UPPER(ciclo) AND ch.seccion = UPPER(seccion) AND ch.ano = YEAR(CURDATE()))
INTO idCursoHab;
RETURN idCursoHab;
END $$

SELECT ObtenerIdCursoHab(774, '1S', 'a');