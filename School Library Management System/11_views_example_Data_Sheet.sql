-- ###############################################################################################################################
-- ###############################################################################################################################
-- Example data sheets - VIEWS
-- ###############################################################################################################################
-- ###############################################################################################################################

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



-- View for number of books for certain authors
DROP VIEW IF EXISTS ListingBooksForAuthors CASCADE;
CREATE OR REPLACE VIEW ListingBooksForAuthors
AS
    SELECT a.last_name, COUNT(b.id_author) AS count_of_books
        FROM authors AS a
        LEFT JOIN books AS b ON b.id_author = a.id_author
        GROUP BY a.last_name;
SELECT * FROM ListingBooksForAuthors;

