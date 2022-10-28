DELIMITER $$

DROP PROCEDURE IF EXISTS CrearCarrera $$ CREATE PROCEDURE CrearCarrera(
    IN nombre_in varchar(255)
)

crear_carrera:BEGIN

/* Validar letras */
IF (NOT ValidarLetras(nombre_in)) THEN
	SELECT "El nombre solo debe contener letras y espacios." AS ERROR;
	LEAVE crear_carrera;
END IF;

/* Ya existe */
IF (ExisteCarreraRepetida(nombre_in)) THEN
	SELECT "Ya existe esta carrera." AS ERROR;
    LEAVE crear_carrera;
END IF;

INSERT INTO carrera(nombre)
VALUES (nombre_in);

/* MENSAJE */
SELECT CONCAT('Carrera \"', nombre_in, '\" registrada.') AS MENSAJE;

END $$

CALL CrearCarrera("Ciencias y Sistemas");
