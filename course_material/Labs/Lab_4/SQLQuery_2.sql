-- CREATE TABLE Products
-- (
--  Id INT PRIMARY KEY,
--  Name VARCHAR(100),
--  Quantity INT
-- ) 

-- INSERT INTO Products values (1001, 'Mobile', 10)
-- INSERT INTO Products values (1002, 'Tablet', 20)
-- INSERT INTO Products values (1003, 'Laptop', 30)


BEGIN TRANSACTION
 UPDATE Products SET Quantity = 5 WHERE Id=1001
 -- Billing the customer
 Waitfor Delay '00:00:15'
 -- Insufficient Funds. Rollback transaction
ROLLBACK TRANSACTION