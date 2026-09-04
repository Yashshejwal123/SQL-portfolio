USE users;

-- Task 1: Calculate Overdue Books & Fine Amounts ($0.50/day late)
SELECT 
    m.member_name,
    b.title,
    l.due_date,
    DATEDIFF(CURRENT_DATE, l.due_date) AS days_overdue,
    CASE 
        WHEN DATEDIFF(CURRENT_DATE, l.due_date) > 0 
        THEN DATEDIFF(CURRENT_DATE, l.due_date) * 0.50
        ELSE 0.00
    END AS fine_amount
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL 
  AND l.due_date < CURRENT_DATE;


-- Task 2: Rank Most Popular Authors by Times Borrowed
SELECT 
    a.author_name,
    COUNT(l.loan_id) AS total_borrowed_times
FROM authors a
JOIN books b ON a.author_id = b.author_id
JOIN loans l ON b.book_id = l.book_id
GROUP BY a.author_id, a.author_name
ORDER BY total_borrowed_times DESC;


-- Task 3: Members with Active (Unreturned) Checkout Counts
SELECT 
    m.member_id,
    m.member_name,
    COUNT(l.loan_id) AS active_checkout_count
FROM members m
JOIN loans l ON m.member_id = l.member_id
WHERE l.return_date IS NULL
GROUP BY m.member_id, m.member_name
HAVING active_checkout_count >= 1
ORDER BY active_checkout_count DESC;


-- Task 4: Books That Have Never Been Borrowed
SELECT 
    b.book_id,
    b.title,
    b.category
FROM books b
LEFT JOIN loans l ON b.book_id = l.book_id
WHERE l.loan_id IS NULL;
