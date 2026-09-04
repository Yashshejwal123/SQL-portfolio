USE fraud_analytics_db;

-- Populate Accounts
INSERT INTO accounts (customer_name, account_type, created_at) VALUES
('Alexander Wright', 'Checking', '2023-01-10 08:00:00'),
('Sophia Martinez', 'Credit', '2023-03-15 10:30:00'),
('David Chen', 'Checking', '2023-05-20 14:15:00');

-- Populate Transactions
INSERT INTO transactions (account_id, amount, transaction_type, location_city, transaction_time) VALUES
-- Normal activity for Account 1
(1, 45.00, 'Payment', 'New York', '2024-05-01 09:00:00'),
(1, 120.50, 'Payment', 'New York', '2024-05-02 12:30:00'),
(1, 35.00, 'Payment', 'New York', '2024-05-03 18:15:00'),
-- FRAUD SCENARIO 1: Rapid Velocity & Impossible Travel (Account 1 in London 5 minutes later)
(1, 2500.00, 'Withdrawal', 'London', '2024-05-03 18:20:00'),

-- Normal activity for Account 2
(2, 50.00, 'Payment', 'Chicago', '2024-05-01 10:00:00'),
(2, 60.00, 'Payment', 'Chicago', '2024-05-02 11:00:00'),
-- FRAUD SCENARIO 2: Massive Sudden Transaction Amount Spike (> 10x Average)
(2, 9500.00, 'Transfer', 'Chicago', '2024-05-03 14:00:00'),

-- Normal activity for Account 3
(3, 200.00, 'Payment', 'San Francisco', '2024-05-01 08:00:00'),
(3, 150.00, 'Withdrawal', 'San Francisco', '2024-05-02 09:30:00');