USE subscription_analytics_db;

INSERT INTO plans (plan_name, monthly_price) VALUES
('Basic', 10.00),
('Pro', 30.00),
('Enterprise', 100.00);

INSERT INTO customers (customer_name, signup_date, country) VALUES
('TechCorp Inc', '2024-01-01', 'USA'),
('Acme Solutions', '2024-01-15', 'Canada'),
('DevStudio', '2024-02-01', 'UK'),
('StartupX', '2024-02-10', 'USA');

-- Lifecycle Events
INSERT INTO subscription_events (customer_id, plan_id, event_type, event_date) VALUES
-- TechCorp: Starts Basic -> Upgrades to Pro -> Upgrades to Enterprise
(1, 1, 'Signup', '2024-01-01'),
(1, 2, 'Upgrade', '2024-03-01'),
(1, 3, 'Upgrade', '2024-06-01'),

-- Acme Solutions: Starts Pro -> Downgrades to Basic -> Cancels (Churn)
(2, 2, 'Signup', '2024-01-15'),
(2, 1, 'Downgrade', '2024-04-15'),
(2, 1, 'Cancel', '2024-05-15'),

-- DevStudio: Starts Enterprise -> Pauses -> Resumes
(3, 3, 'Signup', '2024-02-01'),
(3, 3, 'Pause', '2024-04-01'),
(3, 3, 'Resume', '2024-05-01'),

-- StartupX: Starts Basic -> Upgrades to Pro
(4, 1, 'Signup', '2024-02-10'),
(4, 2, 'Upgrade', '2024-05-10');