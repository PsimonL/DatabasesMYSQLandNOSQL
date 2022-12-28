-- Triggers for automat insertion of foreign keys into data records.
-- https://stackoverflow.com/questions/72418730/how-to-automaticaly-fill-a-foreign-key-when-a-row-is-inserted-in-postgresql
-- ##########################################################################################################################
-- ##########################################################################################################################
-- ##########################################################################################################################


-- #########################################################################
-- adding records to STUDENTS table
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
                                        (Select concat(lower(first_name), '_', lower(last_name), '@gmail.com'), phone));
        elsif domain LIKE 'yahoo.com' then
                 INSERT INTO students VALUES (default, first_name, last_name, student_card_id,
                                        (Select concat(lower(first_name), '_', lower(last_name), '@yahoo.com'), phone));
        elsif domain LIKE 'hotmail.com' then
             INSERT INTO students VALUES (default, first_name, last_name, student_card_id,
                                        (Select concat(lower(first_name), '_', lower(last_name), '@hotmail.com'), phone));
        else
                raise notice 'Domain NOT found.';
        end if;
    raise notice 'Inserted values for domain %.', domain;
    END
$procedure$;

CALL insert_vals_students('Jack', 'Sparrow',155533, 321842476, 'gmail.com');
CALL insert_vals_students('Elisabeth', 'Smith', 347033, 229868299, 'gmail.com');
CALL insert_vals_students('Will', 'Turner', 437652, 623613519, 'hotmail.com');
CALL insert_vals_students('Hector', 'Barbossa', 281673, 562652275, 'yahoo.com');
CALL insert_vals_students('James', 'Norrington', 404169, 938618097, 'gmail.com');
CALL insert_vals_students('Joshamee', 'Gibbs', 566316, 359300371, 'yahoo.com');

-- adding records to EMPLOYEES table
INSERT INTO employees VALUES (default, 'Jake Sully', 112, 'jake_sully_work@yahoo-inc.com', 938618097);
INSERT INTO employees VALUES (default, 'Grace Augustine', 242, 'grace_augustin_work@yahoo-inc.com', 359300371);

-- adding records to AUTHORS table
INSERT INTO authors VALUES (default, 'Fyodor', 'Dostoevsky');
INSERT INTO authors VALUES (default, 'William', 'Shakespeare');
INSERT INTO authors VALUES (default, 'Stephen', 'King');
INSERT INTO authors VALUES (default, 'Albert', 'Camus');
INSERT INTO authors VALUES (default, 'Oscar', 'Wilde');
INSERT INTO authors VALUES (default, 'Nicolaus', 'Copernicus');

-- adding records to BOOKS table
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

CALL insert_vals_books('Crime and Punishment', 'Dostoevsky', '111-222-333-444', false,
    1866, 'novel, psychological fiction, crime fiction, philosophical fiction');
CALL insert_vals_books('Hamlet', 'Shakespeare', '555-666-777-888', false,
    1599, 'tragedy, drama');
CALL insert_vals_books('The Plague', 'Camus', '999-000-111-222', false,
    1947, 'novel, philosophical fiction');
CALL insert_vals_books('IT', 'King', '333-444-555-666', true,
    1986, 'horror novel, horror fiction, thriller, dark fantasy, coming-of-age-story');
CALL insert_vals_books('On the Revolutions of the Heavenly Spheres', 'Copernicus', '777-888-999-000', false,
    1543, 'treatise');
CALL insert_vals_books ('Romeo and Julliet', 'Shakespeare', '111-555-333-222', false,
    1597, 'tragedy');
CALL insert_vals_books ('The Importance of Being Earnest', 'Wilde', '888-222-999-444', false,
    1895, 'comedy');
CALL insert_vals_books ('A Gentle Creature', 'Dostoevsky', '555-22-444-777', false,
    1876, 'short story, psychological fiction, philosophical fiction');
CALL insert_vals_books ('Macbeth', 'Shakespeare', '222-000-999-888', false,
    1623, 'tragedy');

-- adding records to RENTALS table
INSERT INTO rentals VALUES (default, (Select id_student From students Where full_name = 'Jack Sparrow'),
                            (Select id_employee From employees Where full_name = 'Grace Augustine'));

-- adding records to COMPLETION_DATE table
-- INSERT INTO completion_date VALUES (default, (Select id_rental From rentals Where ???),
--                                     (Select id_student From students Where full_name = 'Jack Sparrow'),
--                                     (Select id_employee From employees Where full_name = 'Grace Augustine'),
--                                     );
