-- SELECT * FROM bookinfo
-- UNION
-- SELECT * FROM listingauthorsbooks;

-- Trigger to update quantity of books after supply
DROP FUNCTION IF EXISTS update_quantity_books_after_supply() CASCADE;
CREATE OR REPLACE FUNCTION update_quantity_books_after_supply()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $trigger$
    BEGIN
--         INSERT INTO completion_date VALUES (default,
--                                             NEW.id_rental,
--                                             NEW.id_student,
--                                             NEW.id_employee,
--                                             NEW.id_book,
--                                             CURRENT_DATE,
--                                             '2023-01-10');
        UPDATE quantity_books
            SET NEW.quantity = NEW.quantity + supply_history.quantity
            FROM supply_history
            WHERE quantity_books.id_book = supply_history.id_book;
        RETURN NEW;
    END;
$trigger$;


DROP TRIGGER IF EXISTS trigger_completion_date ON supply_history;
CREATE TRIGGER trigger_insert_supply
   AFTER INSERT
   ON supply_history
   FOR EACH ROW
       EXECUTE PROCEDURE update_quantity_books_after_supply();