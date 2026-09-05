CREATE DATABASE IF NOT EXISTS subscription_analytics_db;
USE subscription_analytics_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS subscription_events;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS customers;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    signup_date DATE NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- 2. Tiered Subscription Plans
CREATE TABLE plans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL, -- Basic, Pro, Enterprise
    monthly_price DECIMAL(10, 2) NOT NULL
);

-- 3. Event-Driven Subscription State Transitions
CREATE TABLE subscription_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    plan_id INT NOT NULL,
    event_type VARCHAR(20) NOT NULL CHECK (event_type IN ('Signup', 'Upgrade', 'Downgrade', 'Cancel', 'Pause', 'Resume')),
    event_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (plan_id) REFERENCES plans(plan_id),
    INDEX idx_cust_event_date (customer_id, event_date)
);
