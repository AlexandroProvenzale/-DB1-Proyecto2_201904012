DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarPensum $$ CREATE PROCEDURE ConsultarPensum(
    IN id_carrera_in int
)

cons_pensum:BEGIN

/* Verificar si existe carrera */
IF (NOT ExisteCarrera(id_carrera_in)) THEN
	SELECT "No existe esta carrera." AS ERROR;
    LEAVE cons_pensum;
END IF;

SELECT cu.codigo AS CodigoCurso, cu.nombre AS NombreCurso, cu.obligatorio AS EsObligatorio, cu.creditos_necesarios AS CreditosNecesarios
FROM curso as cu WHERE cu.id_carrera = id_carrera_in;

END $$
