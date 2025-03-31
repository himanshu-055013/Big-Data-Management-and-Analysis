SHOW DATABASES;
USE restaurant_management_system;
SHOW TABLES;
-- Check Customers table for multi-valued attributes
SELECT * FROM Customers
WHERE Contact_Number LIKE '%,%' 
   OR Email LIKE '%,%';

-- Check Customer_Addresses table for multi-valued attributes
SELECT * FROM Customer_Addresses
WHERE Address_Line1 LIKE '%,%' 
   OR Address_Line2 LIKE '%,%';

-- Check Employees table for multi-valued attributes
SELECT * FROM Employees
WHERE Role LIKE '%,%' 
   OR Contact_Number LIKE '%,%' 
   OR Email LIKE '%,%';

-- Check Reservations table for multi-valued attributes
SELECT * FROM Reservations
WHERE Status LIKE '%,%' 
   OR Special_Request LIKE '%,%';

-- Check Menu_Categories table for multi-valued attributes
SELECT * FROM Menu_Categories
WHERE Category_Name LIKE '%,%' 
   OR Description LIKE '%,%';

-- Check Menu_Items table for multi-valued attributes
SELECT * FROM Menu_Items
WHERE Item_Name LIKE '%,%' 
   OR Description LIKE '%,%' 
   OR Availability_Status LIKE '%,%';

-- Check Orders table for multi-valued attributes
SELECT * FROM Orders
WHERE Payment_Status LIKE '%,%' 
   OR Order_Status LIKE '%,%';

-- Check Order_Items table for multi-valued attributes
-- (Typically numeric columns are used, but you can still check text columns if any)
SELECT * FROM Order_Items
WHERE Item_Price LIKE '%,%';

-- Check Suppliers table for multi-valued attributes
SELECT * FROM Suppliers 
WHERE Supplier_Name LIKE '%,%' 
   OR Contact_Number LIKE '%,%' 
   OR Email LIKE '%,%' 
   OR Product_Category LIKE '%,%';


-- Check Inventory table for multi-valued attributes
SELECT * FROM Inventory
WHERE Item_Name LIKE '%,%' 
   OR Category LIKE '%,%';

-- Check Payments table for multi-valued attributes
SELECT * FROM Payments
WHERE Payment_Mode LIKE '%,%';
-- Check for Missing Primary Keys
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'restaurant_management_system'
  AND TABLE_NAME NOT IN (
    SELECT DISTINCT TABLE_NAME
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE CONSTRAINT_NAME = 'PRIMARY'
  );
  -- check for Repeating Groups
  SELECT COLUMN_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'restaurant_management_system'
  AND COLUMN_NAME REGEXP '_[0-9]$';

