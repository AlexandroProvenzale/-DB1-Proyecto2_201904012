DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarEstudiante $$ CREATE PROCEDURE ConsultarEstudiante(
    IN carnet_in bigint
)

cons_est:BEGIN

/* Verificar si existe carrera */
IF (NOT ExisteEstudiante(carnet_in)) THEN
	SELECT "No existe este estudiante." AS ERROR;
    LEAVE cons_est;
END IF;

SELECT es.carnet AS Carnet, CONCAT(es.nombre, ' ', es.apellido) AS NombreCompleto, es.fecha_nacimiento AS FechaNacimiento,
es.correo AS Correo, es.telefono AS Telefono, es.direccion AS Direccion, es.dpi AS NumeroDPI, ca.nombre AS Carrera, es.creditos AS Creditos
FROM estudiante as es INNER JOIN carrera as ca
ON es.id_carrera = ca.id_carrera
AND es.carnet = carnet_in;

END $$
