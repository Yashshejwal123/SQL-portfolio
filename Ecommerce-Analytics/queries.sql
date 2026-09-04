USE ecommerce_db;

-- Query 1: Total Revenue and Total Orders
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.price * oi.quantity) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Query 2: Top Customer Spenders
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- Query 3: Sales Revenue by Product Category
SELECT 
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(p.price * oi.quantity) AS category_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- Query 4: Inactive Customers
SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.signup_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;