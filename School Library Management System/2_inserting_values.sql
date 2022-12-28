-- Triggers for automat insertion of foreign keys into data records.
-- https://stackoverflow.com/questions/72418730/how-to-automaticaly-fill-a-foreign-key-when-a-row-is-inserted-in-postgresql


-- #########################################################################
-- ADDING RECORDS TO STUDENTS TABLE
INSERT INTO students VALUES (default, 'Jack Sparrow', 155533, 'jack_sparrow@gmail.com', 321842476);
INSERT INTO students VALUES (default, 'Elisabeth Smith', 347033, 'elisabeth_smith@gmail.com', 229868299);
INSERT INTO students VALUES (default, 'Will Turner', 437652, 'will_turner@gmail.com', 623613519);
INSERT INTO students VALUES (default, 'Hector Barbossa', 281673, 'hector_brabossa@gmail.com', 562652275);
INSERT INTO students VALUES (default, 'James Norrington', 404169, 'james_norrington@gmail.com', 938618097);
INSERT INTO students VALUES (default, 'Joshamee Gibbs', 566316, 'joshamee_gibbs@gmail.com', 359300371);



-- #########################################################################
-- ADDING RECORDS TO EMPLOYEES TABLE
INSERT INTO employees VALUES (default, 'Jake Sully', 112, 'jake_sully_work@yahoo-inc.com', 938618097);
INSERT INTO employees VALUES (default, 'Grace Augustine', 242, 'grace_augustin_work@yahoo-inc.com', 359300371);


-- #########################################################################
-- ADDING RECORDS TO AUTHORS TABLE
INSERT INTO authors VALUES (default, 'Fyodor', 'Dostoevsky');
INSERT INTO authors VALUES (default, 'William', 'Shakespeare');
INSERT INTO authors VALUES (default, 'Stephen', 'King');
INSERT INTO authors VALUES (default, 'Albert', 'Camus');
INSERT INTO authors VALUES (default, 'Oscar', 'Wilde');
INSERT INTO authors VALUES (default, 'Nicolaus', 'Copernicus');


-- #########################################################################
-- ADDING RECORDS TO BOOKS TABLE
INSERT INTO books VALUES (default, 'Crime and Punishment', (Select id_author From authors Where last_name = 'Dostoevsky')
, '111-222-333-444', false, 1866, 'novel, psychological fiction, crime fiction, philosophical fiction');
INSERT INTO books VALUES (default, 'Hamlet', (Select id_author From authors Where last_name = 'Shakespeare')
, '555-666-777-888', false, 1599, 'tragedy, drama');
INSERT INTO books VALUES (default, 'The Plague', (Select id_author From authors Where last_name = 'Camus')
, '999-000-111-222', false, 1947, 'novel, philosophical fiction');
INSERT INTO books VALUES (default, 'IT', (Select id_author From authors Where last_name = 'King')
, '333-444-555-666', true, 1986, 'horror novel, horror fiction, thriller, dark fantasy, coming-of-age-story');
INSERT INTO books VALUES (default, 'On the Revolutions of the Heavenly Spheres', (Select id_author From authors Where last_name = 'Copernicus')
, '777-888-999-000', false, 1543, 'treatise');
INSERT INTO books VALUES (default, 'Romeo and Julliet', (Select id_author From authors Where last_name = 'Shakespeare')
, '111-555-333-222', false, 1597, 'tragedy');
INSERT INTO books VALUES (default, 'The Importance of Being Earnest', (Select id_author From authors Where last_name = 'Wilde')
, '888-222-999-444', false, 1895, 'comedy');
INSERT INTO books VALUES (default, 'A Gentle Creature', (Select id_author From authors Where last_name = 'Dostoevsky')
, '555-22-444-777', false, 1876, 'short story, psychological fiction, philosophical fiction');
INSERT INTO books VALUES (default, 'Macbeth', (Select id_author From authors Where last_name = 'Shakespeare')
, '222-000-999-888', false, 1623, 'tragedy');



-- #########################################################################
-- ADDING RECORDS TO RENTALS TABLE
INSERT INTO rentals VALUES (0, 'Jack Sparrow', 000);


-- #########################################################################
-- ADDING RECORDS TO COMPLETION_DATE TABLE
INSERT INTO completion_date VALUES (0, 'Jack Sparrow', 000);