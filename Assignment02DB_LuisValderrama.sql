--********************************************************************************************************************--
-- Title: Assignment02DB_LuisValderrama
-- Author: Luis Valderrama
-- Desc: The objective of this assignment is to create a database, tables, and alter the tables to add constraints
-- Change Log: When,Who,What
-- 2021-04-12, Luis Valderrama, Created Assignment02DB_LuisValderrama, and three data tables
--*********************************************************************************************************************--

/*  
--[DATA DESIGN]--

Objective: Create database, three tables, then add constraints.

1- Create database, Assignment02DB_LuisValderrama;
2- Create Table (Attributes/Data Type): Categories (CategoryID/INT, CategoryName/NVARCHAR)
3- Create Table (Attributes/Data Type): Products (ProductID/INT, ProductName/NVARCHAR, CategoryID/INT, UnitPrice/MONEY)
4- Create Table (Attributes/Data Type): Inventories (InventoryID/INT, InventoryDate/DATE, ProductID/INT, Count/INT)
*/

CREATE DATABASE Assignment02DB_LuisValderrama;
GO

USE Assignment02DB_LuisValderrama;
GO

CREATE TABLE Categories
(
[CategoryID] [INT] IDENTITY (1, 1) NOT NULL,
[CategoryName] [NVARCHAR] (100) NOT NULL
);
GO

CREATE TABLE Products
(
[ProductID] [INT] IDENTITY (1, 1) NOT NULL,
[ProductName] [NVARCHAR] (100) NOT NULL,
[CategoryID] [INT] NULL,
[UnitPrice] [MONEY] NOT NULL
);
GO

CREATE TABLE Inventories
(
[InventoryID] [INT] IDENTITY (1, 1) NOT NULL,
[InventoryDate] [DATE] NOT NULL,
[ProductID] [INT] NOT NULL,
[Count] [INT] NOT NULL
);
GO

USE Assignment02DB_LuisValderrama;
GO

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Inventories;

--[DATA DESIGN]
--Add constraints to the Categories Table: 
--CategoryID = Primary Key Clustered
--CategoryName = Unique
--Create View
	
ALTER TABLE Categories
ADD CONSTRAINT PK_CategoryID PRIMARY KEY CLUSTERED (CategoryID);
GO

ALTER TABLE Categories
ADD CONSTRAINT UQ_CategoryName UNIQUE (CategoryName);
GO

SP_HELP Categories
EXEC SP_HELPCONSTRAINT Categories;

CREATE VIEW vCategories
AS SELECT
CategoryID,
CategoryName
FROM Categories
GO

SELECT * FROM Categories

--[DATA DESIGN]
--Add constraints to the Products Table: 
--ProductID = Primary Key 
--ProductName = Unique
--CategoryID = Foreign Key
--UnitPrice = Check 
--Create View

ALTER TABLE Products
ADD CONSTRAINT PK_ProductID PRIMARY KEY CLUSTERED (ProductID);
GO

ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
GO

ALTER TABLE Products
ADD CONSTRAINT FK_CategoryID FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID); 
GO

ALTER TABLE Products
ADD CONSTRAINT CK_UnitPrice CHECK (UnitPrice > 0);
GO

SP_Help Products
EXEC SP_HELPCONSTRAINT Products;

CREATE VIEW vProducts
AS SELECT
ProductID,
ProductName,
CategoryID,
UnitPrice
FROM Products
GO

SELECT * FROM Products

--[DATA DESIGN]
--Add constraints to the Inventories Table: 
--InventoryID = Primary Key 
--InventoryDate = Default
--ProductID = Foreign Key
--Count = Check
--Create View

ALTER TABLE Inventories
ADD CONSTRAINT PK_InventoryID PRIMARY KEY CLUSTERED (InventoryID);
GO

ALTER TABLE Inventories
ADD CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Products (ProductID);
GO

ALTER TABLE Inventories
ADD CONSTRAINT DF_InventoryDate DEFAULT GETDATE () FOR InventoryDate; 
GO

ALTER TABLE Inventories
ADD CONSTRAINT CK_Count CHECK (COUNT > 0);
GO

EXEC SP_HELPCONSTRAINT Inventories;
SP_HELP Inventories

CREATE VIEW vInventories
AS SELECT
InventoryID,
ProductID,
InventoryDate,
Count
FROM Inventories
GO

SELECT * FROM vInventories