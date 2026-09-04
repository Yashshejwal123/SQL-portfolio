USE fraud_analytics_db;

-- ==============================================================================
-- Query 1: Impossible Travel Detection (Rapid Consecutive Transactions in Different Cities)
-- Technique: Self-Join with TIMESTAMPDIFF
-- Business Case: Flag transactions occurring within 30 minutes of each other in different cities.
-- ==============================================================================
SELECT 
    t1.account_id,
    a.customer_name,
    t1.transaction_id AS t1_id,
    t1.location_city AS t1_city,
    t1.transaction_time AS t1_time,
    t2.transaction_id AS t2_id,
    t2.location_city AS t2_city,
    t2.transaction_time AS t2_time,
    TIMESTAMPDIFF(MINUTE, t1.transaction_time, t2.transaction_time) AS time_gap_minutes
FROM transactions t1
JOIN transactions t2 
    ON t1.account_id = t2.account_id 
    AND t1.transaction_id < t2.transaction_id
JOIN accounts a ON t1.account_id = a.account_id
WHERE t1.location_city <> t2.location_city
  AND TIMESTAMPDIFF(MINUTE, t1.transaction_time, t2.transaction_time) BETWEEN 0 AND 30;


-- ==============================================================================
-- Query 2: Anomaly Amount Spike Detection (Transactions > 5x User's Average)
-- Technique: Window Functions (AVG OVER) & CTEs
-- Business Case: Identify high-value transactions deviating significantly from account baseline.
-- ==============================================================================
WITH UserBaselines AS (
    SELECT 
        transaction_id,
        account_id,
        amount,
        transaction_type,
        transaction_time,
        AVG(amount) OVER (PARTITION BY account_id) AS avg_historical_amount
    FROM transactions
)
SELECT 
    ub.transaction_id,
    a.customer_name,
    ub.amount AS transaction_amount,
    ROUND(ub.avg_historical_amount, 2) AS historical_avg_amount,
    ROUND(ub.amount / ub.avg_historical_amount, 1) AS spike_multiplier
FROM UserBaselines ub
JOIN accounts a ON ub.account_id = a.account_id
WHERE ub.amount > (5 * ub.avg_historical_amount);


-- ==============================================================================
-- Query 3: Running Account Balance & High-Velocity Drain Tracking
-- Technique: Window Functions (SUM OVER ORDER BY)
-- Business Case: Compute real-time running ledger per account to detect balance depletion.
-- ==============================================================================
SELECT 
    t.transaction_id,
    a.customer_name,
    t.transaction_time,
    t.transaction_type,
    t.amount,
    SUM(CASE WHEN t.transaction_type = 'Transfer' OR t.transaction_type = 'Withdrawal' THEN -t.amount ELSE t.amount END) 
        OVER (PARTITION BY t.account_id ORDER BY t.transaction_time) AS running_balance
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id;