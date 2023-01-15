-- ###############################################################################################################################
-- ###############################################################################################################################
-- Inserting EXAMPLE values
-- ###############################################################################################################################
-- ###############################################################################################################################

-- ###############################################################################################################################
-- STUDENTS TABLE
BEGIN TRANSACTION;
CALL insert_vals_students('Jack', 'Sparrow',155533, 321842476, 'uniNameS.com');
CALL insert_vals_students('Elizabeth', 'Swann', 347033, 229868299, 'uniNameS.com');
CALL insert_vals_students('Will', 'Turner', 437652, 623613519, 'uniNameS.com');
CALL insert_vals_students('Hector', 'Barbossa', 281673, 562652275, 'yahoo.com');
CALL insert_vals_students('James', 'Norrington', 404169, 938618097, 'uniNameS.com');
CALL insert_vals_students('Joshamee', 'Gibbs', 566316, 359300371, 'uniNameS.com');
COMMIT;

-- ###############################################################################################################################
-- EMPLOYEES TABLE
BEGIN TRANSACTION;
INSERT INTO employees VALUES (default, 'Jake', 'Sully', nextval('employee_card_id_seq'), 'jake_sully@uniNameE.com', 938618097);
INSERT INTO employees VALUES (default, 'Grace', 'Augustine', nextval('employee_card_id_seq'), 'grace_augustin@uniNameE.com', 359300371);
COMMIT;

-- ###############################################################################################################################
-- AUTHORS table
BEGIN TRANSACTION;
INSERT INTO authors VALUES (default, 'Fyodor', 'Dostoevsky');
INSERT INTO authors VALUES (default, 'William', 'Shakespeare');
INSERT INTO authors VALUES (default, 'Stephen', 'King');
INSERT INTO authors VALUES (default, 'Albert', 'Camus');
INSERT INTO authors VALUES (default, 'Oscar', 'Wilde');
INSERT INTO authors VALUES (default, 'Nicolaus', 'Copernicus');
COMMIT;

-- ###############################################################################################################################
-- BOOKS table
BEGIN TRANSACTION;
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
COMMIT;

-- ###############################################################################################################################
-- RENTALS table
BEGIN TRANSACTION;
CALL insert_vals_rentals('Jack', 'Jake','Sparrow', 'Sully', 9);
CALL insert_vals_rentals('Joshamee', 'Grace','Gibbs', 'Augustine', 3);
CALL insert_vals_rentals('James', 'Jake','Norrington', 'Sully', 6);
COMMIT;

-- ###############################################################################################################################
-- COMPLETION_DATE table
-- Insertion for RENTALS table triggers COMPLETION_DATE table insertion

-- ###############################################################################################################################
-- QUANTITY_BOOKS table
-- 1st name than 2nd name input
BEGIN TRANSACTION;
CALL insert_vals_quantity(30, 'Fyodor Dostoevsky');
CALL insert_vals_quantity(10, 'William Shakespeare');
CALL insert_vals_quantity(60, 'Stephen King');
CALL insert_vals_quantity(40, 'Albert Camus');
CALL insert_vals_quantity(70, 'Oscar Wilde');
CALL insert_vals_quantity(100, 'Nicolaus Copernicus');
COMMIT;

-- ###############################################################################################################################
-- SUPPLY_HISTORY table
BEGIN TRANSACTION;
-- SELECT * FROM quantity_books ORDER BY id_quantity;
-- SELECT * FROM supply_history;
CALL insert_vals_supply(5, null, 200);
CALL insert_vals_supply(6, null, 200);
-- SELECT * FROM supply_history;
-- SELECT * FROM quantity_books ORDER BY id_quantity;
COMMIT;