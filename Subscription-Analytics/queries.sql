USE subscription_analytics_db;

-- ==============================================================================
-- Query 1: Reconstructing State (Current Active Monthly Recurrent Revenue - MRR per Customer)
-- Technique: Window Functions (ROW_NUMBER / LAST_VALUE logic)
-- Business Case: Determine the exact current plan and active MRR for every user.
-- ==============================================================================
WITH LatestState AS (
    SELECT 
        se.customer_id,
        se.plan_id,
        se.event_type,
        se.event_date,
        ROW_NUMBER() OVER (PARTITION BY se.customer_id ORDER BY se.event_date DESC, se.event_id DESC) AS rn
    FROM subscription_events se
)
SELECT 
    c.customer_id,
    c.customer_name,
    p.plan_name,
    ls.event_type AS current_status,
    CASE 
        WHEN ls.event_type IN ('Cancel', 'Pause') THEN 0.00
        ELSE p.monthly_price 
    END AS current_mrr
FROM LatestState ls
JOIN customers c ON ls.customer_id = c.customer_id
JOIN plans p ON ls.plan_id = p.plan_id
WHERE ls.rn = 1;


-- ==============================================================================
-- Query 2: Monthly Recurring Revenue (MRR) Growth Ledger Breakdown
-- Technique: Window Functions (LAG) & Conditional Aggregations
-- Business Case: Categorize MRR movement into New, Expansion, Contraction, and Churned Revenue.
-- ==============================================================================
WITH EventMovements AS (
    SELECT 
        se.customer_id,
        se.event_type,
        se.event_date,
        p.monthly_price AS new_price,
        LAG(p.monthly_price, 1, 0.00) OVER (PARTITION BY se.customer_id ORDER BY se.event_date) AS prev_price
    FROM subscription_events se
    JOIN plans p ON se.plan_id = p.plan_id
)
SELECT 
    DATE_FORMAT(event_date, '%Y-%m') AS revenue_month,
    SUM(CASE WHEN event_type = 'Signup' THEN new_price ELSE 0 END) AS new_mrr,
    SUM(CASE WHEN event_type = 'Upgrade' THEN (new_price - prev_price) ELSE 0 END) AS expansion_mrr,
    SUM(CASE WHEN event_type = 'Downgrade' THEN (prev_price - new_price) ELSE 0 END) AS contraction_mrr,
    SUM(CASE WHEN event_type = 'Cancel' THEN prev_price ELSE 0 END) AS churned_mrr
FROM EventMovements
GROUP BY DATE_FORMAT(event_date, '%Y-%m')
ORDER BY revenue_month;


-- ==============================================================================
-- Query 3: Recursive Date Generator for Monthly User Cohort Retention
-- Technique: Recursive CTEs (Generating Time Series without explicit Date Dimension Table)
-- Business Case: Build a 6-Month Active Retention Matrix.
-- ==============================================================================
WITH RECURSIVE MonthGenerator AS (
    SELECT CAST('2024-01-01' AS DATE) AS month_start
    UNION ALL
    SELECT DATE_ADD(month_start, INTERVAL 1 MONTH)
    FROM MonthGenerator
    WHERE month_start < '2024-06-01'
)
SELECT 
    mg.month_start,
    COUNT(DISTINCT c.customer_id) AS total_signed_up_customers
FROM MonthGenerator mg
LEFT JOIN customers c ON DATE_FORMAT(c.signup_date, '%Y-%m-01') = mg.month_start
GROUP BY mg.month_start;