-- Use the database for the HAFH Realty Company Property Management 
USE hafhmore;
-- 1 Display the answer to the following question: How many HAFH buildings have exactly 4 floors?
-- hint: the query should return a single number.
SELECT COUNT(building.buildingid) as FourFloorBuildings 
   FROM building
   WHERE building.bnooffloors = "4";

-- 2 Display the total amount HAFH spends on manager salaries (as TotalSalary) 
-- and the total amount HAFH spends on manager bonuses (as TotalBonus).
SELECT SUM(manager.msalary) as TotalSalary, SUM(manager.mbonus) as TotalBonus
   FROM manager;

-- 3 Display the ManagerID, MFName, MLName, MSalary, and MBonus, for all managers 
-- with a salary greater than $50,000 and a bonus greater than $1,000.
SELECT manager.managerid, manager.mfname, manager.mlname, manager.msalary, manager.mbonus 
   FROM manager
   WHERE manager.msalary > 50000 AND manager.mbonus > 1000;

-- 4 Display the BuildingID and AptNo for all apartments leased by the corporate client WindyCT.
SELECT apartment.buildingid, apartment.aptno
   FROM apartment NATURAL JOIN corpclient
   WHERE corpclient.ccname = "WindyCT";

-- 5 Display the InsID and InsName for all inspectors that have any inspections scheduled 
-- after 1-APR-2020. Do not display the same information more than once.
SELECT DISTINCT inspector.insid, inspector.insname
   FROM inspector NATURAL JOIN inspecting
   WHERE inspecting.datenext > '2020-04-01';

-- 6 Display the ManagerID, MFName, MLName, and 
-- number of buildings managed (no_buildings_managed), 
-- for all managers that manage more than one building.
SELECT manager.managerid, manager.mfname, manager.mlname, COUNT(building.buildingid) as NumBuild
   FROM building JOIN manager ON building.bmanagerid = manager.managerid
   GROUP BY manager.managerid
   HAVING NumBuild > 1;

-- 7 Display the SMemberID and SMemberName of staff members cleaning apartments 
-- rented by corporate clients whose corporate location is Chicago. 
-- Do not display the same information more than once.
SELECT DISTINCT staffmember.smemberid, staffmember.smembername
   FROM staffmember 
   NATURAL JOIN cleaning 
   NATURAL JOIN apartment 
   NATURAL JOIN corpclient
   WHERE corpclient.cclocation = "Chicago";

-- 8 Display the CCName of the client and the CCName of the client 
-- who referred him or her, for every client referred by a client in the Music industry.
SELECT m.ccname, e.ccname
   FROM corpclient e INNER JOIN corpclient m ON e.ccid = m.ccidreferredby
   WHERE e.ccindustry = 'Music';

-- 9 Display the BuildingID, AptNo, and ANoOfBedrooms for 
--  all apartments that are not leased.
SELECT apartment.buildingid, apartment.aptno, apartment.anoofbedrooms
   FROM apartment
   WHERE apartment.ccid IS NULL;

-- 10 Display the ManagerID, MFName, MLName, MSalary, and MBonus, 
-- for the manager(s) with the lowest total compensation 
-- (total compensation is defined as the salary plus bonus).
-- If bonus is null, consider its value to 0.  
-- Hint:  MySQL has some functions that can treat null value as a value of 0. 
-- See https://dev.mysql.com/doc/refman/8.0/en/built-in-function-reference.html  
SELECT manager.managerid, manager.mfname, manager.mlname, manager.msalary, IFNULL(manager.mbonus, 0) as mbonus
   FROM manager
   WHERE manager.msalary + IFNULL(manager.mbonus, 0) = (SELECT MIN(manager.msalary + IFNULL(manager.mbonus, 0)) FROM manager);
