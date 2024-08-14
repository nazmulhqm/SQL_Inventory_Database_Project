--================================================================================================================
--                                  DML_Inventory_Management_System_Project
--================================================================================================================

------==================================================================================
---                              Insert into Table
------==================================================================================
USE InventoryDB
-- Inserting data into Addresses table
INSERT INTO ims.Addresses(Address1,Address2,City,Country) 
			  VALUES ('Flat 101, House 15, Road 5', 'Gulshan', 'Dhaka', 'Bangladesh'),
					 ('23, Green Road', 'Farmgate', 'Dhaka', 'Bangladesh'),
					 ('Block B, Lalmatia', 'Behind Lake Circus', 'Dhaka', 'Bangladesh'),
					 ('Holding 7, Ward 4', 'Mirpur', 'Dhaka', 'Bangladesh'),
					 ('34, Nandan Kanan', 'Bashundhara', 'Dhaka', 'Bangladesh'),
					 ('2nd Floor, Building 9', 'Uttara', 'Dhaka', 'Bangladesh'),
					 ('14, Kazi Nazrul Islam Avenue', 'Karwan Bazar', 'Dhaka', 'Bangladesh'),
					 ('88, DIT Avenue', 'Malibagh', 'Dhaka', 'Bangladesh'),
					 ('Flat 301, Orchid Plaza', 'Shyamoli', 'Dhaka', 'Bangladesh'),
					 ('House 45, Road 8', 'Baridhara', 'Dhaka', 'Bangladesh'),
					 ('5th Floor, Star Tower', 'Tejgaon', 'Dhaka', 'Bangladesh'),
					 ('67, Elephant Road', 'Hathi Bagan', 'Dhaka', 'Bangladesh'),
					 ('3C, Niketon', 'Gulshan 1', 'Dhaka', 'Bangladesh'),
					 ('6, Dhanmondi', 'Lake Road', 'Dhaka', 'Bangladesh'),
					 ('Sector 11, Uttara', 'Near Rajlakshmi Complex', 'Dhaka', 'Bangladesh'),
					 ('House 29, Road 16', 'Banani', 'Dhaka', 'Bangladesh'),
					 ('Flat 201, Rupayan Golden Age', 'Puran Dhaka', 'Dhaka', 'Bangladesh'),
					 ('13, Green View', 'Mirpur DOHS', 'Dhaka', 'Bangladesh'),
					 ('18, North Road', 'Vatara', 'Dhaka', 'Bangladesh'),
					 ('Halisahar', 'Block-B', 'Chittagong', 'Bangladesh')
GO

-- Inserting data into Contacts table
USE InventoryDB
INSERT INTO ims.Contacts(ContactFirstName,ContactLastName,Phone,Email) 
			 VALUES ('Md. Rahman', 'Ali', '01711223344','Ali@gmail.com'),
					('Sara', 'Ahmed', '01666557788','Ahmed@gmail.com'),
					('Mousumi', 'Khan', '01887766778','Khan@gmail.com'),
					('Tariqul', 'Islam', '01554488999','Islam'),
					('Ayesha', 'Akter', '01999001122','Akter'),
					('Rajib', 'Hossain', '01678901234','Hossain'),
					('Sabrina', 'Nasrin', '01755566777','Nasrin'),
					('Faisal', 'Haque', '01899005555','Haque@gmail.com'),
					('Nusrat', 'Chowdhury', '01522113344',NULL),
					('Imran', 'Kabir', '01777665544',NULL),
					('Nadia', 'Ahmed', '01999778866','Nadia@gmail.com'),
					('Mehedi', 'Hossain', '01666699888',NULL),
					('Tasnim', 'Rahman', NULL,'TasnimR@Yahoo.com'),
					('Aminul', 'Islam', '01555669911','Aminul@Yahoo.com'),
					('Farhana', 'Khan', NULL,'Farhana@Mail.com'),
					('Belal', 'Ahmed', '01999774566','Belal@gmail.com'),
					('Kamal', 'Hossain', '01666109888',NULL),
					('Taushi', 'Rahman', NULL,'RadmanT@Yahoo.com'),
					('Zahidul', 'Islam', '01555669311','Zahid094@Yahoo.com'),
					('Arman', 'Khan', NULL,'Arman@Mail.com')
GO

-- Inserting data into Brands table
USE InventoryDB
INSERT INTO ims.Brands 
		     VALUES('TechSmart',1),
		    	   ('BioFresh',2),
		    	   ('PrimePulse',3)
GO

-- Inserting data into Manufacturers table
USE InventoryDB
INSERT INTO ims.Manufacturers 
			 VALUES('InnovateTech Solutions Ltd.',4,1),
    			   ('EcoLife Inc.',5,2),
    			   ('Global Dynamics Ltd',6,3)
GO

-- Inserting data into Suppliers table
USE InventoryDB
INSERT INTO ims.Suppliers (SupplierName, ContactID, AddressID)
   		     VALUES('ABC Electronics', 7, 4),
   				   ('Green Innovations', 8, 5),
   				   ('Quality Goods', 9, 6)
GO

-- Inserting data into ProductCategories table
USE InventoryDB
INSERT INTO ims.ProductCategories (CategoryName, Description, ParentCategoriesID)
			 VALUES('Electronics', 'Electronic devices and accessories', NULL),
				   ('Groceries', 'Various food and grocery items', NULL),
				   ('Soft Drinks', 'Non-alcoholic beverages', NULL),
				   ('Mobile Phones', 'Cell phones and accessories', 1),
				   ('Laptops', 'Portable computers and accessories', 1),
				   ('Smart TVs', 'Television sets with smart features', 1),
				   ('Fresh Produce', 'Fresh fruits and vegetables', 2),
				   ('Canned Goods', 'Canned and preserved food items', 2),
				   ('Snacks', 'Snack items and packaged foods', 2),
				   ('Sodas', 'Carbonated soft drinks', 3),
				   ('Juices', 'Fruit and vegetable juices', 3),
				   ('Water', 'Bottled water and related products', 3)
GO

-- Inserting data into Customers table
USE InventoryDB
INSERT INTO ims.Customers (CustomerFirstName, CustomerLastName, HomePhoneNo, OfficePhoneNo, AddressID)
			 VALUES('Amit', 'Das', '01666778899', '018-7654321', 7),
			 	   ('Nazia', 'Islam', '01788990011', '019-1234567', 8),
			 	   ('Kamal', 'Hossain', '01556667777', '017-8765432', 9),
			 	   ('Rakib', 'Khan', '01998887766', '015-2345678', 10),
			 	   ('Sonia', 'Ahmed', '01665554444', Null, 11),
			 	   ('Imtiaz', 'Chowdhury', '01770001111', '018-1234567', 12),
			 	   ('Nabila', 'Rahman', '01886663333', '018-9876543', 13)
GO

-- Inserting data into Products table
USE InventoryDB
INSERT INTO ims.Products(ProductName,Description,Image,supplier_id,UnitPrice) 
			 VALUES('Laptop', 'High-performance laptop',NULL,1,2600),
			       ('Smartphone', 'Latest smartphone model',NULL,1,100),
			       ('Water', 'Mineral Water',NULL,3,10),
			       ('Tablet', 'Lightweight and portable tablet',NULL,1,199),
			       ('Washing Machine', 'Front-load washing machine',NULL,1,1000),
			       ('Microwave Oven', 'Convection microwave oven',NULL,1,1200),
			       ('Juice', 'Assorted fruit juice pack',NULL,1,50),
			       ('Iced Tea', 'Refreshing iced tea',NULL,3,20),
			       ('Sports Drink', 'Electrolyte-infused sports drink',NULL,3,35),
			       ('Energy Drink', 'High-energy performance drink',NULL,3,30),
			       ('Soda', 'Assorted soda variety pack',NULL,1,15);
GO

-- Inserting data into ProductsCategory table
USE InventoryDB
INSERT INTO ims.ProductsCategory (ProductID, ProductCategoriesID)
			  VALUES
			      (1, 1), (2, 1),(4,1),(5, 1),(6,1), -- Electronics
			      (3, 3), (7, 3),(8,3),(9, 3),(10,3),(11,3),-- Soft Drinks
			      (2, 4), -- Mobile Phones
			      (1, 5), (4, 5), -- Laptops
			      (7, 11), (8, 11), -- Juices
			      (3, 12); -- Water
GO

-- Insert data into Discounts table
USE InventoryDB
INSERT INTO ims.Discounts (Description, DiscountPercentage, StartDate, EndDate, IsActive)
		     VALUES('20% Off Electronics', 20, '2023-06-01', '2023-08-31', 1),
		           ('10% Off Groceries', 10, '2023-12-01', '2023-12-31',1),
		           ('Clearance Discount',50, '2023-09-15', '2023-09-30', 0);
GO
--================================================================================================================
--                                 Insert with store procedure
--================================================================================================================
--Executing stock In Stored Procedure
USE InventoryDB
	EXEC sp_StocksIn 1,100,10,'2023-01-01','2022-01-01'
GO 

--Executing Process Order Store Procedure
USE InventoryDB
	EXEC sp_processorder 1,1,100,1
GO

--================================================================================================================
--                                 Insert with View
--================================================================================================================
--Insert
USE InventoryDB
INSERT INTO vw_suppliers(SupplierName,ContactID,AddressID)
			 VALUES ('BE Healthy',10,15);
GO

SELECT * FROM vw_suppliers
SELECT * FROM ims.Suppliers;
GO
--================================================================================================================
--                                 Update with View
--================================================================================================================
--Update
USE InventoryDB
UPDATE vw_suppliers
SET SupplierName = 'Be Good' WHERE SupplierID=4
GO

--================================================================================================================
--                                 Delete with View
--================================================================================================================
--USE InventoryDB
--Delete
--DELETE FROM vw_suppliers WHERE SupplierID=4
--GO

--================================================================================================================
--                                                  Distinct
--================================================================================================================
USE InventoryDB
SELECT DISTINCT City
FROM  ims.Addresses
GO

------==================================================================================
---                              Select Table
------==================================================================================

USE InventoryDB
-- Select from Addresses
SELECT * FROM ims.Addresses;

-- Select from Contacts
SELECT * FROM ims.Contacts;

-- Select from Brands
SELECT * FROM ims.Brands;

-- Select from Manufacturers
SELECT * FROM ims.Manufacturers;

-- Select from Suppliers
SELECT * FROM ims.Suppliers;

-- Select from ProductCategories
SELECT * FROM ims.ProductCategories;

-- Select from Customers
SELECT * FROM ims.Customers;

-- Select from Orders
SELECT * FROM ims.Orders;

-- Select from Products
SELECT * FROM ims.Products;

-- Select from ProductsCategory
SELECT * FROM ims.ProductsCategory;

-- Select from ProductAttributes
SELECT * FROM ims.ProductAttributes;

-- Select from StocksIn
SELECT * FROM ims.StocksIn;

-- Select from Inventory
SELECT * FROM ims.Inventory;

-- Select from Discounts
SELECT * FROM ims.Discounts;

-- Select from OrderDetails
SELECT * FROM ims.OrderDetails;

-- Select from Sales
SELECT * FROM ims.Sales;

-- Select from InventoryAdjustments
SELECT * FROM ims.InventoryAdjustments;

-- Select from Expenses
SELECT * FROM Expenses;

-- Select from Revenues
SELECT * FROM Revenues;

-- Select from InventoryAudit
SELECT * FROM InventoryAudit;
GO

--================================================================================================================
--                                       Insert Into Copy Data From Another Table
--================================================================================================================

SELECT * 
INTO #tempproducts
FROM ims.Products
GO

SELECT * FROM #tempproducts
GO
--================================================================================================================
--				   Query From Multiple Table With Join/Corralation Name -- 
--================================================================================================================

--================================================================================================================
--										INNER JOIN
--================================================================================================================
USE InventoryDB
SELECT item_code,ProductName,p.Description,UnitPrice,stock_count,CategoryName
FROM ims.Products p
INNER JOIN ims.ProductsCategory psc ON p.ProductID = psc.ProductID
INNER JOIN ims.ProductCategories pcs ON psc.ProductCategoriesID=pcs.ProductCategoryID
GO

--================================================================================================================
--											LEFT JOIN
--================================================================================================================
USE InventoryDB
SELECT 
    C.CustomerID,
    C.CustomerFirstName,
    C.CustomerLastName,
    O.OrderID,
    O.OrderDate
FROM 
    ims.Customers AS C
LEFT JOIN 
    ims.Orders AS O ON C.CustomerID = O.CustomerID
GO
--================================================================================================================
--											RIGHT JOIN
--================================================================================================================
USE InventoryDB
SELECT  S.SupplierID,SupplierName,P.ProductName
FROM 
    ims.Products AS P 
RIGHT JOIN	
	ims.Suppliers S ON S.SupplierID = P.supplier_id
GO

--================================================================================================================
--											Full JOIN
--================================================================================================================
USE InventoryDB
SELECT 
    M.ManufacturersID,
    M.ManufacturersName,
    P.ProductName
FROM 
    ims.Manufacturers AS M
FULL JOIN 
    ims.Products AS P ON M.ManufacturersID = P.ProductID;
GO

--================================================================================================================
--											Cross JOIN
--================================================================================================================
USE InventoryDB
SELECT 
    ProductName,
    D.Description
FROM 
    ims.Products
CROSS JOIN 
    ims.Discounts AS D;
GO

--================================================================================================================
--											Self JOIN
--================================================================================================================
USE InventoryDB
SELECT
	a.Address1,
	a.Address2,
	a.City,
	a.Country
FROM 
	ims.Addresses a 
JOIN 
	ims.Addresses b ON a.AddressID=b.AddressID
GO







--================================================================================================================
---                Query  With Basic Six Clause (SELECT/FROM/WHERE/GROUP BY/HAVING/ORDER BY),
--                         Arithmetic Operators and Comparison Operators etc  
--================================================================================================================
-- Example query with basic six SQL clauses

USE InventoryDB
SELECT ProductID,ProductName,FLOOR(AVG(UnitPrice)) AS AvgPrice
FROM ims.Products
WHERE stock_count BETWEEN 0 AND 10
GROUP BY ProductID, ProductName
HAVING AVG(UnitPrice) > 20
ORDER BY AvgPrice DESC;
GO

--Select Query  with AND , OR
USE InventoryDB
SELECT ProductID,ProductName,UnitPrice,stock_count
FROM ims.Products
WHERE 
    (UnitPrice > 50 AND stock_count > 1)
    OR
    (UnitPrice <= 50 AND stock_count > 1);
GO

--================================================================================================================
--=====                                      OFFSET, FETCH
--================================================================================================================ 

USE InventoryDB
SELECT *
FROM ims.Products
ORDER BY UnitPrice DESC
OFFSET 0 ROWS 
FETCH NEXT 10 ROWS ONLY;
GO

--================================================================================================================
--                             Top Clause with TIES
--================================================================================================================

USE InventoryDB
SELECT TOP 10 WITH TIES OrderID,OrderDate,Status
FROM ims.Orders
ORDER BY OrderDate DESC;
GO

--================================================================================================================
--                              Top Clause with Percent
--================================================================================================================

USE InventoryDB
SELECT TOP 10 PERCENT WITH TIES OrderID,OrderDate,Status
FROM ims.Orders
ORDER BY OrderDate DESC;
GO

--================================================================================================================
--									        Union
--================================================================================================================

USE InventoryDB
	SELECT ManufacturersName
	FROM ims.Manufacturers
UNION
	SELECT SupplierName
	FROM ims.Suppliers
GO

--================================================================================================================
--											CAST,CONVERT,TRY_CONVERT
--================================================================================================================

SELECT 'Today :' + CAST(GETDATE() AS VARCHAR)
SELECT 'Today :' + CONVERT(VARCHAR, GETDATE(),1)  AS VARCHARDATE_1
SELECT 'Today :' + TRY_CONVERT (VARCHAR, GETDATE(), 7) AS VARCHARDATE_07
SELECT 'Today :' + TRY_CONVERT (VARCHAR, GETDATE(), 10) AS VARCHARDATE_10
SELECT 'Today :' + TRY_CONVERT (VARCHAR, GETDATE(), 12) AS VARCHARDATE_12
GO


Select DATEDIFF (yy, CAST('01/01/1997' as datetime), GETDATE()) As Years,
DATEDIFF (MM, CAST('01/12/1997' as datetime), GETDATE()) As Months,
DATEDIFF (DD, CAST('01/01/1997' as datetime), GETDATE ()) As Days
GO

--================================================================================================================
--									   DATE/TIME Function
--================================================================================================================

-- DATE/TIME Function- 
SELECT DATEDIFF(yy, CAST('01/01/1997' AS Datetime), GETDATE()) AS YEARS
SELECT DATEDIFF(MM, CAST('01/01/1997' AS Datetime), GETDATE()) %12 AS Months
SELECT DATEDIFF(DD, CAST('01/01/1997' AS Datetime), GETDATE()) %30 AS Days
GO

--Isdate
SELECT ISDATE('2030-11-31')
--Datepart
SELECT DATEPART(MONTH,'2050-07-21')
--Datename
SELECT DATENAME(WEEKDAY,'2050-01-21')
--Sysdatetime
SELECT Sysdatetime()
--UTC
SELECT GETUTCDATE()
--Datediff
SELECT DATEDIFF (YEAR, '2000-12-01', '2016-09-30')
GO

 --================================================================================================================
--								           Numaric Function
--=================================================================================================================

USE InventoryDB
SELECT FLOOR(UnitPrice) AS [FLOOR], UnitPrice 
from ims.Products
GO

USE InventoryDB
SELECT CEILING (TotalAmount) AS CEILING, TotalAmount 
from ims.OrderDetails
GO

DECLARE @price money = 25.49
SELECT FLOOR(@price) AS FLOORRESULT, ROUND(@price,0) AS ROUNDRESULT, CEILING(@price) CELINGSET
GO

DECLARE @price decimal (10,2)
SET @price = 15.755
SELECT ROUND(@price,1)		
SELECT ROUND(@price,-1)		
SELECT ROUND(@price,2)		
SELECT ROUND(@price,-2)		
SELECT ROUND(@price,3)		
SELECT ROUND(@price,-3)		
SELECT CEILING(@price)		
SELECT FLOOR(@price)
GO
