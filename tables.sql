USE users;

-- Reset tables safely
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS fines;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Authors Table
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100)
);

-- 2. Books Table
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150),
    author_id INT,
    category VARCHAR(50),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- 3. Members Table
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100),
    join_date DATE
);

-- 4. Loans Table (Junction Table)
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    loan_date DATE,
    due_date DATE,
    return_date DATE, -- NULL means the book is currently checked out
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);
