-- e5.1 Exercises FROM chapter 5
--
-- Before you begin:
-- create the tables and data using the script zagimore_schema.sql
--
-- For questions 1-13, replace the "SELECT 1;" with your working SQL SELECT.
-- Make sure each SELECT statements ends with a semi-colon ";"
-- SQL statements may be split into many lines.
-- Do not edit or remove the comment lines as these are used by the auto-grader.
--
-- check: is there a better way to do it instead of using FROM everything?

-- 1  Display all records in the REGION table
SELECT * FROM region;

-- 2 Display StoreID and StoreZIP for all stores
SELECT storeid, storezip FROM store;

-- 3 Display CustomerName and CustomerZip for all customers
--   sorted alphabetically by CustomerName
SELECT customername, customerzip FROM customer
ORDER BY customername;

-- 4 Display the RegionIDs WHERE we have stores 
--   and do not display duplicates
SELECT distinct regionid FROM store;

-- 5 Display all information for all stores in RegionID C #chek this
SELECT * FROM store 
JOIN region ON store.regionid = region.regionid
WHERE regionid = 'C';

-- 6 Display CustomerID and CustomerName for customers who name 
--   begins with the letter T
SELECT customerid, customername FROM customer
WHERE customername like 'T%';

-- 7 Display ProductID, ProductName and ProductPrice for 
--   products with a price of $100 or higher
SELECT productid, productname, productprice FROM product
WHERE productprice >= 100;

-- 8 Display ProductID, ProductName, ProductPrice and VendorName
--   for products sorted by ProductID
SELECT productid, productname, productprice, vendorname 
FROM product JOIN vendor on product.vendorid = vendor.vendorid
ORDER BY productid;

-- 9 Display ProductID, ProductName, ProductPrice,  VendorName and CategoryName # check how do you know you are showing products and not everything? 
--   for products.  Sort by ProductID
SELECT productid, productname, productprice, vendorname, categoryname 
FROM product JOIN vendor on product.vendorid = vendor.vendorid
JOIN category on category.categoryid = product.categoryid
ORDER BY productid;

-- 10 Display ProductID, ProductName, ProductPrice  
--   for products in category "Camping" sorted by ProductID # to check you can add SELECT categoryname
SELECT productid, productname, productprice FROM product, category
WHERE categoryname = 'Camping'
ORDER BY productid;

-- 11 Display ProductID, ProductName, ProductPrice  
--   for products sold in zip code "60600" sorted by ProductID #check kinda confused about how to organize and how do i know it was bough? - SELECTtid?
SELECT productid, productname, productprice FROM salestransaction, product, store
WHERE storezip = '60600'
ORDER BY productid;

-- 12 Display ProductID, ProductName and ProductPrice for VendorName "Pacifica Gear" and were
--    sold in the region "Tristate".  Do not show duplicate information. #check same as above
SELECT distinct productid, productname, productprice FROM product, region, vendor
WHERE vendorname = 'Pacifica Gear' and regionname = 'Tristate';

-- 13 Display TID, CustomerName and TDate for any customer buying a product "Easy Boot"
--    Sorted by TID.
SELECT tid, customername, tdate FROM customer, salestransaction, product
WHERE productname = 'Easy Boot'
ORDER BY tid;

-- 14 Create table named company with columns companyid, name, ceo. 
--    Make companyid the primary key.
--
-- Replace the "create table" and "insert into" statements 
-- with your working create table or insert statement.
-- # check if should add the table name ex. companyname instead of name 
create table company 
(	companyid	char(3)		not null,
    name		char(20)	not null,
    ceo			char(20)	not null,
    PRIMARY KEY (companyid) ); 

-- insert the following data 
--    companyid   name          ceo
--    ACF         Acme Finance  Mike Dempsey
--    TCA         Tara Capital  Ava Newton
--    ALB         Albritton     Lena Dollar
insert into company values ('ACF', 'Acme Finance', 	'Mike Dempsey');
insert into company values ('TCA', 'Tara Capital', 	'Ava Newton');
insert into company values ('ALB', 'Albritton', 	'Lena Dollar');

-- create a table named security with columns
--     secid, name, type
--     secid should be the primary key
create table security
(	secid	char(2)			not null,
	name	varchar(20)		not null,
    type 	varchar(5)		not null, 
    PRIMARY KEY (secid) );

-- insert the following data
--    secid    name                type
--    AE       Abhi Engineering    Stock
--    BH       Blues Health        Stock
--    CM       County Municipality Bond
--    DU       Downtown Utlity     Bond
--    EM       Emmitt Machines     Stock
insert into security values ('AE', 'Abhi Engineering', 		'Stock');
insert into security values ('BH', 'Blues Health', 			'Stock');
insert into security values ('CM', 'County Municipality',	'Bond');
insert into security values ('DU', 'Downtown Utlity', 		'Bond');
insert into security values ('EM', 'Emmitt Machines', 		'Stock');

-- create a table named fund 
--  with columns companyid, inceptiondate, fundid, name
--   fundid should be the primary key
--   companyid should be a foreign key referring to the company table.
create table fund
(	companyid		char(3)		not null,
	InceptionDate	date		not null,
    fundid			char(2)		not null,
    name			varchar(20)	not null,
    PRIMARY KEY (fundid),
    FOREIGN KEY (companyid) REFERENCES company(companyid) );

-- CompanyID  InceptionDate   FundID Name
--    ACF      2005-01-01     BG     Big Growth
--    ACF      2006-01-01     SG     Steady Growth
--    TCA      2005-01-01     LF     Tiger Fund
--    TCA      2006-01-01     OF     Owl Fund
--    ALB      2005-01-01     JU     Jupiter
--    ALB      2006-01-01     SA     Saturn
insert into fund values ('ACF', '2005-01-01', 'BG', 'Big Growth');
insert into fund values ('ACF', '2006-01-01', 'SG', 'Steady Growth');
insert into fund values ('TCA', '2005-01-01', 'LF', 'Tiger Fund');
insert into fund values ('TCA', '2006-01-01', 'OF', 'Owl Fund');
insert into fund values ('ALB', '2005-01-01', 'JU', 'Jupiter');
insert into fund values ('ALB', '2006-01-01', 'SA', 'Saturn');

-- create table holdings with columns
--   fundid, secid, quantity
--   make (fundid, secid) the primary key
--   fundid is also a foreign key referring to the fund  table
--   secid is also a foreign key referring to the security table
create table holdings
(	fundid		char(2)		not null,
	secid		char(2)		not null,
	quantity	int			not null, 
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
insert into holdings values ('BG', 'AE', '500'); 
insert into holdings values ('BG', 'EM', '300'); 
insert into holdings values ('SG', 'AE', '300');
insert into holdings values ('SG', 'DU', '300'); 
insert into holdings values ('LF', 'EM', '1000'); 
insert into holdings values ('LF', 'BH', '1000'); 
insert into holdings values ('OF', 'CM', '1000'); 
insert into holdings values ('OF', 'DU', '1000'); 
insert into holdings values ('JU', 'EM', '2000'); 
insert into holdings values ('JU', 'DU', '1000'); 
insert into holdings values ('SA', 'EM', '1000'); 
insert into holdings values ('SA', 'DU', '2000'); 

-- 15 Use alter table command to add a column "price" to the 
--    security table.  The datatype should be numeric(7,2)
alter table security 
add price int; 

-- 16 drop tables company, security, fund, holdings.
--    You must drop them in a certain order.  
--    In order to drop a table, you must first DROP
--    any tables that have foreign keys refering to that table.
drop table fund;
drop table company;
drop table holdings;
drop table security; 

-- For questions 17 -24, replace the "delete", "insert", "update" or "SELECT" 
-- statement with your working SQL statement.
-- 17 Try to delete the row for product with productid '5X1'
delete FROM product WHERE productid = '5x1';

-- 18 Explain why does the delete in question 17 fails. # check i need help with this does it have to do with how the forign key works? do i need to delete another tables before I can delete this one?


-- 19 Try to delete the row for product with productid '5X2'
delete FROM product WHERE productid = '5x2';

-- 20 Re-insert productid '5X2'
insert into product values('5X2', 'Action Sandal', 70.00, 'PG', 'FW');

-- 21  update the price of '5X2', 'Action Sandal' by $10.00
update product
	set productprice = 10
    WHERE productid = '5X2';

-- 22 increase the price of all products in the 'CY' category by 5% - Check this cause it doesn't want to change-- 
SELECT * FROM product WHERE categoryid = 'CY';
UPDATE product 
	SET productprice = productprice * 1.05 
    WHERE categoryid = 'CY';
SELECT * FROM product WHERE categoryid = 'CY';

-- 23 decrease the price of all products made by vendorname 'Pacifica Gear' by $5.00 #Check why cant i order it FROM vendorid?
SELECT * FROM product JOIN vendor on product.vendorid = vendor.vendorid WHERE vendor.vendorname = 'Pacifica Gear';
update product 
	set productprice = productprice - 5
    WHERE vendorid = 'PG';
SELECT * FROM product JOIN vendor on product.vendorid = vendor.vendorid WHERE vendor.vendorname = 'Pacifica Gear';
-- 24 List productid and productprice for all products.  Sort by productid;
SELECT productid, productprice FROM product
	ORDER BY productid;

