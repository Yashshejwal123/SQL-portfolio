USE users;

-- 1. Populate Authors
INSERT INTO authors (author_name) VALUES
('George Orwell'),
('J.K. Rowling'),
('J.R.R. Tolkien'),
('Agatha Christie');

-- 2. Populate Books (Includes 'The Great Gatsby' as an unborrowed book for Task 4)
INSERT INTO books (title, author_id, category) VALUES
('1984', 1, 'Dystopian'),
('Animal Farm', 1, 'Political Satire'),
('Harry Potter and the Sorcerer\'s Stone', 2, 'Fantasy'),
('Harry Potter and the Chamber of Secrets', 2, 'Fantasy'),
('The Hobbit', 3, 'Fantasy'),
('And Then There Were None', 4, 'Mystery'),
('The Great Gatsby', 1, 'Classic');

-- 3. Populate Members
INSERT INTO members (member_name, join_date) VALUES
('Alice Walker', '2024-01-10'),
('Bob Smith', '2024-02-15'),
('Charlie Brown', '2024-03-01'),
('Diana Prince', '2024-03-20');

-- 4. Populate Loans
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(1, 1, '2024-08-01', '2024-08-15', '2024-08-14'), -- Returned on time
(2, 1, '2024-08-10', '2024-08-24', '2024-08-30'), -- Returned late
(3, 2, '2024-08-15', '2024-08-29', NULL),         -- Unreturned & Overdue
(5, 2, '2024-08-20', '2024-09-03', NULL),         -- Unreturned & Overdue
(4, 3, '2024-08-01', '2024-08-15', NULL),         -- Unreturned & Overdue
(6, 1, '2024-08-25', '2024-09-08', '2024-09-05'); -- Returned on time