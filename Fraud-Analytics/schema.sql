CREATE DATABASE IF NOT EXISTS fraud_analytics_db;
USE fraud_analytics_db;

-- Reset environment
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS fraud_flagged_logs;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Accounts Table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(20) CHECK (account_type IN ('Checking', 'Savings', 'Credit')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('Transfer', 'Withdrawal', 'Payment')),
    location_city VARCHAR(50) NOT NULL,
    transaction_time DATETIME NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    INDEX idx_account_time (account_id, transaction_time) -- Optimization for time-series joins
);
