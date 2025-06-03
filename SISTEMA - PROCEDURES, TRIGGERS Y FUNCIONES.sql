-- Calcular costo total
DROP FUNCTION IF EXISTS calcular_costo_total;
DELIMITER $$

CREATE FUNCTION calcular_costo_total(
    p_idHabitacion INT,
    p_checkIn DATETIME,
    p_checkOut DATETIME
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE dias INT;
    DECLARE precioNoche DECIMAL(10,3);
    DECLARE total DECIMAL(10,3);

    SET dias = DATEDIFF(p_checkOut, p_checkIn);
    SELECT precioPorNoche INTO precioNoche
    FROM Habitacion
    WHERE idHabitacion = p_idHabitacion;

    SET total = dias * precioNoche;
    RETURN total;
END$$

DELIMITER ;

-- Actualizar el estado de la habitación
DROP TRIGGER IF EXISTS actualizar_estado_habitacion;
DELIMITER $$

CREATE TRIGGER actualizar_estado_habitacion
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF NEW.estado IN ("Confirmada", "Check-in") THEN
        UPDATE Habitacion
        SET estado = "Ocupada"
        WHERE idHabitacion = NEW.idHabitacion;
    END IF;
END$$

DELIMITER ;


-- Historial de cambios en reserva
DROP TRIGGER IF EXISTS guardar_historial_reserva;
DELIMITER $$

CREATE TRIGGER guardar_historial_reserva
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
    DECLARE dias INT;
    DECLARE tipoAcomodacion VARCHAR(50);
    DECLARE precioTotal DECIMAL(10,3);

    SET dias = DATEDIFF(NEW.checkOut, NEW.checkIn);
    
    SELECT A.tipoAcomodacion INTO tipoAcomodacion
    FROM Habitacion H
    JOIN Acomodacion A ON H.idAcomodacion = A.idAcomodacion
    WHERE H.idHabitacion = NEW.idHabitacion;

    SET precioTotal = calcular_costo_total(NEW.idHabitacion, NEW.checkIn, NEW.checkOut);

    INSERT INTO HistorialReserva (idReserva, idCliente, idHabitacion, tipoAcomodacion, estadoActual, diasEstadia, costoTotal)
    VALUES (NEW.idReserva, NEW.idCliente, NEW.idHabitacion, tipoAcomodacion, NEW.estado, dias, precioTotal);
END$$

DELIMITER ;



-- Reserva y descuento
DELIMITER //
CREATE PROCEDURE InsertReserva(
    IN p_idCliente INT,
    IN p_idHabitacion INT,
    IN p_checkIn DATETIME,
    IN p_checkOut DATETIME
)
BEGIN
    DECLARE precioNoche DECIMAL(10,3);
    DECLARE diasEstancia INT;
    DECLARE precioFinal DECIMAL(10,3);

    SELECT precioPorNoche INTO precioNoche
    FROM Habitacion
    WHERE idHabitacion = p_idHabitacion;

    SET diasEstancia = DATEDIFF(p_checkOut, p_checkIn);
    SET precioFinal = precioNoche * diasEstancia;

    IF DATEDIFF(p_checkIn, NOW()) >= 15 THEN
        SET precioFinal = precioFinal * 0.90;
    END IF;

    INSERT INTO Reserva (
        idCliente, idHabitacion, checkIn, checkOut, precioTotal, estado, fechaHoraReserva
    ) VALUES (
        p_idCliente, p_idHabitacion, p_checkIn, p_checkOut, precioFinal, 'Confirmada', NOW()
    );
END //
DELIMITER ;
