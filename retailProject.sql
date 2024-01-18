--Create Database Retail
--Use Retail

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave');


INSERT INTO Categories (CategoryID, CategoryName)
VALUES
    (1, 'Electronics'),
    (2, 'Clothing'),
    (3, 'Home and Garden');


INSERT INTO Products (ProductID, ProductName, Description, Price, StockQuantity, CategoryID)
VALUES
    (1, 'Laptop', 'High-performance laptop', 999.99, 50, 1),
    (2, 'T-Shirt', 'Cotton T-shirt', 19.99, 100, 2),
    (3, 'LED TV', 'Smart LED TV', 499.99, 30, 1);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status)
VALUES
    (1, 1, '2023-01-01', 999.99, 'Completed'),
    (2, 2, '2023-02-01', 39.98, 'Pending'),
 (3, 1, '2023-03-01', 999.99, 'In-Tansit'),
    (4, 2, '2023-03-01', 39.98, 'In-Transit');


INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal)
VALUES
    (1, 1, 1, 1, 999.99),
    (2, 1, 2, 2, 39.98),
 (3, 2, 3, 1, 900.99)

SELECT * FROM Customers
SELECT * FROM Categories
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM OrderItems

--Q1) Top selling Products
 SELECT OrderItems.ProductID, OrderItems.QUANTITY, Products.ProductName, Products.Description FROM OrderItems
 LEFT JOIN Products
 ON OrderItems.ProductID= Products.ProductID
 WHERE Quantity= (SELECT MAX(QUANTITY) FROM OrderItems);


--Q2) NUMBER OF ORDERS PER MONTH
select count(*) as  TotalOrders, month(orderdate) as Months ,YEAR(orderdate) as Year_
from Orders
group by YEAR(OrderDate),Month(OrderDate);

--Q3) CALCULATE TOTAL REVENUE FOR A SPECIFIC PERIOD
SELECT SUM(TOTALAMOUNT) as Total_Revenue FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' and '2023-03-01';

--Q4) RETRIVE ORDER DETAILS INCLUDING PRODUCTS
select o.OrderID,o.CustomerID,p.ProductName,p.Description, o.OrderDate,o.TotalAmount,o.Status from orders o
left join OrderItems oi
on o.OrderID=oi.OrderID
left join Products p
on oi.ProductID=p.ProductID;

--Q5) RETRIVE PRODUCTS IN A SPECIFIC CATEGORY
SELECT * FROM Products
LEFT JOIN Categories
ON Products.CategoryID= Categories.CategoryID
WHERE Categories.CategoryID=1;

--Q6) RETRIVE PRODUCT DETAILS BY NAME
SELECT * FROM Products
WHERE ProductName='LED TV';

--Q7) RETRIVE ALL ORDERS FOR A CUSTOMER
SELECT Customers.CustomerID,Customers.FirstName,Customers.LastName,Customers.Phone,Orders.OrderID,Orders.TotalAmount,Products.ProductName FROM Customers
LEFT JOIN Orders
ON Orders.CustomerID=Customers.CustomerID
LEFT JOIN OrderItems
ON OrderItems.OrderID=Orders.OrderID
LEFT JOIN Products
ON OrderItems.ProductID=Products.ProductID
WHERE Customers.CustomerID=1;
