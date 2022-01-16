-- e5.1 Exercises from chapter 5
--
-- Before you begin:
-- re-create the tables and data using the script 
--   zagimore_schema.sql

-- 1  Display the RegionID, RegionName and number of stores in each region.
SELECT region.regionid, region.regionname, COUNT(store.storeid)
   FROM region JOIN store ON region.regionid = store.regionid
   GROUP BY region.regionid;

-- 2 Display CategoryID and average price of products in that category.
--   Use the ROUND function to show 2 digits after decimal point in average price.
SELECT category.categoryid, ROUND(AVG(product.productprice), 2)
   FROM product JOIN category ON product.categoryid = category.categoryid
   GROUP BY category.categoryid;

-- 3 Display CategoryID and number of items purchased in that category. 
"Do we check the number of products or the quanity?"
SELECT category.categoryid, COUNT(product.productname)
   FROM product JOIN category ON product.categoryid = category.categoryid
   JOIN includes ON product.productid = includes.productid
   GROUP BY category.categoryid;

-- 4 Display RegionID, RegionName and total amount of sales as "AmountSpent"
SELECT region.regionid, region.regionname, SUM(product.productprice) as AmountSpent
   FROM product JOIN includes ON product.productid = includes.productid
   JOIN salestransaction ON includes.tid = salestransaction.tid 
   JOIN store ON salestransaction.storeid = store.storeid
   JOIN region ON store.regionid = region.regionid
   GROUP BY region.regionid;

-- 5 Display the TID and total number of items in the sale
--    for all sales where the total number of items is greater than 3
SELECT salestransaction.tid, COUNT(salestransaction.tid)
   FROM product JOIN includes ON product.productid = includes.productid
   JOIN salestransaction ON includes.tid = salestransaction.tid
   GROUP BY salestransaction.tid
   HAVING COUNT(salestransaction.tid) > 3;

-- 6 For vendor whose product sales exceeds $700, display the
--    VendorID, VendorName and total amount of sales as "TotalSales"
SELECT vendor.vendorid, vendor.vendorname, CONCAT("$", SUM(product.productprice)) AS TotalSales
   FROM vendor JOIN product ON vendor.vendorid = product.vendorid
   GROUP BY vendorname
   HAVING SUM(product.productprice) > 700;

-- 7 Display the ProductID, Productname and ProductPrice
--    of the cheapest product.
SELECT product.productid, product.productname, product.productprice
   FROM product 
   WHERE product.productprice = (SELECT MIN(product.productprice) FROM product)

-- 8 Display the ProductID, Productname and VendorName
--    for products whose price is below average price of all products
--    sorted by productid. -- CHECK need to redo 
SELECT product.productid, product.productname, vendor.vendorname
   FROM product JOIN vendor ON product.vendorid = vendor.vendorid;
   WHERE product.productprice < (SELECT AVG(product.productprice) FROM product);

-- 9 Display the ProductID and Productname from products that
--    have sold more than 2 (total quantity).  Sort by ProductID
"Check this to see if it is good"
SELECT product.productid, product.productname, includes.quantity
   FROM product JOIN includes ON product.productid = includes.productid
   WHERE SUM(includes.quantity) > 2
   GROUP BY product.productid
   ORDER BY product.productid;

-- 10 Display the ProductID for the product that has been 
--    sold the most (highest total quantity across all
--    transactions). 
"Check"
SELECT includes.productid
   FROM includes
   WHERE includes.quantity = (SELECT MAX(quantity) FROM includes);


-- 11 Rewrite query 30 in chapter 5 using a join.
SELECT product.productid, product.productname, product.productprice
FROM product INNER JOIN includes ON product.productid = includes.productid
GROUP BY product.productid 
HAVING SUM(includes.quantity) > 3;

-- 12 Rewrite query 31 using a join.
SELECT product.productid, product.productname, product.productprice, includes.tid
FROM product JOIN includes ON product.productid = includes.productid 
WHERE product.productid 

"Book example"
SELECT product.productid, product.productname, product.productprice
FROM product 
WHERE product.productid IN 
(SELECT includes.productid
FROM includes 
GROUP BY includes.productid
HAVING COUNT(includes.tid) > 1);

-- 13 create a view over the product, salestransaction, includes, customer, store, region tables
--     with columns: tdate, productid, productname, productprice, quantity, customerid, customername, 
--                   storeid, storezip, regionname
create view 13;

-- 14 Using the view created in question 13
--   Display ProductID, ProductName, ProductPrice  
--   for products sold in zip code "60600" sorted by ProductID
select 14;

-- 15 Using the view from question 13 
--    display CustomerName and TDate for any customer buying a product "Easy Boot"
select 15;

-- 16 Using the view from question 13
--    display RegionName and total amount of sales in each region as "AmountSpent"
select 16;

-- 17 Display the product ID and name for products whose 
--    total sales is less than 3 or total transactions is at most 1.
--    Use a UNION. 
select 17;

-- 18 Create a view named category_region 
--    over the category, region, store, salestranaction, includes,
--    and product tables that summarizes total quantity sold by region and category.  The view 
--    should have columns:
--    categoryid, categoryname, regionid, regionname, totalsales
create view 18;

-- 19 Using the view created in 18, which region has the most sales for 
--    each category.
--    you should get the result
--    categoryname  regionname    totalsales
--    Electronics   Chicagoland   6
--    Climbing      Indiana       17
--    Camping       Tristate      9
--    Footwear      Tristate      20
--    Cycling       Chicagoland   13
select 19;


