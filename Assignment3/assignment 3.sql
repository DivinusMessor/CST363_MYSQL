-- Before you begin create the database and tables with the script
--  assignment_3_schema.sql

-- 1  Find the model number and price of all products (of any type) made by 
--    manufacturer B?  The result should be in order by model number and 
--    then by  price (low to high)  
--     hint:  use a union over the pc, laptop and printer tables
select 1;

-- 2  Find those manufacturers that sell laptops but not pc’s. 
--    Sort result by maker.
--    hint: use "not in" predicate and a subselect on the pc table.
select 2;

-- 3  Find the hard-drive sizes that occur in two or more PC’s.   
--    Sort the list low to high. [hint: use group and having]
select 3; 

-- 4  Find  PC models that have both the same speed and RAM.  The
--    output should have 2 columns,  "model1" and "model2".  A pair should be
--    listed only once:  e.g. if (f, g) is in the result then (g,f) should not
--    appear.   Sort the output by the first column.
select 4; 
 
-- 5  Find the maker or makers of PC’s with at least three different speeds. 
--    If more than one, order by maker.
--    hint: use a having clause containing a count(distinct   ) function.
select 5;

-- 6  Find those makers of at least two different computers (PC’s or 
--    laptops)  with speeds of at least 2.80.  Order the list by maker. 
--    hint:  use a subquery that does a UNION of the pc and laptop tables.
select 6; 

-- 7  Find the maker(s) of the computer (PC or laptop) with the highest 
--    speed.  If there are multiple makers, list all of them and order by maker.
select 7; 
