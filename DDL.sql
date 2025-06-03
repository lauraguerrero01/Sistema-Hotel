DROP DATABASE if exists sistema_hotel;
CREATE DATABASE sistema_hotel;

USE sistema_hotel;

CREATE TABLE TipoDocumento (
	idTipo INT NOT NULL auto_increment,
    nombre varchar (255) NOT NULL,
    PRIMARY KEY (idTipo)
);
CREATE TABLE Cliente (
	idCliente INT NOT NULL auto_increment,
    numdoc INT NOT NULL,
    nombre varchar (50) NOT NULL,
    apellido varchar (50) NOT NULL,
    telefono varchar (20) NOT NULL,
    correo varchar (100) NOT NULL,
    idTipoDoc INT NOT NULL,
    PRIMARY KEY (idCliente)
);

CREATE TABLE Acomodacion (
	idAcomodacion INT NOT NULL auto_increment,
    tipoAcomodacion VARCHAR (50) NOT NULL,
    capacidad INT NOT NULL,
    descripcion VARCHAR (100),
    PRIMARY KEY (idAcomodacion)
);

CREATE TABLE Habitacion (
	idHabitacion INT NOT NULL auto_increment,
	numHabit VARCHAR (10) NOT NULL UNIQUE ,
	idAcomodacion INT NOT NULL, 
	precioPorNoche DECIMAL (10, 3) NOT NULL,
	estado VARCHAR (20) DEFAULT "Disponible",
    PRIMARY KEY (idHabitacion),
	CONSTRAINT chk_estado_habitacion CHECK (estado IN ("Disponible", "Ocupada", "Mantenimiento", "Limpieza"))

);

DROP TABLE IF EXISTS Reserva;
CREATE TABLE Reserva (
	idReserva INT NOT NULL auto_increment,
	idCliente INT NOT NULL,
	idHabitacion INT NOT NULL,
	checkIn DATETIME NOT NULL, 
	checkOut DATETIME NOT NULL,
    fechaHoraReserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    precioTotal DECIMAL(10, 3),
    estado ENUM("Pendiente", "Confirmada", "Cancelada", "Check-in", "Check-out") DEFAULT 'Pendiente',
    PRIMARY KEY (idReserva)
);



CREATE TABLE Disponibilidad ( 
idDisponibilidad INT NOT NULL auto_increment,
idHabitacion INT NOT NULL,
fecha date NOT NULL,
disponible boolean NOT NULL DEFAULT TRUE,
PRIMARY KEY (idDisponibilidad),
UNIQUE (idHabitacion, fecha) -- Asegura que solo haya una entrada de disponibilidad por habitación por día.
);


CREATE TABLE HistorialReserva (
    idHistorial INT AUTO_INCREMENT,
    idReserva INT,
    idCliente INT,
    idHabitacion INT,
    tipoAcomodacion VARCHAR(50),
    fechaHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estadoActual VARCHAR(20),
    diasEstadia INT,
    costoTotal DECIMAL(10,3),
    tipoAccion VARCHAR(50) DEFAULT "Actualización",
    PRIMARY KEY (idHistorial)
);


ALTER TABLE Cliente
ADD constraint FK_TipoDocumento_Cliente
foreign key (idTipoDoc) REFERENCES TipoDocumento (idTipo);

ALTER TABLE Habitacion
ADD constraint fk_idAcomodacion_Habitacion
foreign key (idAcomodacion) REFERENCES Acomodacion (idAcomodacion);

ALTER TABLE Reserva
ADD constraint fk_idCliente_Reserva
foreign key (idCliente) REFERENCES Cliente (idCliente);

ALTER TABLE Reserva 
ADD constraint fk_idHabitacion_Reserva
foreign key (idHabitacion) REFERENCES Habitacion (idHabitacion);

ALTER TABLE Disponibilidad 
ADD constraint fk_idHabitacion_disponibilidad
foreign key (idHabitacion) REFERENCES Habitacion (idHabitacion);

