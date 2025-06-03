USE `sistema_hotel`;
DROP procedure IF EXISTS `Insert_TipoDoc`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE Insert_TipoDoc(
    IN p_idTipo INT,
	IN p_nombre VARCHAR (255)
)
BEGIN
	INSERT INTO tipodocumento (nombre)
    VALUES (p_nombre);
END$$

DELIMITER ;

USE `sistema_hotel`;
DROP procedure IF EXISTS `InsertCliente`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE InsertCliente (
	IN p_numdoc INT,
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_idTipoDoc INT
    )
BEGIN
	INSERT INTO Cliente (numdoc, nombre, apellido, telefono, correo, idTipoDoc)
	VALUES (p_numdoc, p_nombre, p_apellido, p_telefono, p_correo, p_idTipoDoc);

END$$

DELIMITER ;

USE `sistema_hotel`;
DROP procedure IF EXISTS `InsertAcomodacion`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE InsertAcomodacion (    
	IN p_tipoAcomodacion VARCHAR(50),
    IN p_capacidad INT,
    IN p_descripcion VARCHAR(100))
BEGIN
	INSERT INTO Acomodacion (tipoAcomodacion, capacidad, descripcion)
    VALUES (p_tipoAcomodacion, p_capacidad, p_descripcion);
END$$

DELIMITER ;

USE `sistema_hotel`;
DROP procedure IF EXISTS `InsertHabitacion`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE InsertHabitacion (    
	IN p_numHabit VARCHAR(10),
    IN p_idAcomodacion INT,
    IN p_precioPorNoche DECIMAL(10, 3))
BEGIN
    INSERT INTO Habitacion (numHabit, idAcomodacion, precioPorNoche, estado)
    VALUES (p_numHabit, p_idAcomodacion, p_precioPorNoche, "Disponible"); 
    
END$$

DELIMITER ;


USE `sistema_hotel`;
DROP procedure IF EXISTS `InsertDisponibilidad`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE InsertDisponibilidad (
	IN p_idHabitacion INT,
    IN p_fecha DATE,
    IN p_disponible BOOLEAN
    )
BEGIN
    INSERT INTO Disponibilidad (idHabitacion, fecha, disponible) 
    VALUES (p_idHabitacion, p_fecha, p_disponible)
    ON DUPLICATE KEY UPDATE disponible = p_disponible; -- Actualiza si ya existe entrada para habitación y fecha

END$$

DELIMITER ;


