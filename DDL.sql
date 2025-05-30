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
	precioPorNoche DECIMAL (10, 2) NOT NULL,
	estado VARCHAR (20) DEFAULT "Disponible",
    PRIMARY KEY (idHabitacion)
);

CREATE TABLE Reserva (
	idReserva INT NOT NULL auto_increment,
	idCliente INT NOT NULL,
	idHabitacion INT NOT NULL,
	checkIn datetime NOT NULL, 
	checkOut datetime NOT NULL,
    precioTotal DECIMAL (10, 2),
    estado VARCHAR (20) DEFAULT "Pendiente",
    PRIMARY KEY (idReserva)
);

CREATE TABLE Disponibilidad ( 
idDisponibilidad INT NOT NULL auto_increment,
idHabitacion INT NOT NULL,
fecha date NOT NULL,
disponible boolean NOT NULL DEFAULT TRUE,
PRIMARY KEY (idDisponibilidad)
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