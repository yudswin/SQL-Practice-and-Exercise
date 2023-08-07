-- 1.0 Create Table
CREATE TABLE Manufacturers (
	Code INTEGER PRIMARY KEY NOT NULL,
	Name CHAR(50) NOT NULL 
);

CREATE TABLE Products (
	Code INTEGER PRIMARY KEY NOT NULL,
	Name CHAR(50) NOT NULL ,
	Price REAL NOT NULL ,
	Manufacturer INTEGER NOT NULL 
		CONSTRAINT fk_Manufacturers_Code REFERENCES Manufacturers(Code)
);

INSERT INTO Manufacturers(Code,Name) VALUES (1,'Sony'),(2,'Creative Labs'),(3,'Hewlett-Packard'),(4,'Iomega'),(5,'Fujitsu'),(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5),(2,'Memory',120,6),(3,'ZIP drive',150,4),(4,'Floppy disk',5,6),(5,'Monitor',240,1),
(6,'DVD drive',180,2),(7,'CD drive',90,2),(8,'Printer',270,3),(9,'Toner cartridge',66,3),(10,'DVD burner',180,2);


-- 1.1 Select the names of all the products in the store.	
SELECT * FROM dbo.Products

-- 1.2 Select the names and the prices of all the products in the store.
SELECT Name,Price FROM dbo.Products

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT Name FROM dbo.Products WHERE Price > 200

-- 1.4 Select all the products with a price between $60 and $120.
SELECT Name FROM dbo.Products WHERE Price >= 60 AND Price <= 120

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT Name, Price * 100 as 'Price(Cent)' FROM dbo.Products

-- 1.6 Compute the average price of all the products.
SELECT AVG(Price) as 'Average' FROM dbo.Products

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(Price) as 'Average' FROM dbo.Products WHERE Products.Manufacturer = 2

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(Name) as 'Totals' FROM dbo.Products WHERE Price >= 180

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT Name, Price FROM dbo.Products WHERE Price >= 180 ORDER BY Price DESC, Name ASC

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.-
-- Without JOIN
SELECT * 
FROM 
	dbo.Products,
	dbo.Manufacturers 
WHERE 
	dbo.Products.Manufacturer = dbo.Manufacturers.Code

-- With JOIN
SELECT * 
FROM 
	dbo.Products 
INNER JOIN 
	dbo.Manufacturers 
ON 
	Products.Manufacturer = Manufacturers.Code

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT 
	Products.Name,
	Products.Price,
	Manufacturers.Name AS 'Manufacturer'
FROM
	dbo.Products
LEFT JOIN 
	dbo.Manufacturers
ON
	Products.Manufacturer = Manufacturers.Code

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT
	Manufacturer 'Code',
	AVG(Price) 'Average'
FROM
	dbo.Products
GROUP BY Manufacturer

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT
	AVG(Price) 'Average',
	Manufacturers.Name
FROM
	dbo.Products,
	dbo.Manufacturers
WHERE Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name

-- JOIN
SELECT
	AVG(Price) 'Average',
	Manufacturers.Name
FROM dbo.Products 
INNER JOIN dbo.Manufacturers
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT 
	Products.Price,
	Manufacturers.Name
FROM
	dbo.Manufacturers,
	dbo.Products
WHERE Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING AVG(Price) >= 150;


-- JOIN
SELECT
	AVG(Products.Price) AS 'Avarage Price',
	Manufacturers.Name AS 'Manufacturers Name'
FROM dbo.Products
INNER JOIN dbo.Manufacturers
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING AVG(Products.Price) >= 150

-- 1.15 Select the name and price of the cheapest product.
SELECT 
	Products.Name,
	Products.Price
FROM
	dbo.Products
WHERE Price = (SELECT MIN (Price) FROM dbo.Products)


-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.

SELECT
	Manufacturers.Name,
	Products.Name,
	Products.Price
FROM dbo.Manufacturers
LEFT JOIN dbo.Products
ON Manufacturers.Code = Products.Manufacturer
AND Products.Price = (SELECT MAX(Price) FROM dbo.Products WHERE Products.Manufacturer = Manufacturers.Code)

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO dbo.Products(Code, Name, Price, Manufacturer)
VALUES (11,'Loudspeaker', 70, 2);

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE dbo.Products
SET Name = 'Laser Printer'
WHERE Products.Code = 8;

-- 1.19 Apply a 10% discount to all products.
UPDATE dbo.Products
SET Price = Price - (Price * 10 / 100)

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.

UPDATE dbo.Products
SET Price = Price - (Price * 10 / 100)
WHERE Price >= 120