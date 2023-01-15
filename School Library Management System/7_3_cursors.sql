-- STUDENTS TABLE
-- https://www.youtube.com/watch?v=o4blx6Ij5S8&t=179s
CREATE OR REPLACE PROCEDURE select_all_rows()
LANGUAGE plpgsql
AS $cursor_procedure$
    DECLARE
        my_cursor REFCURSOR;
        row students%rowtype;
    BEGIN
        OPEN my_cursor FOR SELECT * FROM students;
        LOOP
            FETCH NEXT FROM my_cursor INTO row;
            RAISE NOTICE 'found=%', FOUND;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'row = % % %', row.id_student, row.first_name, row.last_name;
        END LOOP;
        CLOSE my_cursor;
        RAISE NOTICE 'finished';
    END;
$cursor_procedure$;
CALL select_all_rows();





-- EMPLOYEES TABLE


-- AUTHORS TABLE


-- BOOKS TABLE


-- RENTALS TABLE


-- COMPLETION_DATE TABLE


-- QUANTITY_BOOKS TABLE


-- SUPPLY_HISTORY TABLE
