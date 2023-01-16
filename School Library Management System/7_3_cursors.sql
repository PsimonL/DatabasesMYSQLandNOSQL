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



SELECT * FROM rentals;
-- Deleting returned rentals from RENTALS table
CREATE OR REPLACE PROCEDURE cursor_delete_rental(id_s INT, id_b INT)
LANGUAGE plpgsql
AS $cursor_procedure_d_r$
    DECLARE
        my_cursor REFCURSOR;
        row rentals%rowtype;
    BEGIN
        OPEN my_cursor FOR SELECT * FROM rentals AS r WHERE r.id_student = id_s AND r.id_book = id_b;
        LOOP
            FETCH NEXT FROM my_cursor into row;
            EXIT WHEN NOT FOUND;
                IF row.id_student = id_s AND row.id_book = id_b THEN
                    
                END IF;
        END LOOP;
        CLOSE my_cursor;
    END;
$cursor_procedure_d_r$;
CALL cursor_delete_rental(5, 3);
SELECT * FROM rentals;