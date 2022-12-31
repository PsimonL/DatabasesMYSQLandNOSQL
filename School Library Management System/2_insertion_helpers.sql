-- ###############################################################################################################################
-- ###############################################################################################################################
-- Procedures, functions and triggers for records adding operations
-- ###############################################################################################################################
-- ###############################################################################################################################
-- STUDENTS table
DROP PROCEDURE IF EXISTS insert_vals_students();
CREATE OR REPLACE PROCEDURE insert_vals_students(
  first_name char (20),
  last_name char (25),
  student_card_id int,
  phone int,
  domain char(15)
  )
LANGUAGE plpgsql
AS $procedure_for_inserting_students$
    BEGIN
        if domain LIKE 'uniNameS.com' then
            INSERT INTO students VALUES (default,
                                         first_name,
                                         last_name,
                                         student_card_id,
                                        (Select concat(lower(first_name), '_', lower(last_name), '@uniNameS.com')),
                                         phone);
        elsif domain LIKE 'yahoo.com' then
                raise notice '% is external domain. Only university domain approvable.', domain;
        elsif domain LIKE 'hotmail.com' then
                raise notice '% is external domain. Only university domain approvable.', domain;
        else
                raise notice 'Domain NOT in the database or NOT FOUND.';
        end if;
    raise notice 'Inserted values for domain %.', domain;
    END;
$procedure_for_inserting_students$;



-- ###############################################################################################################################
-- BOOKS table
DROP PROCEDURE IF EXISTS insert_vals_books();
CREATE OR REPLACE PROCEDURE insert_vals_books(
  title varchar(150),
  l_name varchar(40),
  isbn char(20),
  for_adults boolean,
  publication_year int,
  genre varchar(100)
  )
LANGUAGE plpgsql
AS $procedure_for_inserting_books$
    BEGIN
        INSERT INTO books VALUES (default, title,
                                  (Select id_author From authors Where last_name = l_name),
                                  isbn,
                                  for_adults,
                                  publication_year,
                                  genre);
    END;
$procedure_for_inserting_books$;



-- ###############################################################################################################################
-- QUANTITY table
DROP PROCEDURE IF EXISTS insert_vals_quantity();
CREATE OR REPLACE PROCEDURE insert_vals_quantity(
    quantity int,
    author_name varchar(60)
  )
LANGUAGE plpgsql
AS $procedure_for_inserting_quantity$
    DECLARE
        name_1st varchar(20);
        name_2nd varchar(30);
    BEGIN
        SELECT SPLIT_PART(author_name, ' ', 1) INTO name_1st;
        SELECT SPLIT_PART(author_name, ' ', 2) INTO name_2nd;

        INSERT INTO quantity_books VALUES (default,
                                     (Select id_author FROM authors WHERE first_name = name_1st AND last_name = name_2nd),
                                     quantity);
    END;
$procedure_for_inserting_quantity$;



-- ###############################################################################################################################
-- QUANTITY table
DROP PROCEDURE IF EXISTS insert_vals_supply();
CREATE OR REPLACE PROCEDURE insert_vals_supply(
    book_id int,
    title varchar(150),
    quant int
  )
LANGUAGE plpgsql
AS $procedure_for_inserting_supply$
    BEGIN
        INSERT INTO supply_history VALUES (default, book_id, title, quant);
    END;
$procedure_for_inserting_supply$;






-- ###############################################################################################################################
-- ###############################################################################################################################
-- RENTALS table
DROP PROCEDURE IF EXISTS insert_vals_rentals();
CREATE OR REPLACE PROCEDURE insert_vals_rentals(
  first_name_student varchar(20),
  first_name_employee varchar(20),
  last_name_student varchar(20),
  last_name_employee varchar(20),
  id_book int
  )
LANGUAGE plpgsql
AS $procedure$
    DECLARE
        result_id_student int;
        result_id_employee int;
    BEGIN
        SELECT id_student INTO result_id_student FROM students WHERE first_name = first_name_student AND last_name = last_name_student;
        SELECT id_employee INTO result_id_employee FROM employees WHERE first_name = first_name_employee AND last_name = last_name_employee;
        INSERT INTO rentals VALUES (default,
                                    result_id_student,
                                    result_id_employee,
                                    id_book);
    END;
$procedure$;

-- CALL insert_vals_rentals('Jack', 'Jake','Sparrow', 'Sully');



-- ###############################################################################################################################
-- COMPLETION_DATE table

-- DROP PROCEDURE IF EXISTS insert_vals_completion_date();
-- CREATE OR REPLACE PROCEDURE insert_vals_completion_date(
--   id_student int,
--   employee_card_id int,
--   id_book int,
--   return_date date
--   )
-- LANGUAGE plpgsql
-- AS $procedure$
--     BEGIN
--         INSERT INTO completion_date VALUES (default,
--                                             (Select max(id_rental) From rentals),
--                                             id_student,
--                                             id_book,
--                                             employee_card_id,
--                                             (Select CURRENT_DATE),
--                                             return_date);
--     END;
-- $procedure$;


DROP FUNCTION IF EXISTS trigger_function_completion_date() CASCADE;
CREATE OR REPLACE FUNCTION trigger_function_completion_date()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $trigger$
    BEGIN
        INSERT INTO completion_date VALUES (default,
                                            NEW.id_rental,
                                            NEW.id_student,
                                            NEW.id_employee,
                                            NEW.id_book,
                                            CURRENT_DATE,
                                            '2023-01-10');
        RETURN NEW;
    END;
$trigger$;


DROP TRIGGER IF EXISTS trigger_completion_date ON rentals;
CREATE TRIGGER trigger_completion_date
   AFTER INSERT
   ON rentals
   FOR EACH ROW
       EXECUTE PROCEDURE trigger_function_completion_date();


-- CALL insert_vals_rentals('Jack', 'Jake','Sparrow', 'Sully');