-- hw6.sql
--   Yukio Rivera
-- 1 Mapping of production to warehouse tables and columns
--
--  It is an active transformation. alot of the tables changed. A few tables were removed from the database completely. The new warhouse removed 
--  seminar, seminar_cost, and contact.  
--  The first and last name column are made into one column, in the customer table 
--  The product table dropped unit prices and quantity on hand 
--  In invoice table invoice date was moved to timeline and changed to date, custid was added to product sale, all other columns were dropped
--  productname, quantity, unitprice, and total from lineitem was moved to product sales 
--  Anything that relates to the date was used to calulate quarter and date columns 
--

-- 2 Load data for table SALES_FOR_RFM  
INSERT INTO hsddw.sales_for_rfm
   (TimeId, CustomerId, InvoiceNumber, PreTaxTotalSales)
   SELECT timeline.timeid, customer.customerid, invoice.invoicenumber, invoice.SubTotal
   FROM hsddw.timeline, hsddw.customer, hsd.invoice
   WHERE invoice.customerid = customer.customerid
   AND invoice.invoicedate = timeline.date;

-- 3  create view of total dollar amount of each product for each year 
CREATE VIEW TotalSales AS  
   SELECT c.CustomerId, c.CustomerName, c.City, p.ProductNumber, p.ProductName, 
   t.Year,t.QuarterText, SUM(ps.total) AS TotalPrice
   FROM customer c, product_sales ps, product p,
      timeline t
   WHERE c.CustomerId = ps.CustomerID
      AND p.ProductNumber = ps.ProductNumber
      AND t.TimeId = ps.TimeID
   GROUP BY c.CustomerId, c.CustomerName, c.City,
      p.ProductNumber, p.ProductName,
      t.QuarterText, t.Year
   ORDER BY c.CustomerName, t.Year, t.QuarterText;


-- 4  populate the product_sales table with the new payment_id column.
INSERT INTO hsddw.product_sales
   (TimeId, CustomerId, productnumber, quantity, unitprice, total, payment_type_id)
   SELECT timeline.timeid, invoice.customerid, line_item.productnumber, SUM(line_item.quantity),
      MIN(line_item.unitprice), SUM(line_item.total), payment_type.payment_type_id
   FROM hsddw.timeline, hsd.invoice, hsd.line_item, payment_type
   WHERE invoice.invoicenumber = line_item.invoicenumber
   AND invoice.invoicedate = timeline.date
   AND payment_type.payment_type = invoice.paymenttype
   GROUP BY timeline.timeid, invoice.customerid, line_item.productnumber, payment_type.payment_type_id;
