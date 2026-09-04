USE ecommerce_db;

-- 1. Populate Customers
INSERT INTO customers (customer_name, email, signup_date) VALUES
('John Doe', 'john@example.com', '2024-01-15'),
('Jane Smith', 'jane@example.com', '2024-02-01'),
('Michael Scott', 'michael@example.com', '2024-02-10'),
('Pam Beesly', 'pam@example.com', '2024-03-05'); -- Customer with no orders

-- 2. Populate Products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1000.00),
('Wireless Mouse', 'Electronics', 25.00),
('Mechanical Keyboard', 'Electronics', 75.00),
('Coffee Mug', 'Home & Kitchen', 15.00),
('Desk Lamp', 'Home & Kitchen', 40.00);

-- 3. Populate Orders
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-02-15'),
(2, '2024-02-18'),
(1, '2024-03-01'),
(3, '2024-03-10');

-- 4. Populate Order Items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), -- Order 1: 1 Laptop ($1000)
(1, 2, 2), -- Order 1: 2 Mice ($50)
(2, 3, 1), -- Order 2: 1 Keyboard ($75)
(2, 4, 2), -- Order 2: 2 Mugs ($30)
(3, 2, 1), -- Order 3: 1 Mouse ($25)
(4, 5, 2); -- Order 4: 2 Desk Lamps ($80)