-- Tipo Documento 
CALL Insert_TipoDoc (1,"CC");
CALL Insert_TipoDoc (2,"TI");
CALL Insert_TipoDoc (3,"PAS");
CALL Insert_TipoDoc (4,"CE");

-- Acomodación 
CALL InsertAcomodacion("Individual", 1, "Ideal para una persona");      
CALL InsertAcomodacion("Doble", 2, "Perfecta para parejas o dos amigos");      
CALL InsertAcomodacion("Triple", 3, "Espaciosa para grupos pequeños");  
CALL InsertAcomodacion("Familiar", 4, "Amplia para familias o grupos grandes"); 

-- Habitación Individual
CALL InsertHabitacion("101", 1, 60.000);
CALL InsertHabitacion("102", 1, 60.000);
CALL InsertHabitacion("103", 1, 65.000); 
-- Habitación Doble
CALL InsertHabitacion("201", 2, 90.000);
CALL InsertHabitacion("202", 2, 90.000);
CALL InsertHabitacion("203", 2, 95.000);
CALL InsertHabitacion("204", 2, 95.000);
CALL InsertHabitacion("205", 2, 100.000); 
-- Habitación Triple
CALL InsertHabitacion("301", 3, 130.000);
CALL InsertHabitacion("302", 3, 135.000);
CALL InsertHabitacion("303", 3, 140.000);
-- Habitación Familiar
CALL InsertHabitacion("401", 4, 180.000);
CALL InsertHabitacion("402", 4, 185.000);
CALL InsertHabitacion("403", 4, 190.000);
CALL InsertHabitacion("404", 4, 200.000); 

-- Cliente
CAll InsertCliente(126717327, "Juliana", "Correa", 3217628373, "julicorrea@gmail.com", 4);
CALL InsertCliente(106527887, "Ana", "Gómez", "3011234567", "ana.gomez@gmail.com", 1);      
CALL InsertCliente(229480302, "Luis", "Pérez", "3022345678", "luis.perez@gmail.com", 3);       
CALL InsertCliente(173812792, "Marta", "Rodríguez", 3033456789, "marta.r@hotmail.com", 1);   
CALL InsertCliente(782048718, "Pablo", "Martínez", 3044567890, "pablo.m@gmail.com", 4);    
CALL InsertCliente(503943289, "Sofía", "Hernández", 3055678901, "sofia.h@hotmail.com", 1);  
CALL InsertCliente(613929381, "Diego", "Díaz", 3066789012, "diego.d@hotmail.com", 1);         
CALL InsertCliente(702494246, "Emma", "Brown", 3077890123, "emma.b@gmail.com", 4);
CALL InsertCliente(802847248, "Liam", "Jones", 3088901234, "liam.j@gmail.com", 1);  
CALL InsertCliente(193824734, "Sara", "López", 3099012345, "sara.l@gmail.com", 3);         
CALL InsertCliente(101462805, "Juan", "Castro", 3101234567, "juan.c@hotmail.com", 4);  


-- Reserva
CALL InsertReserva(
    (SELECT idCliente FROM Cliente WHERE numdoc = 101462805),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "101"),"2025-06-05","2025-06-07"
);
CALL InsertReserva(
    (SELECT idCliente FROM Cliente WHERE numdoc = 613929381),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "201"),"2025-07-01","2025-07-05"
);
CALL InsertReserva(
    (SELECT idCliente FROM Cliente WHERE numdoc = 126717327),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "301"),"2025-06-12","2025-06-15"
);
CALL InsertReserva(
    (SELECT idCliente FROM Cliente WHERE numdoc = 503943289),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "401"),"2025-08-10","2025-08-15"
);
CALL InsertReserva(
    (SELECT idCliente FROM Cliente WHERE numdoc = 782048718),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "102"),"2025-06-01","2025-06-02"
);
CALL InsertReserva(
	(SELECT idCliente FROM Cliente WHERE numdoc = 702494246),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "202"),"2025-07-20","2025-07-27"
);
CALL InsertReserva(
    (SELECT idCliente FROM Cliente WHERE numdoc = 106527887),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "205"),"2025-06-08","2025-06-10"
);
CALL InsertReserva(
	(SELECT idCliente FROM Cliente WHERE numdoc = 193824734),(SELECT idHabitacion FROM Habitacion WHERE numHabit = "302"),"2025-09-01","2025-09-05"
);    
