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
SELECT product.categoryid, ROUND(AVG(product.productprice), 2) as AVGPrice
   FROM product
   GROUP BY product.categoryid;

-- 3 Display CategoryID and number of items purchased in that category.
SELECT category.categoryid, SUM(includes.quantity)
   FROM product JOIN category ON product.categoryid = category.categoryid
   JOIN includes ON product.productid = includes.productid
   GROUP BY category.categoryid;

-- 4 Display RegionID, RegionName and total amount of sales as "AmountSpent"
SELECT region.regionid, region.regionname, SUM(product.productprice * includes.quantity) as AmountSpent
   FROM product JOIN includes ON product.productid = includes.productid
   JOIN salestransaction ON includes.tid = salestransaction.tid
   JOIN store ON salestransaction.storeid = store.storeid
   JOIN region ON store.regionid = region.regionid
   GROUP BY region.regionid;

-- 5 Display the TID and total number of items in the sale
--    for all sales where the total number of items is greater than 3
SELECT includes.tid, SUM(includes.quantity)
   FROM includes
   GROUP BY includes.tid
   HAVING SUM(includes.quantity) > 3;

-- 6 For vendor whose product sales exceeds $700, display the
--    VendorID, VendorName and total amount of sales as "TotalSales"
SELECT vendor.vendorid, vendor.vendorname, SUM(includes.quantity*product.productprice) AS TotalSales
   FROM product NATURAL JOIN vendor NATURAL JOIN includes
   GROUP BY vendor.vendorid
   HAVING TotalSales > 700;

-- 7 Display the ProductID, Productname and ProductPrice
--    of the cheapest product.
SELECT product.productid, product.productname, product.productprice
   FROM product
   WHERE product.productprice = (SELECT MIN(product.productprice) FROM product);

-- 8 Display the ProductID, Productname and VendorName
--    for products whose price is below average price of all products
--    sorted by productid.
SELECT product.productid, product.productname, vendor.vendorname
   FROM product NATURAL JOIN vendor
   WHERE product.productprice < (SELECT AVG(product.productprice) FROM product)
   ORDER BY product.productid;

-- 9 Display the ProductID and Productname from products that
--    have sold more than 2 (total quantity).  Sort by ProductID
SELECT product.productid, product.productname
   FROM product NATURAL JOIN includes
   GROUP BY product.productid
   HAVING SUM(includes.quantity) > 2;

-- 10 Display the ProductID for the product that has been
--    sold the most (highest total quantity across all
--    transactions).
WITH temp AS (SELECT productid, sum(quantity) AS total_quantity
   FROM includes GROUP BY productid), temp1 AS
   (SELECT max(total_quantity) AS max_total_quantity FROM temp)
   SELECT productid FROM temp WHERE total_quantity = (SELECT max_total_quantity FROM temp1);

-- 11 Rewrite query 30 in chapter 5 using a join.
SELECT product.productid, product.productname, product.productprice
   FROM product INNER JOIN includes ON product.productid = includes.productid
   GROUP BY product.productid
   HAVING SUM(includes.quantity) > 3;

-- 12 Rewrite query 31 using a join.
SELECT product.productid, product.productname, product.productprice
   FROM product JOIN includes ON product.productid = includes.productid
   WHERE product.productid
   GROUP BY includes.productid
   HAVING COUNT(includes.tid) > 1;

-- 13 create a view over the product, salestransaction, includes, customer, store, region tables
--     with columns: tdate, productid, productname, productprice, quantity, customerid, customername,
--                   storeid, storezip, regionname
CREATE VIEW view_table
AS SELECT salestransaction.tdate, product.productid, product.productname,
   product.productprice, includes.quantity, customer.customerid,
   customer.customername, store.storeid, store.storezip, region.regionname
FROM product NATURAL JOIN salestransaction NATURAL JOIN includes NATURAL JOIN customer
   NATURAL JOIN store NATURAL JOIN region;

-- 14 Using the view created in question 13
--   Display ProductID, ProductName, ProductPrice
--   for products sold in zip code "60600" sorted by ProductID
SELECT view_table.productid, view_table.productname, view_table.productprice
   FROM view_table
   WHERE view_table.storezip = "60600"
   ORDER BY view_table.productid;

-- 15 Using the view from question 13
--    display CustomerName and TDate for any customer buying a product "Easy Boot"
SELECT view_table.customername, view_table.tdate
   FROM view_table
   WHERE view_table.productname = "Easy Boot";

-- 16 Using the view from question 13
--    display RegionName and total amount of sales in each region as "AmountSpent"
SELECT view_table.regionname, SUM(view_table.productprice * view_table.quantity) AS "AmountSpent"
   FROM view_table
   GROUP BY view_table.regionname;

-- 17 Display the product ID and name for products whose
--    total sales is less than 3 or total transactions is at most 1.
--    Use a UNION.
SELECT product.productid, product.productname
   FROM product NATURAL JOIN includes
   GROUP BY product.productid
   HAVING SUM(includes.quantity) < 3
UNION
SELECT product.productid, product.productname
   FROM product NATURAL JOIN includes
   GROUP BY product.productid
   HAVING COUNT(includes.tid) <= 1;

-- 18 Create a view named category_region 
--    over the category, region, store, salestranaction, includes,
--    and product tables that summarizes total quantity sold by region and category.  The view 
--    should have columns:
--    categoryid, categoryname, regionid, regionname, totalsales
CREATE VIEW category_region
AS SELECT category.categoryid, category.categoryname, region.regionid, region.regionname,
   SUM(quantity) AS totalsales
FROM product NATURAL JOIN category NATURAL JOIN includes NATURAL JOIN salestransaction NATURAL JOIN store NATURAL JOIN region
GROUP BY regionid, regionname, categoryid, categoryname;

-- 19 Using the view created in 18, which region has the most sales for
--    each category.
--    you should get the result
--    categoryname  regionname    totalsales
--    Electronics   Chicagoland   6
--    Climbing      Indiana       17
--    Camping       Tristate      9
--    Footwear      Tristate      20
--    Cycling       Chicagoland   13
SELECT categoryname, regionname, totalsales
   FROM category_region outerp
   WHERE totalsales =
         (SELECT max(innerp.totalsales)
         FROM category_region innerp
         WHERE innerp.categoryname=outerp.categoryname);
