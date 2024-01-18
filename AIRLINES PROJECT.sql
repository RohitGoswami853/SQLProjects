CREATE DATABASE AIRLINES
USE  AIRLINES

CREATE TABLE AIRLINE(
AIRLINEID INT PRIMARY KEY,
AIRLINENAME VARCHAR(255) NOT NULL,
HEADQUATERS VARCHAR(255),
CONTACTNUMBER VARCHAR(15)
);


CREATE TABLE AIRCRAFT(
AIRCRAFTID INT PRIMARY KEY,
AIRCRAFTTYPE VARCHAR(255) NOT NULL,
REGISTRATIONNUMBER INT NOT NULL,
CAPACITY INT NOT NULL,
CURRENTSTATUS VARCHAR(20) DEFAULT 'ACTIVE',
AIRLINEID INT,
CONSTRAINT FK_ID FOREIGN KEY (AIRLINEID) REFERENCES AIRLINE(AIRLINEID)
);

CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    FlightNumber VARCHAR(10) NOT NULL,
    DepartureAirport VARCHAR(255) NOT NULL,
    ArrivalAirport VARCHAR(255) NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    AirlineID INT,
    AircraftID INT,
    FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
    FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
);

CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20),
    UNIQUE (Email, Phone)
);

CREATE TABLE Reservations (
    ReservationID INT,
    PassengerID INT,
    FlightID INT,
    SeatNumber VARCHAR(10),
    ReservationTime DATETIME NOT NULL,
    PRIMARY KEY (PassengerID, FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);


INSERT INTO Airline (AirlineID, AirlineName, Headquaters, ContactNumber) VALUES
(1, 'Airline A', 'City A', '123-456-7890'),
(2, 'Airline B', 'City B', '987-654-3210');

INSERT INTO Aircraft (AircraftID, AircraftType, RegistrationNumber, Capacity, CurrentStatus, AirlineID) VALUES
(1, 'Boeing 737', 'ABC123', 150, 'Active', 1),
(2, 'Airbus A320', 'XYZ789', 180, 'Active', 2);

INSERT INTO Flights (FlightID, FlightNumber, DepartureAirport, ArrivalAirport, DepartureTime, ArrivalTime, AirlineID, AircraftID) VALUES
(1, 'AA101', 'JFK', 'LAX', '2023-01-01 08:00:00', '2023-01-01 12:00:00', 1, 1),
(2, 'BA202', 'LHR', 'CDG', '2023-01-02 10:00:00', '2023-01-02 12:30:00', 2, 2);


INSERT INTO Passengers (PassengerID, FirstName, LastName, Email, Phone) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '555-1234'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '555-5678');


INSERT INTO Reservations (ReservationID, PassengerID, FlightID, SeatNumber, ReservationTime) VALUES
(1, 1, 1, 'A1', '2023-01-01 07:30:00'),
(2, 2, 2, 'B3', '2023-01-02 09:45:00');

ALTER TABLE AIRCRAFT
DROP COLUMN REGISTRATIONNUMBER;

ALTER TABLE AIRCRAFT
ADD REGISTRATIONNUMBER VARCHAR(100);

SELECT * FROM AIRLINE
SELECT * FROM AIRCRAFT
SELECT * FROM Flights
SELECT * FROM Passengers
SELECT * FROM Reservations

--Q1 RETRIVE INFO ABOUT ALL AIRLINES AND AIRCRAFTS
SELECT * FROM AIRLINE
SELECT * FROM AIRCRAFT

--Q2 RETRIVE A LIST OF PASSENGERS FOR A SPECIFIC FLIGHT
SELECT * FROM PASSENGERS P
LEFT JOIN Reservations R
ON P.PassengerID=R.PassengerID
LEFT JOIN Flights F
ON F.FlightID=R.FlightID
WHERE F.FlightID=1;

--Q3 RETRIVE A LIST OF FLIGHTS FOR A SPECIFIC AIRLINE
SELECT Flights.FlightNumber,Flights.DepartureAirport,Flights.ArrivalAirport,Flights.DepartureTime,Flights.ArrivalTime FROM Flights
LEFT JOIN AIRLINE
ON Flights.AirlineID=AIRLINE.AIRLINEID
WHERE AIRLINE.AIRLINEID=1;

--Q4 RETRIVE AVAILABLE SEATS FOR A SPECIFIC FLIGHT
SELECT Flights.FlightNumber,Flights.DepartureAirport,Flights.ArrivalAirport,Flights.DepartureTime,Flights.ArrivalTime
,AIRCRAFT.CAPACITY-(SELECT COUNT(Reservations.FlightID) FROM Reservations WHERE Flights.FlightID=2) AS AVAILABLE_SEATS 
FROM Flights
LEFT JOIN AIRCRAFT
ON Flights.AIRCRAFTID = AIRCRAFT.AIRCRAFTID
LEFT JOIN Reservations 
ON Flights.FlightID=Reservations.FlightID
WHERE Flights.FlightID=2 AND (SELECT COUNT(Reservations.FlightID) FROM Reservations WHERE Flights.FlightID=2)<AIRCRAFT.CAPACITY;


--Q5 RETRIVE THE TOTAL NUMBER OF RESERVATIONS FOR A SPECIFIC FLIGHT
SELECT COUNT(*) AS TOTALNUMBERRES 
FROM Reservations
WHERE FlightID=1;

--Q6 RETRIVE A LIST OF PASSENGERS WITH THEIR FLIGHT DETAILS FOR A SPECIFIC AIRLINE
SELECT Passengers.PassengerID, Passengers.FirstName, Passengers.LastName, Flights.FlightNumber,Flights.DepartureAirport,Flights.ArrivalAirport,Flights.DepartureTime,Flights.ArrivalTime FROM Passengers
LEFT JOIN Reservations
ON Passengers.PassengerID=Reservations.PassengerID
LEFT JOIN Flights
ON Reservations.FlightID=Flights.FlightID
WHERE Flights.AirlineID=2;

