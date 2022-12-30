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
AS $procedure$
    BEGIN
        if domain LIKE 'gmail.com' then
            INSERT INTO students VALUES (default, first_name, last_name, student_card_id,
                                        (Select concat(lower(first_name), '_', lower(last_name), '@gmail.com')), phone);
        elsif domain LIKE 'yahoo.com' then
                 INSERT INTO students VALUES (default, first_name, last_name, student_card_id,
                                        (Select concat(lower(first_name), '_', lower(last_name), '@yahoo.com')), phone);
        elsif domain LIKE 'hotmail.com' then
             INSERT INTO students VALUES (default, first_name, last_name, student_card_id,
                                        (Select concat(lower(first_name), '_', lower(last_name), '@hotmail.com')), phone);
        else
                raise notice 'Domain NOT found.';
        end if;
    raise notice 'Inserted values for domain %.', domain;
    END
$procedure$;

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
AS $procedure$
    BEGIN
        INSERT INTO books VALUES (default, title, (Select id_author From authors Where last_name = l_name),
                                  isbn, for_adults, publication_year, genre);
    END
$procedure$;

-- ###############################################################################################################################
-- RENTALS table
DROP PROCEDURE IF EXISTS insert_vals_rentals();
CREATE OR REPLACE PROCEDURE insert_vals_rentals(
  first_name_student varchar(20),
  first_name_employee varchar(20),
  last_name_student varchar(20),
  last_name_employee varchar(20)
  )
LANGUAGE plpgsql
AS $procedure$
    DECLARE
        result_id_student int;
        result_id_employee int;
    BEGIN
        Select id_student Into result_id_student From students Where first_name = first_name_student And last_name = last_name_student;
        Select id_employee Into result_id_employee From employees Where first_name = first_name_employee And last_name = last_name_employee;
        INSERT INTO rentals VALUES (default, result_id_student, result_id_employee);
    END
$procedure$;

-- CALL insert_vals_rentals('Jack', 'Jake','Sparrow', 'Sully');

-- ###############################################################################################################################
-- COMPLETION_DATE table
DROP PROCEDURE IF EXISTS insert_vals_completion_date();
CREATE OR REPLACE PROCEDURE insert_vals_completion_date(
  first_name_student varchar(20),
  last_name_student varchar(20),
  employee_card_id int,
  return_date date
  )
LANGUAGE plpgsql
AS $procedure$
   DECLARE
        result_id_student int;
    BEGIN
        Select id_student Into result_id_student From students Where first_name = first_name_student And last_name = last_name_student;
        INSERT INTO completion_date VALUES (default, (Select max(id_rental) From rentals), result_id_student,
                                        employee_card_id, (Select CURRENT_DATE), return_date);
    END
$procedure$;


DROP FUNCTION IF EXISTS trigger_function_completion_date() CASCADE;
CREATE OR REPLACE FUNCTION trigger_function_completion_date()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $trigger$
    BEGIN
        CALL insert_vals_completion_date(first_name_student := 'Jack', last_name_student := 'Sparrow', employee_card_id := 112, return_date := '2023-01-10'); -- YYYY-MM-DD
        RETURN NEW;
    END
$trigger$;

DROP TRIGGER IF EXISTS trigger_completion_date ON rentals;
CREATE TRIGGER trigger_completion_date
   AFTER INSERT
   ON rentals
   FOR EACH ROW
       EXECUTE PROCEDURE trigger_function_completion_date();


CALL insert_vals_rentals('Jack', 'Jake','Sparrow', 'Sully');