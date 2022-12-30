-- ###############################################################################################################################
-- ###############################################################################################################################
-- Example data sheets - FUNCTIONS / PROCEDURES
-- ###############################################################################################################################
-- ###############################################################################################################################

-- Number of all copies in library.
DROP FUNCTION IF EXISTS CurrentQuantityOfLibrary();
CREATE FUNCTION CurrentQuantityOfLibrary()
RETURNS int
LANGUAGE plpgsql
AS $$
    DECLARE
        no_books int;
    BEGIN
       SELECT sum(quantity_books.quantity) INTO no_books FROM quantity_books WHERE quantity > 0;
       RETURN no_books;
    END;
$$;
SELECT CurrentQuantityOfLibrary() AS NO_COPIES_in_the_entire_library;

