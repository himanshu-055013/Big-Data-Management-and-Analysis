-- Create the database and switch to it
CREATE DATABASE restaurant_management_system;
USE restaurant_management_system;

-- Table for customers of the restaurant
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    DOB DATE,
    Gender CHAR(1),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100)
);

-- Table for storing customer addresses
CREATE TABLE Customer_Addresses (
    Address_ID INT PRIMARY KEY,
    Customer_ID INT,
    Address_Line1 VARCHAR(255),
    Address_Line2 VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    ZIP_Code VARCHAR(10),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Table for restaurant employees (servers, chefs, etc.)
CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Role VARCHAR(100),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Salary DECIMAL(10,2),
    Hire_Date DATE
);

-- Table for table reservations made by customers
CREATE TABLE Reservations (
    Reservation_ID INT PRIMARY KEY,
    Customer_ID INT,
    Reservation_Date DATE,
    Reservation_Time TIME,
    Number_Of_People INT,
    Status VARCHAR(50),
    Special_Request TEXT,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Table for categorizing menu items (e.g., Appetizers, Main Course, Desserts, etc.)
CREATE TABLE Menu_Categories (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(100),
    Description TEXT
);

-- Table for individual menu items
CREATE TABLE Menu_Items (
    Item_ID INT PRIMARY KEY,
    Category_ID INT,
    Item_Name VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10,2),
    Availability_Status VARCHAR(50),
    FOREIGN KEY (Category_ID) REFERENCES Menu_Categories(Category_ID)
);

-- Table for recording customer orders
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Employee_ID INT,  -- Employee who took the order
    Order_Date DATE,
    Order_Time TIME,
    Total_Amount DECIMAL(10,2),
    Payment_Status VARCHAR(50),
    Order_Status VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

-- Table for the details of each order (items ordered, quantity, and price)
CREATE TABLE Order_Items (
    OrderItem_ID INT PRIMARY KEY,
    Order_ID INT,
    Item_ID INT,
    Quantity INT,
    Item_Price DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Item_ID) REFERENCES Menu_Items(Item_ID)
);

-- Table for storing information on suppliers who provide goods to the restaurant
CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(100),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT,
    Product_Category VARCHAR(100)
);

-- Table for restaurant inventory such as ingredients and supplies
CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Item_Name VARCHAR(100),
    Category VARCHAR(100),
    Quantity INT,
    Supplier_ID INT,
    Purchase_Date DATE,
    FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID)
);

-- Table for tracking payments made by customers for orders
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT,
    Amount_Paid DECIMAL(10,2),
    Payment_Date DATE,
    Payment_Mode VARCHAR(50),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);
