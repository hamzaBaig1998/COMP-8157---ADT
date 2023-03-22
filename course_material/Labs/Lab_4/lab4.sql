-- Create the bank_accounts table
-- CREATE TABLE bank_accounts (
--     account_number INT PRIMARY KEY,
--     account_holder_name VARCHAR(50),
--     balance DECIMAL(10, 2)
-- );

-- Set the initial account balance to $200
-- INSERT INTO bank_accounts (account_number, account_holder_name, balance)
-- VALUES (110089314, 'Hamza Baig', 200);

-- Show bank accounts
-- SELECT * FROM bank_accounts;

-- Transaction 1
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
SELECT balance FROM bank_accounts WHERE account_number = 110089314
-- Do Some work
WAITFOR DELAY '00:00:10'
SELECT balance FROM bank_accounts WHERE account_number = 110089314
COMMIT TRANSACTION