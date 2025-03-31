-- Retrieval and Analyse Queries
-- Retrieve all customers
SELECT * FROM Customers;

-- Get all menu items with their categories and prices
SELECT Item_Name, Category_ID, Price FROM Menu_Items;

-- Find all orders placed on a specific date
SELECT * FROM Orders WHERE Order_Date = '2024-03-31';

-- Find all available (vacant) tables
SELECT * FROM Reservations WHERE Status = 'Vacant';

-- Get order details along with customer names
SELECT O.Order_ID, C.First_Name, C.Last_Name, O.Order_Date, O.Total_Amount
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID;

-- Find orders for a specific waiter (employee)
SELECT O.Order_ID, C.First_Name AS Customer_Name, O.Order_Date, O.Order_Status
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
WHERE O.Employee_ID = 10;

-- Count total customers who visited the restaurant
SELECT COUNT(*) AS Total_Customers FROM Customers;

-- Find total revenue generated from orders
SELECT SUM(Total_Amount) AS Total_Revenue FROM Orders;

-- Get the frequency of ordered menu items
SELECT MI.Item_Name, COUNT(OI.Item_ID) AS Order_Frequency
FROM Order_Items OI
JOIN Menu_Items MI ON OI.Item_ID = MI.Item_ID
GROUP BY MI.Item_Name
ORDER BY Order_Frequency DESC;

-- Find total revenue generated from each category
SELECT MC.Category_Name, SUM(OI.Quantity * MI.Price) AS Total_Revenue
FROM Order_Items OI
JOIN Menu_Items MI ON OI.Item_ID = MI.Item_ID
JOIN Menu_Categories MC ON MI.Category_ID = MC.Category_ID
GROUP BY MC.Category_Name
ORDER BY Total_Revenue DESC;

-- Updation Queries
-- Update customer contact information
UPDATE Customers 
SET Contact_Number = '9876543210', Email = 'rahul.updated@email.com' 
WHERE Customer_ID = 3;

-- Change order status from 'Pending' to 'Completed'
UPDATE Orders 
SET Order_Status = 'Completed' 
WHERE Order_ID = 8;

SET SQL_SAFE_UPDATES = 0;

UPDATE Employees  
SET Salary = Salary * 1.10  
WHERE Role = 'Waiter' 
AND Employee_ID IN (
    SELECT Employee_ID FROM Orders  
    GROUP BY Employee_ID  
    HAVING COUNT(Order_ID) > 50
);

SET SQL_SAFE_UPDATES = 1;



SET SQL_SAFE_UPDATES = 0;

UPDATE Orders  
SET Total_Amount = Total_Amount * 0.90  
WHERE Total_Amount > 1000 AND Payment_Status = 'Pending';

SET SQL_SAFE_UPDATES = 1;


-- Auto-assign waiters to unassigned orders
UPDATE Orders 
SET Employee_ID = (
    SELECT Employee_ID FROM Employees 
    WHERE Role = 'Waiter' 
    ORDER BY Hire_Date ASC LIMIT 1
) 
WHERE Employee_ID IS NULL;

-- Restock inventory items that have fallen below the threshold
SET SQL_SAFE_UPDATES = 0;

UPDATE Inventory  
SET Quantity = Quantity + 50  
WHERE Quantity < 10;

SET SQL_SAFE_UPDATES = 1;

-- Increase chef salaries based on experience
SET SQL_SAFE_UPDATES = 0;

UPDATE Employees 
SET Salary = Salary * 1.15 
WHERE Role = 'Chef' AND Hire_Date <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

SET SQL_SAFE_UPDATES = 1;


