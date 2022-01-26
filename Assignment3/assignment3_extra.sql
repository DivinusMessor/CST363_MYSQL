-- Before you begin create the database and tables with the script
--  assignment_3_schema.sql

-- 1  Find the model number and price of all products (of any type) made by 
--    manufacturer B?  The result should be in order by model number and 
--    then by  price (low to high)  
--     hint:  use a union over the pc, laptop and printer tables
SELECT model, price FROM laptop NATURAL JOIN product WHERE maker = 'B'
   UNION SELECT model, price FROM pc NATURAL JOIN product WHERE maker = 'B'
   UNION SELECT model, price FROM printer NATURAL JOIN product WHERE maker = 'B'
   ORDER BY model, price;

-- 2  Find those manufacturers that sell laptops but not pc’s. 
--    Sort result by maker.
--    hint: use "not in" predicate and a subselect on the pc table.
SELECT DISTINCT maker 
	FROM product
    WHERE maker NOT IN (SELECT maker FROM product WHERE type = 'pc')
    AND product.type = 'laptop'
    ORDER BY maker;



-- 3  Find the hard-drive sizes that occur in two or more PC’s.   
--    Sort the list low to high. [hint: use group and having]
SELECT hd FROM pc
   GROUP BY hd
   HAVING COUNT(hd) >= 2
   ORDER BY hd;

-- 4  Find  PC models that have both the same speed and RAM.  The
--    output should have 2 columns,  "model1" and "model2".  A pair should be
--    listed only once:  e.g. if (f, g) is in the result then (g,f) should not
--    appear.   Sort the output by the first column.
SELECT model1.model AS modela, model2.model AS modelb
   FROM pc model1 JOIN pc model2 ON model1.speed = model2.speed 
   AND model1.ram = model2.ram 
   AND model1.model > model2.model
   ORDER BY modela;
 
-- 5  Find the maker or makers of PC’s with at least three different speeds. 
--    If more than one, order by maker.
--    hint: use a having clause containing a count(distinct   ) function.
SELECT maker
	FROM product NATURAL JOIN pc 
	GROUP BY maker
	HAVING COUNT(DISTINCT pc.speed) >= 3
    ORDER BY maker;

-- 6  Find those makers of at least two different computers (PC’s or 
--    laptops)  with speeds of at least 2.80.  Order the list by maker. 
--    hint:  use a subquery that does a UNION of the pc and laptop tables.
select 6; 

-- 7  Find the maker(s) of the computer (PC or laptop) with the highest 
--    speed.  If there are multiple makers, list all of them and order by maker.
select 7; 
