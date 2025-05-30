USE `sistema_hotel`;
DROP procedure IF EXISTS `Insert_TipoDoc`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE insert_TipoDoc(
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
    IN p_idTipoDoc INT)
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
    IN p_precioPorNoche DECIMAL(10, 2))
BEGIN
    INSERT INTO Habitacion (numHabit, idAcomodacion, precioPorNoche, estado)
    VALUES (p_numHabit, p_idAcomodacion, p_precioPorNoche, 'Disponible'); 
    
END$$

DELIMITER ;

USE `sistema_hotel`;
DROP procedure IF EXISTS `InsertReserva`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE InsertReserva(
	IN p_idCliente INT,
    IN p_idHabitacion INT,
    IN p_checkIn DATETIME,
    IN p_checkOut DATETIME
    )
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Cliente WHERE idCliente = p_idCliente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El ID de Cliente no existe.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Habitacion WHERE idHabitacion = p_idHabitacion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El ID de Habitación no existe.';
    END IF;


    IF p_checkOut <= p_checkIn THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La fecha de Check-Out debe ser posterior a la de Check-In.';
    END IF;

    INSERT INTO Reserva (idCliente, idHabitacion, checkIn, checkOut, precioTotal, estado)
    VALUES (p_idCliente, p_idHabitacion, p_checkIn, p_checkOut, NULL, 'Pendiente'); 

END$$

DELIMITER ;

USE `sistema_hotel`;
DROP procedure IF EXISTS `InsetDisponibilidad`;

DELIMITER $$
USE `sistema_hotel`$$
CREATE PROCEDURE InsetDisponibilidad (
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


