-- Historial de Reservas 
SELECT 
    H.idHistorial,
    C.numdoc,
    C.nombre, 
    C.apellido,
    (SELECT numHabit 
     FROM Habitacion 
     WHERE Habitacion.idHabitacion = H.idHabitacion) AS Habitacion,
    H.tipoAcomodacion,
    H.fechaHora,
    H.estadoActual,
    H.diasEstadia,
    H.costoTotal,
    H.tipoAccion
FROM HistorialReserva H
JOIN Cliente C ON H.idCliente = C.idCliente;


-- Disponibiliodad de Habitaciones
SELECT 
    numHabit,
    estado
FROM Habitacion;

-- Reserva con descuento por cliente 
SELECT 
    C.numDoc,
    C.nombre,
    C.apellido,
    R.fechaHoraReserva,
    R.checkIn,
    R.checkOut,
    DATEDIFF(R.checkOut, R.checkIn) AS diasEstadia,
    H.precioPorNoche,
    DATEDIFF(R.checkIn, R.fechaHoraReserva) AS diasAnticipacion,
    CASE 
        WHEN DATEDIFF(R.checkIn, R.fechaHoraReserva) >= 15 THEN 'Sí'
        ELSE 'No'
    END AS tieneDescuento,
    ROUND((H.precioPorNoche * DATEDIFF(R.checkOut, R.checkIn)), 3) AS precioBase,
    ROUND(R.precioTotal, 3) AS totalAPagar
FROM 
    Reserva R
JOIN 
    Cliente C ON R.idCliente = C.idCliente
JOIN 
    Habitacion H ON R.idHabitacion = H.idHabitacion
WHERE 
    C.numDoc = 101462805;  -- Aquí cambias el número de documento según el cliente que desees consultar



-- Reserva con descuento de todos los clientes 
SELECT 
	C.numDoc,
    C.nombre,
    C.apellido,
    R.fechaHoraReserva,
    R.checkIn,
    R.checkOut,
    DATEDIFF(R.checkOut, R.checkIn) AS diasEstadia,
    H.precioPorNoche,
    DATEDIFF(R.checkIn, R.fechaHoraReserva) AS diasAnticipacion,
    CASE 
        WHEN DATEDIFF(R.checkIn, R.fechaHoraReserva) >= 15 THEN 'Sí'
        ELSE 'No'
    END AS tieneDescuento,
    (H.precioPorNoche * DATEDIFF(R.checkOut, R.checkIn)) AS precioBase,
    R.precioTotal AS totalAPagar
FROM 
    Reserva R
JOIN 
    Cliente C ON R.idCliente = C.idCliente
JOIN 
    Habitacion H ON R.idHabitacion = H.idHabitacion;


