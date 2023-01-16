-- ###############################################################################################################################
-- ###############################################################################################################################
-- Example data sheets - VIEWS
-- ###############################################################################################################################
-- ###############################################################################################################################
-- https://www.sqlshack.com/learn-sql-join-multiple-tables/


-- https://www.postgresql.org/docs/current/rules-materializedviews.html
-- https://linuxhint.com/use-postgresql-materialized-views/
-- Materialized Views unable to proceed in PostgreSQL in PyCharm.
-- DROP MATERIALIZED VIEW IF EXISTS mat_view CASCADE;
-- CREATE OR REPLACE MATERIALIZED VIEW mat_view AS (...);
-- REFRESH MATERIALIZED VIEW mat_view;
-- SELECT * FROM mat_view;
--
-- Materialized views allows to store data physically, and thanks to that, indexes can be added to them.

-- View for combining authors with their books
DROP VIEW IF EXISTS ListingAuthorsBooks CASCADE;
CREATE OR REPLACE VIEW ListingAuthorsBooks
AS
    SELECT a.id_author AS author_id, (Select concat(a.last_name, a.first_name) As full_name),
           b.title AS book_title,
           b.publication_year AS created_in, b.genre AS description
        FROM books AS b
        LEFT JOIN authors AS a
        ON b.id_author = a.id_author
        ORDER BY publication_year DESC;
SELECT * FROM ListingAuthorsBooks;



-- Combining info for certain rental which contains employee and pearson who rented
DROP VIEW IF EXISTS RentalData CASCADE;
CREATE OR REPLACE VIEW RentalData
AS
    SELECT r.id_rental, r.id_employee, (Select concat(e.first_name, e.last_name) AS employee_name),
           r.id_student, (Select concat(s.first_name, s.last_name) AS student_name)
        FROM employees AS e
        INNER JOIN rentals AS r ON r.id_employee = e.id_employee
        INNER JOIN students AS s ON r.id_student = s.id_student
        ORDER BY id_student;
SELECT * FROM RentalData;



-- View for number of books for certain authors
DROP VIEW IF EXISTS ListingBooksForAuthors CASCADE;
CREATE OR REPLACE VIEW ListingBooksForAuthors
AS
   SELECT (Select concat(a.last_name, a.first_name) From authors As a Where a.id_author = b.id_author),
          COUNT(q.id_author) AS how_many_books
   FROM quantity_books AS q
   LEFT JOIN books AS b
   ON (b.id_author = q.id_author)
   GROUP BY b.id_author;
SELECT * FROM ListingBooksForAuthors;



-- View for combining rentals with students
DROP VIEW IF EXISTS ListingRentalsWithStudents CASCADE;
CREATE OR REPLACE VIEW ListingRentalsWithStudents
AS
    SELECT c.id_rental, c.employee_card_id, c.id_student,
        (Select concat(s.last_name, s.first_name) AS full_name),
        s.student_card_id, c.return_date
        FROM completion_date AS c
        LEFT JOIN students AS s ON c.id_student = s.id_student;
SELECT * FROM ListingRentalsWithStudents;



-- Complete info about book
DROP VIEW IF EXISTS BookInfo CASCADE;
CREATE OR REPLACE VIEW BookInfo
AS
    SELECT b.id_book, b.title, b.publication_year, b.genre,
           (Select concat(a.first_name, a.last_name) AS author),
            q.quantity
        FROM quantity_books AS q
        LEFT JOIN books AS b ON b.id_book = q.id_author
        LEFT JOIN authors AS a ON a.id_author = b.id_author
        ORDER BY id_book ASC;
SELECT * FROM BookInfo;



-- Certain quantity of every position for certain author
-- https://stackoverflow.com/questions/7994865/how-to-get-the-sum-of-foreign-key-table-as-a-value-in-the-primary-table-row-in-a
-- SELECT ;
SELECT * FROM authors;
SELECT * FROM quantity_books;
SELECT * FROM books;