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


