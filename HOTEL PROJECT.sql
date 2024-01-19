CREATE DATABASE MakeMyTrip;
USE MakeMyTrip;

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    CONSTRAINT UC_Email UNIQUE (Email)
);

CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(100) NOT NULL,
    Location VARCHAR(50) NOT NULL,
    Rating DECIMAL(3, 2),
    CONSTRAINT UC_HotelName_Location UNIQUE (HotelName, Location)
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    UserID INT,
    HotelID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalAmount DECIMAL(10, 2),
    CONSTRAINT FK_Booking_User FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Booking_Hotel FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);


CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    UserID INT,
    HotelID INT,
    Rating DECIMAL(3, 2),
    Comment TEXT,
    CONSTRAINT FK_Review_User FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Review_Hotel FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);



INSERT INTO Users (UserID, UserName, Email, PhoneNumber)
VALUES
    (1, 'John Doe', 'john.doe@example.com', '+1234567890'),
    (2, 'Jane Smith', 'jane.smith@example.com', '+9876543210');


INSERT INTO Hotels (HotelID, HotelName, Location, Rating)
VALUES
    (101, 'Luxury Inn', 'City A', 4.5),
    (102, 'Comfort Suites', 'City B', 3.8);


INSERT INTO Bookings (BookingID, UserID, HotelID, CheckInDate, CheckOutDate, TotalAmount)
VALUES
    (1001, 1, 101, '2023-06-15', '2023-06-20', 1200.00),
    (1002, 2, 102, '2023-07-10', '2023-07-15', 900.50);

INSERT INTO Reviews (ReviewID, UserID, HotelID, Rating, Comment)
VALUES
    (501, 1, 101, 4.0, 'Great experience!'),
    (502, 2, 102, 3.5, 'Good service but room cleanliness can be improved.');


SELECT * FROM Users
SELECT * FROM Hotels
SELECT * FROM Bookings
SELECT * FROM Reviews

INSERT INTO USERS(UserID,UserName,Email,PhoneNumber)
VALUES ( 3, 'WUHU SAM', 'wuhusam@example.com','+877498484686'); 

-- Q1) RETRIVE ALL USERS
SELECT * FROM USERS;

-- Q2) RETRIVE ALL HOTELS
SELECT * FROM Hotels;

-- Q3) RETRIVE BOOKINGS WITH USER AND HOTEL	DETAILS
SELECT Bookings.BookingID, Users.UserName, Users.PhoneNumber, Users.Email, Hotels.HotelName, Hotels.Location 
,Bookings.CheckInDate,Bookings.CheckOutDate,Bookings.TotalAmount FROM Bookings
LEFT JOIN Users
ON Bookings.UserID=Users.UserID
LEFT JOIN Hotels
ON Bookings.HotelID= Hotels.HotelID;

-- Q4) RETRIVE REVIEWS WITH USER AND HOTEL DETAILS 
SELECT Reviews.ReviewID, Users.UserName, Users.PhoneNumber, Users.Email, Hotels.HotelName, Hotels.Rating AS HotelRating
,Reviews.Rating as UserRating, Reviews.Comment FROM Reviews
LEFT JOIN Users
ON Reviews.UserID=Users.UserID
LEFT JOIN Hotels
ON Reviews.HotelID= Hotels.HotelID;