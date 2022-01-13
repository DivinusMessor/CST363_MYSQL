-- e5.1 Exercises from chapter 5
--
-- Before you begin:
-- create the tables and data using the script zagimore_schema.sql
--
-- For questions 1-13, replace the "select 1;" with your working SQL select.
-- Make sure each select statements ends with a semi-colon ";"
-- SQL statements may be split into many lines.
-- Do not edit or remove the comment lines as these are used by the auto-grader.
--
-- 1  Display all records in the REGION table
SELECT * FROM region;

-- 2 Display StoreID and StoreZIP for all stores
SELECT storeid, storezip FROM store;

-- 3 Display CustomerName and CustomerZip for all customers
--   sorted alphabetically by CustomerName
SELECT customername, customerzip FROM customer
	ORDER BY customername;

-- 4 Display the RegionIDs where we have stores
--   and do not display duplicates
SELECT DISTINCT regionid FROM region;

-- 5 Display all information for all stores in RegionID C
SELECT * FROM region
	WHERE regionid = 'C';

-- 6 Display CustomerID and CustomerName for customers who name
--   begins with the letter T
SELECT customerid, customername FROM customer
	WHERE customername LIKE 'T%';

-- 7 Display ProductID, ProductName and ProductPrice for
--   products with a price of $100 or higher
SELECT productid, productname, productprice FROM product
	WHERE productprice >= 100;

-- 8 Display ProductID, ProductName, ProductPrice and VendorName
--   for products sorted by ProductID
SELECT product.productid, product.productname, product.productprice, vendor.vendorname
	FROM product JOIN vendor ON product.vendorid = vendor.vendorid
    ORDER BY product.productid;

-- 9 Display ProductID, ProductName, ProductPrice,  VendorName and CategoryName
--   for products.  Sort by ProductID
SELECT product.productid, product.productname, product.productprice, vendor.vendorname, category.categoryname
	FROM product JOIN vendor ON product.vendorid = vendor.vendorid
    JOIN category ON product.categoryid = category.categoryid
    ORDER BY product.productid;

-- 10 Display ProductID, ProductName, ProductPrice
--   for products in category "Camping" sorted by ProductID
SELECT product.productid, product.productname, product.productprice
	FROM product JOIN category ON product.categoryid = category.categoryid
    WHERE category.categoryname = 'Camping';     

-- 11 Display ProductID, ProductName, ProductPrice
--   for products sold in zip code "60600" sorted by ProductID
SELECT product.productid, product.productname, product.productprice
    FROM product JOIN includes ON product.productid = includes.productid
    JOIN salestransaction ON salestransaction.tid = includes.tid
    JOIN store ON store.storeid = salestransaction.storeid
    WHERE store.storezip = '60600'
    ORDER BY product.productid;

-- 12 Display ProductID, ProductName and ProductPrice for VendorName "Pacifica Gear" and were
--    sold in the region "Tristate".  Do not show duplicate information.
SELECT product.productid, product.productname, product.productprice
	FROM product JOIN vendor ON product.vendorid = vendor.vendorid
    JOIN includes ON includes.productid = product.productid
    JOIN salestransaction ON salestransaction.tid = includes.tid
    JOIN store ON store.storeid = salestransaction.storeid
    JOIN region ON region.regionid = store.regionid
    WHERE vendor.vendorname = 'Pacifica Gear' AND region.regionname = 'Tristate';

-- 13 Display TID, CustomerName and TDate for any customer buying a product "Easy Boot"
--    Sorted by TID.
SELECT salestransaction.tid, customer.customername, salestransaction.tdate
	FROM includes JOIN salestransaction ON includes.tid = salestransaction.tid
    JOIN product ON product.productid = includes.productid
    JOIN customer ON salestransaction.customerid = customer.customerid
    WHERE product.productname = 'Easy Boot'
    ORDER BY salestransaction.tid;


-- 14 Create table named company with columns companyid, name, ceo.
--    Make companyid the primary key.
--
-- Replace the "create table" and "insert into" statements
-- with your working create table or insert statement.
--
CREATE TABLE company
(	companyid	VARCHAR(3)		NOT NULL,
    name		VARCHAR(20)		NOT NULL,
    ceo			VARCHAR(20)		NOT NULL,
    PRIMARY KEY (companyid) );

-- insert the following data
--    companyid   name          ceo
--    ACF         Acme Finance  Mike Dempsey
--    TCA         Tara Capital  Ava Newton
--    ALB         Albritton     Lena Dollar
INSERT INTO company VALUES ('ACF', 'Acme Finance', 	'Mike Dempsey');
INSERT INTO company VALUES ('TCA', 'Tara Capital', 	'Ava Newton');
INSERT INTO company VALUES ('ALB', 'Albritton', 	   'Lena Dollar');

-- create a table named security with columns
--     secid, name, type
--     secid should be the primary key
create table security
(	secid	VARCHAR(2)		NOT NULL,
	name	VARCHAR(20)		NOT NULL,
    type 	VARCHAR(5)		NOT NULL,
    PRIMARY KEY (secid) );

-- insert the following data
--    secid    name                type
--    AE       Abhi Engineering    Stock
--    BH       Blues Health        Stock
--    CM       County Municipality Bond
--    DU       Downtown Utlity     Bond
--    EM       Emmitt Machines     Stock
INSERT INTO security VALUES ('AE', 'Abhi Engineering', 		'Stock');
INSERT INTO security VALUES ('BH', 'Blues Health', 			'Stock');
INSERT INTO security VALUES ('CM', 'County Municipality',	'Bond');
INSERT INTO security VALUES ('DU', 'Downtown Utlity', 		'Bond');
INSERT INTO security VALUES ('EM', 'Emmitt Machines', 		'Stock');

-- create a table named fund
--  with columns companyid, inceptiondate, fundid, name
--   fundid should be the primary key
--   companyid should be a foreign key referring to the company table.
CREATE TABLE fund
(	companyid		    VARCHAR(3)		NOT NULL,
	InceptionDate	    DATE			NOT NULL,
    fundid			    VARCHAR(2)		NOT NULL,
    name			    VARCHAR(20)		NOT NULL,
    PRIMARY KEY (fundid),
    FOREIGN KEY (companyid) REFERENCES company(companyid) );

-- CompanyID  InceptionDate   FundID Name
--    ACF      2005-01-01     BG     Big Growth
--    ACF      2006-01-01     SG     Steady Growth
--    TCA      2005-01-01     LF     Tiger Fund
--    TCA      2006-01-01     OF     Owl Fund
--    ALB      2005-01-01     JU     Jupiter
--    ALB      2006-01-01     SA     Saturn
INSERT INTO fund VALUES ('ACF', '2005-01-01', 'BG', 'Big Growth');
INSERT INTO fund VALUES ('ACF', '2006-01-01', 'SG', 'Steady Growth');
INSERT INTO fund VALUES ('TCA', '2005-01-01', 'LF', 'Tiger Fund');
INSERT INTO fund VALUES ('TCA', '2006-01-01', 'OF', 'Owl Fund');
INSERT INTO fund VALUES ('ALB', '2005-01-01', 'JU', 'Jupiter');
INSERT INTO fund VALUES ('ALB', '2006-01-01', 'SA', 'Saturn');

-- create table holdings with columns
--   fundid, secid, quantity
--   make (fundid, secid) the primary key
--   fundid is also a foreign key referring to the fund  table
--   secid is also a foreign key referring to the security table
CREATE TABLE holdings
(	fundid		    VARCHAR(2)		NOT NULL,
	secid		    VARCHAR(2)		NOT NULL,
	quantity	    INT				NOT NULL,
    PRIMARY KEY (fundid, secid),
    FOREIGN KEY (secid) REFERENCES security(secid) );

--    fundid   secid    quantity
--     BG       AE           500
--     BG       EM           300
--     SG       AE           300
--     SG       DU           300
--     LF       EM          1000
--     LF       BH          1000
--     OF       CM          1000
--     OF       DU          1000
--     JU       EM          2000
--     JU       DU          1000
--     SA       EM          1000
--     SA       DU          2000
INSERT INTO holdings VALUES ('BG', 'AE', '500');
INSERT INTO holdings VALUES ('BG', 'EM', '300');
INSERT INTO holdings VALUES ('SG', 'AE', '300');
INSERT INTO holdings VALUES ('SG', 'DU', '300');
INSERT INTO holdings VALUES ('LF', 'EM', '1000');
INSERT INTO holdings VALUES ('LF', 'BH', '1000');
INSERT INTO holdings VALUES ('OF', 'CM', '1000');
INSERT INTO holdings VALUES ('OF', 'DU', '1000');
INSERT INTO holdings VALUES ('JU', 'EM', '2000');
INSERT INTO holdings VALUES ('JU', 'DU', '1000');
INSERT INTO holdings VALUES ('SA', 'EM', '1000');
INSERT INTO holdings VALUES ('SA', 'DU', '2000');

-- 15 Use alter table command to add a column "price" to the
--    security table.  The datatype should be numeric(7,2)
select * from security;
ALTER TABLE security
ADD price numeric(7,2);
select * from security;

-- 16 drop tables company, security, fund, holdings.
--    You must drop them in a certain order.
--    In order to drop a table, you must first DROP
--    any tables that have foreign keys refering to that table.
DROP TABLE fund;
DROP TABLE company;
DROP TABLE holdings;
DROP TABLE security;

-- For questions 17 -24, replace the "delete", "insert", "update" or "select"
-- statement with your working SQL statement.
-- 17 Try to delete the row for product with productid '5X1'
DELETE FROM product WHERE productid = '5x1';

-- 18 Explain why does the delete in question 17 fails.
If the row is connected to another table you must delete the other table before deleting the desired row;

-- 19 Try to delete the row for product with productid '5X2'
DELETE FROM product WHERE productid = '5X2';

-- 20 Re-insert productid '5X2'
insert into product values('5X2', 'Action Sandal', 70.00, 'PG', 'FW');

-- 21  update the price of '5X2', 'Action Sandal' by $10.00
UPDATE product
	SET productprice = 10
	WHERE productid = '5X2';

-- 22 increase the price of all products in the 'CY' category by 5%
UPDATE product
	SET productprice = productprice * 1.05
	WHERE categoryid = 'CY';

-- 23 decrease the price of all products made by vendorname 'Pacifica Gear' by $5.00
UPDATE product
	SET productprice = productprice - 5
	WHERE vendorid = 'PG';

-- 24 List productid and productprice for all products.  Sort by productid;
SELECT productid, productprice FROM product
	ORDER BY productid;

