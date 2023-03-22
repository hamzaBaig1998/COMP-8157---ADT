-- Deposit money
-- DECLARE @deposit AS INT=200;

-- DECLARE @balance AS DECIMAL(10, 2);
-- SET @balance=isnull((SELECT balance FROM bank_accounts WHERE account_number = 110089314),0);
-- -- Transaction 2
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
-- UPDATE bank_accounts SET balance = @balance+@deposit WHERE account_number = 110089314;

-- SELECT * FROM bank_accounts;

-- Withdraw money
-- DECLARE @withdraw AS INT=800;

-- DECLARE @current_balance AS DECIMAL(10, 2);
-- SET @current_balance=isnull((SELECT balance FROM bank_accounts WHERE account_number = 110089314),0);
-- -- Transaction 2
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
-- IF (@current_balance-@withdraw>0)
--     UPDATE bank_accounts SET balance = @current_balance-@withdraw WHERE account_number = 110089314;
-- ELSE
--     PRINT 'You do not have enough money in your account!';

-- Display balance
SELECT balance FROM bank_accounts WHERE account_number = 110089314;
