-- Printing info about students
-- https://www.youtube.com/watch?v=o4blx6Ij5S8&t=179s
CREATE OR REPLACE PROCEDURE cursor_students_table()
LANGUAGE plpgsql
AS $cursor_procedure_s_i$
    DECLARE
        my_cursor REFCURSOR;
        row students%rowtype;
    BEGIN
        OPEN my_cursor FOR SELECT * FROM students;
        LOOP
            FETCH NEXT FROM my_cursor INTO row;
--             RAISE NOTICE 'found=%', FOUND;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'STUDENT %  : % % % % %' , row.id_student, row.first_name,
                                                row.last_name, row.student_card_id,
                                                row.email, row.phone;
        END LOOP;
        CLOSE my_cursor;
        RAISE NOTICE 'finished: printing students table';
    END;
$cursor_procedure_s_i$;
CALL cursor_students_table();



-- Printing info about employee for certain ID
CREATE OR REPLACE PROCEDURE cursor_employees_table(x INT)
LANGUAGE plpgsql
AS $cursor_procedure_e_i$
    DECLARE
        my_cursor REFCURSOR;
        row employees%rowtype;
    BEGIN
        OPEN my_cursor FOR SELECT * FROM employees WHERE employee_card_id = x;
        FETCH NEXT FROM my_cursor INTO row;
        RAISE NOTICE 'Employee for card id %. Employee: % %' , x, row.first_name, row.last_name;
        RAISE NOTICE 'Phone %', row.phone;
        RAISE NOTICE ' Email address: %', row.email;
        CLOSE my_cursor;
    END;
$cursor_procedure_e_i$;
CALL cursor_employees_table(1);



-- Deleting returned rentals from RENTALS table
SELECT * FROM rentals;
SELECT * FROM completion_date;
CREATE OR REPLACE PROCEDURE cursor_delete_rental(id_s INT, id_b INT)
LANGUAGE plpgsql
AS $cursor_procedure_d_r$
    DECLARE
        my_cursor REFCURSOR;
        row rentals%rowtype;
        row2 completion_date%rowtype;
    BEGIN
        OPEN my_cursor FOR SELECT * FROM rentals;
        LOOP
            FETCH NEXT FROM my_cursor INTO row;
            EXIT WHEN NOT FOUND;
                IF row.id_student = id_s AND row.id_book = id_b THEN
                    RAISE NOTICE 'Status changed to RETURNED for data:  % % % %', row2.id_rental, row2.return_date, row2.id_student, row2.id_book;
                    DELETE FROM completion_date AS c WHERE c.id_student = id_s AND c.id_book = id_b;
                    DELETE FROM rentals AS r WHERE r.id_student = id_s AND r.id_book = id_b;
                    RAISE NOTICE 'Data set deleted for returned book for id_rental = %:   % %',
                        row2.id_rental,
                        (Select concat(last_name, first_name) From students As full_name Where row.id_student = id_s And row.id_student Is Distinct From id_s), -- Limit 1
                        row.id_book;
                END IF;
        END LOOP;
        CLOSE my_cursor;
    END;
$cursor_procedure_d_r$;
CALL cursor_delete_rental(5, 3);
SELECT * FROM rentals;
SELECT * FROM completion_date;



-- Update column "for_adults" or "genre" in BOOKS TABLE
SELECT * FROM books;
CREATE OR REPLACE PROCEDURE cursor_update_books(t varchar(150) DEFAULT null, g varchar(100) DEFAULT null)
LANGUAGE plpgsql
AS $cursor_procedure_d_r$
    DECLARE
        my_cursor REFCURSOR;
        row books%rowtype;
    BEGIN
        OPEN my_cursor FOR SELECT * FROM books;
        LOOP
            FETCH NEXT FROM my_cursor INTO row;
            EXIT WHEN NOT FOUND;
            IF t IS NOT NULL AND g IS NULL THEN
                IF row.for_adults = False AND row.title = t THEN
                    UPDATE books SET for_adults = true WHERE row.title = title;
                END IF;
            ELSEIF t IS NOT NULL AND g IS NOT NULL THEN
                IF row.title = t THEN
                    UPDATE books SET genre = g WHERE row.title = t;
                END IF;
            ELSE
                RAISE NOTICE 'Option not found.';
            END IF;
        END LOOP;
        CLOSE my_cursor;
    END;
$cursor_procedure_d_r$;
CALL cursor_update_books('Circe', null);
SELECT * FROM books;