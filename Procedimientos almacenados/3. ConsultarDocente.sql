DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarDocente $$ CREATE PROCEDURE ConsultarDocente(
    IN siif_in bigint
)

cons_doc:BEGIN

/* Verificar si existe carrera */
IF (NOT ExisteDocente(siif_in)) THEN
	SELECT "No existe este docente." AS ERROR;
    LEAVE cons_doc;
END IF;

SELECT doc.siif AS RegistroSIIF, CONCAT(doc.nombre, ' ', doc.apellido) AS NombreCompleto, doc.fecha_nacimiento AS FechaNacimiento,
doc.correo AS Correo, doc.telefono AS Telefono, doc.direccion AS Direccion, doc.dpi AS NumeroDPI
FROM docente as doc WHERE doc.siif = siif_in;

END $$