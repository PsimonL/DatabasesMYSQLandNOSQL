-- ###############################################################################################################################
-- ###############################################################################################################################
-- Example data sheets
-- ###############################################################################################################################
-- ###############################################################################################################################

-- View for combining authors with their books
DROP VIEW IF EXISTS ListingAuthorsBooks CASCADE;
CREATE OR REPLACE VIEW ListingAuthorsBooks
AS
    SELECT authors.id_author AS author_id, (Select concat(authors.last_name, authors.first_name) As full_name),
           books.title AS book_title,
           books.publication_year AS created_in, books.genre AS description
        FROM books
        LEFT JOIN authors
        ON books.id_author = authors.id_author
        ORDER BY publication_year DESC;
SELECT * FROM ListingAuthorsBooks;

