--Create Database
USE master
IF DB_ID('InventoryDB') IS NOT NULL
DROP DATABASE InventoryDB

DECLARE @data_path NVARCHAR(256);
SET @data_path=(SELECT SUBSTRING(physical_name,1,CHARINDEX(N'master.mdf',LOWER(physical_name))-1)
				FROM master.sys.master_files
				WHERE database_id=1 and FILE_ID=1);
EXECUTE('CREATE DATABASE InventoryDB
		ON PRIMARY(NAME=InventoryDB_data,FILENAME='''+@data_path+'InventoryDB_data.mdf'',SIZE=16MB,MAXSIZE=unlimited,FILEGROWTH=2MB)
		LOG ON(NAME=InventoryDB_log,FILENAME='''+@data_path+'Inventory_log.ldf'',SIZE=10MB,MAXSIZE=100MB,FILEGROWTH=1MB)
		')
GO

USE InventoryDB
GO

------==================================================================================
---                             Create Schema
------==================================================================================
CREATE SCHEMA ims
GO

------==================================================================================
----                            Create Table
------==================================================================================
USE InventoryDB
DROP TABLE IF EXISTS ims.Addresses
CREATE TABLE ims.Addresses
(
	AddressID INT PRIMARY KEY IDENTITY,
	Address1 VARCHAR(50),
	Address2 VARCHAR(50),
	City VARCHAR(30) Not Null,
	Country VARCHAR(30)NOT NULL
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.Contacts
CREATE TABLE ims.Contacts
(
	ContactID INT PRIMARY KEY IDENTITY,
	ContactFirstName VARCHAR(20),
	ContactLastName VARCHAR(20),
	Phone CHAR(15) CHECK (LEN(Phone)=11 and PHONE Like '[0][1][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NULL,
	Email NVARCHAR(255) NULL 
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.Customers
CREATE TABLE ims.Customers
(
	CustomerID INT PRIMARY KEY IDENTITY,
	CustomerName VARCHAR(20),
	Phone CHAR(15) CHECK (LEN(Phone)=11 and PHONE Like '[0][1][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NULL,
	Email NVARCHAR(255) NULL 
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.Brands
CREATE TABLE ims.Brands
(
	BrandID INT PRIMARY KEY IDENTITY,
	BrandName VARCHAR(30) NOT NULL,
	ContactID INT FOREIGN KEY REFERENCES ims.Contacts(ContactID)
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.ProductCategories
CREATE TABLE ims.ProductCategories
(
	ProductCategoryID INT PRIMARY KEY IDENTITY,
	CategoryName VARCHAR(30) NOT NULL,
	Description VARCHAR(50),
	ParentCategoriesID INT FOREIGN KEY REFERENCES ims.ProductCategories(ProductCategoryID) NULL
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.Orders
CREATE TABLE ims.Orders
(
	OrderID INT PRIMARY KEY IDENTITY,
	CustomerID INT FOREIGN KEY REFERENCES ims.Customers(CustomerID),
	OrderDate DATETIME,
	Status BIT Default 0
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.Products
CREATE TABLE ims.Products 
(
	ProductID INT PRIMARY KEY IDENTITY,
	item_code AS ('Ic'+Cast(ProductID AS VARCHAR(50))),
	ProductName VARCHAR(50),
	Description VARCHAR(50),
	Image VARBINARY,
	ContactID INT REFERENCES ims.Contacts (ContactId),
	UnitPrice decimal(10,2),
	stock_count INT DEFAULT 0 
);
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.ProductsCategory
Create table ims.ProductsCategory 
(
	ProductID INT FOREIGN KEY REFERENCES ims.Products(ProductID) ON DELETE CASCADE,
	ProductCategoriesID INT FOREIGN KEY REFERENCES ims.ProductCategories(ProductCategoryID)
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.Discounts
CREATE TABLE ims.Discounts 
(
	DiscountID INT Primary Key IDENTITY,
	DiscountName VARCHAR(20) NOT NULL,
	Description VARCHAR(50) NULL,
	DiscountPercentage INT NOT NULL,
	StartDate DATETIME NULL,
	EndDate DATETIME NULL,
	IsActive BIT Default 0
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.OrderDetails
CREATE TABLE ims.OrderDetails
(
	OrderDetailID INT PRIMARY KEY IDENTITY,
	OrderID INT FOREIGN KEY REFERENCES ims.Orders(OrderID),
	ProductID INT FOREIGN KEY REFERENCES ims.Products(ProductID),
	Quantity INT,
	UnitPrice DECIMAL(10,2),
	DiscountID INT FOREIGN KEY REFERENCES ims.Discounts(DiscountID) NULL Default 0,
	TotalAmount DECIMAL(10,2)
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.Sales
CREATE TABLE ims.Sales
(
	SaleID INT  PRIMARY KEY IDENTITY,
	OrderId INT FOREIGN KEY REFERENCES ims.Orders(OrderID),
	TransactionDate DATETIME NOT NULL,
	TotalAmount DECIMAL(10, 2) NOT NULL,
	TransactionID UNIQUEIDENTIFIER DEFAULT newid(),
)
GO

USE InventoryDB
DROP TABLE IF EXISTS ims.InventoryAdjustments
CREATE TABLE ims.InventoryAdjustments
(
	AdjustmentID INT PRIMARY KEY IDENTITY,
	ProductID INT FOREIGN KEY REFERENCES ims.Products(ProductID),
	InventoryID INT FOREIGN KEY REFERENCES ims.Inventory(InventoryID),
	AdjustmentDate DATETIME,
	QuantityAdjusted INT,
	Reason VARCHAR(50)
)
GO

USE InventoryDB
DROP TABLE IF EXISTS Expenses
CREATE TABLE Expenses
(
	ExpenseID INT PRIMARY KEY IDENTITY,
	Description VARCHAR(50),
	Amount MONEY,
	ExpenseDate DATETIME,
	ExpensesCategory Varchar(30)
)
GO

USE InventoryDB
DROP TABLE IF EXISTS Revenues
CREATE TABLE Revenues
(
	RevenueID INT PRIMARY KEY IDENTITY,
	Description VARCHAR(50),
	Amount MONEY,
	RevenueDate DATETIME,
	RevenueCategory VARCHAR(30)
)

USE InventoryDB
DROP TABLE IF EXISTS ims.Promotion
CREATE TABLE ims.Promotion
(
	PromotionId INT,
	StartDate DATE,
	EndDate DATE,
	IsActive BIt
)

------==================================================================================
-------                               Alter Table
------==================================================================================
--Alter Column
USE InventoryDB
ALTER TABLE ims.Discounts
ALTER COLUMN EndDate Date
--Add Column
USE InventoryDB
ALTER TABLE ims.Addresses
ADD ZipCode NVARCHAR(30)
--Delete Column
USE InventoryDB
ALTER TABLE ims.Addresses
DROP COLUMN ZipCode
------==================================================================================
--                      Index(clustered,non-clustered)
------==================================================================================
---Clustered---
USE InventoryDB
DROP INDEX IF exists CI_Promotion ON ims.Promotion
CREATE Clustered Index CI_Promotion ON ims.Promotion(PromotionID);
GO

----NonClustered---
DROP INDEX IF exists NCI_ProductName ON ims.Products
CREATE NonClustered Index NCI_ProductName ON ims.Products(ProductName);
GO
------==================================================================================
--                          View 
------==================================================================================
USE InventoryDB
DROP VIEW IF EXISTS vw_suppliers
GO
CREATE VIEW vw_suppliers
AS
SELECT SupplierID,SupplierName,ContactID,AddressID 
FROM ims.Suppliers
GO
------==================================================================================
--                          View with Schemabinding
------==================================================================================
USE InventoryDB
DROP VIEW IF EXISTS vw_Custemer
GO
CREATE VIEW vw_Custemer 
WITH SCHEMABINDING
AS
SELECT c.CustomerID,c.CustomerFirstName+''+c.CustomerLastName AS Name,c.HomePhoneNo,c.OfficePhoneNo,a.Address1+''+a.City AS [Address],Country
FROM ims.Customers c Join ims.Addresses a
		ON c.AddressId=a.AddressId
GO

------==================================================================================
--                           View With Encryption
------==================================================================================
USE InventoryDB
DROP VIEW IF EXISTS vw_Products
GO
CREATE VIEW vw_Products
WITH ENCRYPTION
AS
SELECT ProductID,item_code ,ProductName,Description,Image,supplier_id,UnitPrice,stock_count
FROM ims.Products
GO

------==================================================================================
---                    Scalar Function, Tabular Function
------==================================================================================
--Scalar Function
--Get Available Quantity
USE InventoryDB
DROP FUNCTION IF EXISTS ims.fnavailablequantity
GO
CREATE FUNCTION ims.fnavailablequantity
(
	@productid int
)
RETURNS int
BEGIN
RETURN(SELECT QuantityAvailable FROM ims.Inventory 
	   WHERE Inventory.ProductID=@productid)
END
GO

--Get Stock Quality
DROP FUNCTION IF EXISTS ims.fnstockquantity
GO
CREATE FUNCTION ims.fnstockquantity
(
	@productid int
)
RETURNS int
BEGIN
RETURN(SELECT QuantityStock FROM ims.Inventory 
	   WHERE Inventory.ProductID=@productid)
END
GO
--Tabular Function
--Get Product Info
DROP FUNCTION IF EXISTS ims.fngetproductinformation
GO
CREATE FUNCTION ims.fngetproductinformation()
RETURNS TABLE
AS
RETURN
(
SELECT *
FROM ims.Products
);

GO

------==================================================================================
-----                         Procedure Create (Search By Name)
------==================================================================================
DROP PROC IF EXISTS sp_searchname
GO
Create PROC sp_searchname
@name nvarchar(20)
AS
Select ContactFirstName, ContactLastName 
From ims.Contacts
Where ContactFirstName like @name+'%'  or ContactLastName like @name +'%'
GO

------==================================================================================
---  Multiple Table Stored Procedure--Insert, Update, Delete=  With IF Exists, And Operator
------==================================================================================
--Procedure for Stock In
DROP PROC IF EXISTS sp_stocksin
GO
CREATE PROCEDURE sp_stocksin
(
  @productid int,
  @stockqty int,
  @stockprice money,
  @stockexpiry date,
  @stockmanufactured date
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insert into the StockIn table
		BEGIN TRAN
		Begin
        INSERT INTO ims.StocksIn(ProductID,StockQty,StockPrice,StockExpiry,StockManufactured,StockPurchased)
        VALUES (@productid, @stockqty, @stockprice,@stockexpiry,@stockmanufactured,GETDATE());
		END
		BEGIN
			UPDATE ims.Products
			SET stock_count =(Select count(StockId) FROM ims.StocksIn where StocksIn.ProductID=@productid) 
			WHERE @productid=ProductID
		END
            -- Update the existing item in the Inventory table
			        -- Check if the item already exists in the Inventory table
		IF Exists (SELECT InventoryID From ims.Inventory WHERE ProductID=@ProductID) 
			Begin
            UPDATE ims.Inventory
            SET QuantityAvailable = QuantityAvailable + @stockqty,
				QuantityStock= QuantityStock + @stockqty
				WHERE ProductID = @productid;
			END
		
            -- Insert a new item into the Inventory table
		ELSE IF NOT Exists (SELECT InventoryID From ims.Inventory WHERE ProductID=@productid) 
		BEGIN
            INSERT INTO ims.Inventory(ProductID,QuantityAvailable,QuantityStock)
            VALUES (@productid,@stockqty,@stockqty)
		END
        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        -- An error occurred, rollback the transaction
        ROLLBACK TRAN;
        PRINT 'ERROR'
    END CATCH;
	COMMIT TRANSACTION;
END;
GO

--Procedure for Takeing Order
CREATE PROC sp_processorder
						(
						@customerid INT,
						@productid INT,
						@quantity INT,
						@discountid INT NULL
						)
AS
BEGIN
    IF ims.fnavailablequantity(@ProductID)>=@quantity AND @quantity>0
	BEGIN 
			UPDATE ims.Inventory
			SET QuantityAvailable = (ims.fnavailablequantity(@productid) - @quantity)
			WHERE ProductId = @productid;

			INSERT ims.Orders(CustomerID,OrderDate)
			Values (@customerid,GETDATE())

		DECLARE @orderid INT,
				@unitprice DECIMAL(10,2),
				@totalamount DECIMAL(10,2)

        SET @orderid = SCOPE_IDENTITY()

		SET @unitprice=(Select UnitPrice from ims.Products WHERE @productid=ProductID)

		IF @discountid IN (SELECT DiscountID FROM ims.Discounts WHERE DiscountID=@discountid)
		SET @TotalAmount= @quantity*@unitprice-((@quantity*@unitprice)*(Select DiscountPercentage from ims.Discounts Where DiscountID=@discountid)/100)
		
		INSERT ims.OrderDetails(OrderID,ProductID,Quantity,UnitPrice,DiscountID,TotalAmount)
		Values (@orderid,@productid,@quantity,@unitprice,@discountid,@totalamount)

		PRINT 'Order placed'
	END 
	ELSE 
	BEGIN
		PRINT 'Order failed'
	END	
END
GO


------==================================================================================
---            CREATE for Trigger, After Trigger Insert,Update,delete
------==================================================================================
DROP TABLE IF EXISTS InventoryAudit
CREATE TABLE InventoryAudit
(
	InventoryID INT,
	ProductID INT,
	QuantityAvailable INT,
	QuantityStock INT,
	ActionName varchar(30),
	ActionTime DateTime
)
GO

DROP TABLE IF EXISTS CustomerAudit
CREATE TABLE CustomerAudit
(
	CustomerID INT,
	CustomerFirstName VARCHAR(30),
	CustomerLastName VARCHAR(30),
	HomePhoneNo NVARCHAR(11),
	OfficePhoneNo NVARCHAR(15),
	AddressID INT, 
	ActionName varchar(30)
)
GO
--After Tigger on Inventory
USE InventoryDB
DROP TRIGGER IF EXISTS trg_AfterALLInventory
GO
CREATE TRIGGER trg_AfterALLInventory on ims.Inventory
AFTER UPDATE, INSERT, DELETE
AS
Declare @InventoryID INT,
		@ProductID INT,
		@QuantityAvailable INT,
		@QuantityStock INT,
		@actionname varchar(30)
IF EXISTS(select * from inserted)
	BEGIN
	IF EXISTS(select * from deleted)
		SELECT @InventoryID=i.InventoryID FROM inserted i
		SELECT @ProductID=i.ProductID FROM inserted i
		SELECT @QuantityAvailable=i.QuantityAvailable From inserted i
		SELECT @QuantityStock=i.QuantityStock FROM inserted i
		SET @actionname='Update Record -- After Tigger fired'
		INSERT INTO InventoryAudit Values(@InventoryID,@ProductID,@QuantityAvailable,@QuantityStock,@actionname,getdate())
		PRINT 'After tigger fired'
	IF NOT EXISTS(select * from inserted) 
		SELECT @InventoryID=i.InventoryID FROM inserted i
		SELECT @ProductID=i.ProductID FROM inserted i
		SELECT @QuantityAvailable=i.QuantityAvailable From inserted i
		SELECT @QuantityStock=i.QuantityStock FROM inserted i
		SET @actionname='Insert Record -- After Tigger fired'
		INSERT INTO InventoryAudit Values(@InventoryID,@ProductID,@QuantityAvailable,@QuantityStock,@actionname,getdate())
		PRINT 'After tigger fired'
	END
ELSE
	BEGIN
		SELECT @InventoryID=i.InventoryID FROM deleted i
		SELECT @ProductID=i.ProductID FROM deleted i
		SELECT @QuantityAvailable=i.QuantityAvailable From deleted i
		SELECT @QuantityStock=i.QuantityStock FROM deleted i
		SET @actionname='Update Record -- After Tigger fired'
		INSERT INTO InventoryAudit Values(@InventoryID,@ProductID,@QuantityAvailable,@QuantityStock,@actionname,GETDATE())
		PRINT 'After tigger fired'
	END
GO

------==================================================================================
---                               Instead of Trigger 
------==================================================================================
USE InventoryDB
DROP TRIGGER IF EXISTS trg_UpdateDelete
GO

Create Trigger trg_UpdateDelete on ims.Customers
Instead of Update, Delete
AS
Declare @rowcount int, 
		@ActionName VARCHAR(30),
		@CustomerID INT,
		@CustomerFirstName VARCHAR(30),
		@CustomerLastName VARCHAR(30),
		@HomePhoneNo NVARCHAR(11),
		@OfficePhoneNo NVARCHAR(15),
		@AddressID INT
Set @rowcount=@@ROWCOUNT
IF(@rowcount>1)
				BEGIN
				Raiserror('You cannot Update or Delete more than 1 Record',16,1)
				END
Else 
		IF EXISTS (select * from inserted)
			SET @ActionName='Updated'
			SELECT	@CustomerID=i.CustomerID FROM inserted i
			SELECT	@CustomerFirstName=i.CustomerFirstName FROM inserted i
			SELECT	@CustomerLastName=i.CustomerLastName FROM inserted i
			SELECT	@HomePhoneNo=i.HomePhoneNo FROM inserted i
			SELECT	@OfficePhoneNo=i.OfficePhoneNo FROM inserted i
			SELECT	@AddressID=i.AddressID FROM inserted i
				INSERT INTO CustomerAudit (CustomerID,CustomerFirstName,CustomerLastName,HomePhoneNo,OfficePhoneNo,AddressID, ActionName)
					VALUES(@CustomerID,@CustomerFirstName,@CustomerLastName,@HomePhoneNo,@OfficePhoneNo,@AddressID,@ActionName)
				UPDATE Customers
				SET @CustomerFirstName=CustomerFirstName, 
					 @CustomerLastName=CustomerLastName,
					 @HomePhoneNo=HomePhoneNo,
					 @OfficePhoneNo=OfficePhoneNo,
					 @AddressID=AddressID
				WHERE CustomerID=@CustomerID
		IF NOT EXISTS (select * from inserted)
			SET @ActionName='Updated'
			SELECT	@CustomerID=i.CustomerID FROM deleted i
			SELECT	@CustomerFirstName=i.CustomerFirstName FROM deleted i
			SELECT	@CustomerLastName=i.CustomerLastName FROM deleted i
			SELECT	@HomePhoneNo=i.HomePhoneNo FROM deleted i
			SELECT	@OfficePhoneNo=i.OfficePhoneNo FROM deleted i
			SELECT	@AddressID=i.AddressID FROM deleted i
				INSERT INTO CustomerAudit (CustomerID,CustomerFirstName,CustomerLastName,HomePhoneNo,OfficePhoneNo,AddressID, ActionName)
					VALUES(@CustomerID,@CustomerFirstName,@CustomerLastName,@HomePhoneNo,@OfficePhoneNo,@AddressID,@ActionName)
				DELETE Customers
				WHERE CustomerID=@CustomerID


		Print 'Update or Delete Successful'
GO

------==================================================================================
---                              DROP TABLE, TRUNCATE
------==================================================================================

----TRUNCATE
USE InventoryDB
TRUNCATE TABLE ims.Promotion
GO

----DROP TABLE
USE InventoryDB
DROP TABLE ims.Promotion
GO

------==================================================================================
----                            Create Sequence
------==================================================================================
CREATE SEQUENCE ims.Seq_transacton
AS INT
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 10000
  NO CYCLE
GO
  ------==================================================================================
---                               Temporary Table
------==================================================================================
----Local Table
CREATE TABLE #Examcenter
(
ExamcenterID INT PRIMARY KEY IDENTITY,
ExamcenterName varchar (30) NOT NULL
);
GO

----Global Table
CREATE TABLE ##StudentInpo
(
StudentInpoID INT PRIMARY KEY IDENTITY,
StudentName varchar (30) NOT NULL,
StudentInpo datetime
);
GO

Select * from #Examcenter
Go
Select * from ##StudentInpo
Go


  ------==================================================================================
---                              -- Marge--
------==================================================================================

-- Create the Products Table
USE InventoryDB;
CREATE TABLE TargetProducts
(
    ProductID INT,
    ProductName VARCHAR(255) NOT NULL,
    QuantityInStock INT,
    UnitPrice DECIMAL(10, 2),
    LastUpdated DATE DEFAULT GETDATE()
);

INSERT INTO TargetProducts (ProductID,ProductName, QuantityInStock, UnitPrice)
VALUES 
    (1,'Monitor', 50, 199.99),
    (3,'Laptop', 20, 799.99),
    (4,'Mouse', 30, 149.99);

-- Create the TempProducts Table
CREATE TABLE SourceProducts
(
    ProductID INT,
    ProductName VARCHAR(255) NOT NULL,
    QuantityInStock INT,
    UnitPrice DECIMAL(10, 2),
    LastUpdated DATE DEFAULT GETDATE()
);

-- Insert some data into the temporary table
INSERT INTO SourceProducts (ProductID,ProductName, QuantityInStock, UnitPrice)
VALUES 
    (4,'Mouse', 100, 19.99),
    (2,'Keyborad', 50, 29.99),
    (5,'PenDrive', 75, 14.99);
GO
-- Use the MERGE Statement
MERGE TargetProducts AS t
USING SourceProducts AS s
ON t.ProductID = s.ProductID
WHEN MATCHED 
    THEN UPDATE SET 
        t.ProductName = s.ProductName,
        t.QuantityInStock = s.QuantityInStock,
        t.UnitPrice = s.UnitPrice,
        t.LastUpdated = GETDATE()
WHEN NOT MATCHED BY TARGET
    THEN INSERT (ProductName, QuantityInStock, UnitPrice, LastUpdated)
         VALUES (s.ProductName, s.QuantityInStock, s.UnitPrice, GETDATE())
WHEN NOT MATCHED BY SOURCE
    THEN DELETE;

	SELECT * FROM SourceProducts
	SELECT * FROM TargetProducts