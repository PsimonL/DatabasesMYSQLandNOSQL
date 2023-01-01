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


------------------------------------------------------------------------------------------------------
-- Update quantity_books after supply
DROP PROCEDURE IF EXISTS update_quantity_books_after_supply();
CREATE OR REPLACE PROCEDURE update_quantity_books_after_supply()
LANGUAGE plpgsql
AS $procedure_for_updating_quantity$
    BEGIN
        UPDATE quantity_books SET quantity = quantity_books.quantity + supply_history.quantity
            FROM supply_history
            WHERE quantity_books.id_book = supply_history.id_book;
    END;
$procedure_for_updating_quantity$;
CALL update_quantity_books_after_supply();
SELECT * FROM quantity_books;
------------------------------------------------------------------------------------------------------


-- Update return date for certain student
DROP PROCEDURE IF EXISTS update_return_date(days int, student_id int, book_id int);
CREATE OR REPLACE PROCEDURE update_return_date(days int, student_id int, book_id int)
LANGUAGE plpgsql
AS $procedure_for_updating_return_date$
    BEGIN
        UPDATE completion_date SET return_date = return_date + days
            WHERE id_student = student_id AND id_book = book_id;
    END;
$procedure_for_updating_return_date$;
CALL update_return_date(5, 1, 9);
SELECT * FROM completion_date;



-- Check how much time left with rental for certain student
DROP FUNCTION IF EXISTS CheckRentalTime(book char, student_id int);
CREATE FUNCTION CheckRentalTime(book char, student_id int)
RETURNS int
LANGUAGE plpgsql
AS $$
    DECLARE
        retVal int;
    BEGIN
    SELECT return_date - CURRENT_DATE, title INTO retVal FROM completion_date, books
        WHERE student_id = completion_date.id_student
        AND completion_date.id_book = (Select books.id_book Where books.title = book);
    RETURN retVal;
    END
$$;
DO $$
    DECLARE ret int;
BEGIN
        ret = (SELECT * FROM CheckRentalTime('The Plague', 1));
        raise notice 'Number of days left = %', ret;
END$$;
SELECT * FROM CheckRentalTime('The Plague', 1);