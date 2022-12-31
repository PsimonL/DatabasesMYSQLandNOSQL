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




-- Return min, max qunatitty value.
DROP FUNCTION IF EXISTS MinMaxQuantity(choice char);
CREATE FUNCTION MinMaxQuantity(choice char)
RETURNS int
LANGUAGE plpgsql
AS $$
    DECLARE
        ret int;
    BEGIN
        if choice LIKE 'max' then
            SELECT max(quantity) AS max INTO ret FROM quantity_books;
        elsif choice LIKE 'min' then
            SELECT min(quantity) AS min INTO ret FROM quantity_books;
        else
            raise notice 'No other option!';
        end if;
    RETURN ret;
    END;
$$;
SELECT * FROM MinMaxQuantity('min');

