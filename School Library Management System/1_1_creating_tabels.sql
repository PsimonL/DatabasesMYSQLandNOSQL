-- ###############################################################################################################################
-- ###############################################################################################################################
-- Creating initial tables
-- ###############################################################################################################################
-- ###############################################################################################################################

-- #########################################################################
-- 1
-- TABLE STUDENTS
DROP TABLE IF EXISTS students CASCADE;
CREATE TABLE  IF NOT EXISTS  students(
  id_student int GENERATED ALWAYS AS IDENTITY,
  first_name char (20) NOT NULL,
  last_name char (25) NOT NULL,
  student_card_id int NOT NULL,
  email char(70) NOT NULL, -- every email adress MUST contain @     CHECK(email LIKE '%@%')
  phone int NOT NULL ,

  PRIMARY KEY (id_student),
  UNIQUE (student_card_id),
  UNIQUE (phone),
  UNIQUE (email)
);
ALTER TABLE students ADD CONSTRAINT first_name CHECK(first_name ~* '[A-Za-z]');
ALTER TABLE students ADD CONSTRAINT last_name CHECK(last_name ~* '[A-Za-z]');
ALTER TABLE students ADD CONSTRAINT email CHECK(email NOT LIKE '%uniNameS.com');
ALTER TABLE students ADD CONSTRAINT phone CHECK(phone BETWEEN 111111111 AND 999999999);
DROP INDEX IF EXISTS id_employee_idx;
CREATE UNIQUE INDEX id_employee_idx ON students (id_student, first_name, last_name, student_card_id);
-- #########################################################################



-- #########################################################################
-- 2
-- TABLE EMPLOYEES
DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE  IF NOT EXISTS  employees(
  id_employee int GENERATED ALWAYS AS IDENTITY,
  first_name varchar(20),
  last_name varchar(20),
  employee_card_id int,
  email char(70) NOT NULL,
  phone int NOT NULL, -- phone number greater must contain 9 digits
  -- no DATALENGTH func in postgres and aggregate functions not allowed in check syntax

  PRIMARY KEY (id_employee),
  UNIQUE (employee_card_id),
  UNIQUE (phone),
  UNIQUE (email)
);
ALTER TABLE employees ADD CONSTRAINT email CHECK(email NOT LIKE '%uniNameE.com');
ALTER TABLE employees ADD CONSTRAINT phone CHECK(phone >= 111111111 AND phone <= 999999999);
DROP INDEX IF EXISTS id_employee_idx;
CREATE UNIQUE INDEX id_employee_idx ON employees (id_employee, first_name, last_name, employee_card_id, email, phone);
-- #########################################################################



-- #########################################################################
-- 3
-- TABLE AUTHORS
DROP TABLE IF EXISTS authors CASCADE;
CREATE TABLE  IF NOT EXISTS  authors(
  id_author int GENERATED ALWAYS AS IDENTITY,
  first_name char(20) NOT NULL,
  last_name char(30) NOT NULL,

  PRIMARY KEY (id_author)
);
ALTER TABLE authors ADD CONSTRAINT first_name CHECK(first_name ~* '[A-Za-z]');
ALTER TABLE authors ADD CONSTRAINT last_name CHECK(last_name ~* '[A-Za-z]');
DROP INDEX IF EXISTS id_author_idx;
CREATE UNIQUE INDEX id_author_idx ON authors (id_author, first_name, last_name);
-- #########################################################################



-- #########################################################################
-- 4
-- TABLE BOOKS
DROP TABLE IF EXISTS books CASCADE;
CREATE TABLE  IF NOT EXISTS  books(
  id_book int GENERATED ALWAYS AS IDENTITY,
  title varchar(150),
  id_author int NOT NULL,
  isbn char(20) UNIQUE,
  for_adults boolean NOT NULL,
  publication_year int NOT NULL,
  genre varchar(100) NOT NULL,

  PRIMARY KEY (id_book),
  CONSTRAINT fk_id_author
      FOREIGN KEY (id_author)
          REFERENCES authors(id_author),
  UNIQUE (isbn)
);
ALTER TABLE books ADD CONSTRAINT publication_year CHECK(publication_year >= 0);
ALTER TABLE books ALTER COLUMN genre SET DEFAULT 'No description provided.';
-- #########################################################################



-- #########################################################################
-- 5
-- TABLE RENTALS
DROP TABLE IF EXISTS rentals CASCADE;
CREATE TABLE  IF NOT EXISTS  rentals(
  id_rental int GENERATED ALWAYS AS IDENTITY,
  id_student int NOT NULL,
  id_employee int NOT NULL ,

  PRIMARY KEY (id_rental),
  CONSTRAINT fk_id_student
      FOREIGN KEY (id_student)
          REFERENCES students(id_student),
  CONSTRAINT fk_id_employee
      FOREIGN KEY (id_employee)
          REFERENCES employees(id_employee)
);
ALTER TABLE rentals ADD COLUMN id_book int;
ALTER TABLE rentals ADD  CONSTRAINT fk_id_book FOREIGN KEY (id_book) REFERENCES books(id_book);
-- #########################################################################



-- #########################################################################
-- 6
-- TABLE RENTALS
DROP TABLE IF EXISTS completion_date CASCADE;
CREATE TABLE  IF NOT EXISTS  completion_date(
  id_completion int GENERATED ALWAYS AS IDENTITY,
  id_rental int NOT NULL,
  id_student int NOT NULL,
  employee_card_id int NOT NULL,
  id_book int NOT NULL,
  rental_date date NOT NULL,
  return_date date NOT NULL,

  PRIMARY KEY (id_completion),
  CONSTRAINT fk_id_rental
      FOREIGN KEY (id_rental)
          REFERENCES rentals(id_rental),
  CONSTRAINT  fk_id_student
      FOREIGN KEY (id_student)
          REFERENCES students(id_student),
  CONSTRAINT fk_id_book
      FOREIGN KEY (id_book)
           REFERENCES books(id_book)

);
ALTER TABLE completion_date ADD CONSTRAINT return_date CHECK (return_date >= CURRENT_DATE);
ALTER TABLE completion_date ALTER COLUMN rental_date SET DEFAULT CURRENT_DATE;
-- #########################################################################



-- #########################################################################
-- 7
-- TABLE QUANTITY_BOOKS
DROP TABLE IF EXISTS quantity_books CASCADE;
CREATE TABLE  IF NOT EXISTS  quantity_books(
  id_quantity int GENERATED ALWAYS AS IDENTITY,
  id_author int NOT NULL,
  quantity int NOT NULL,

  PRIMARY KEY (id_quantity),
  CONSTRAINT fk_id_author
      FOREIGN KEY (id_author)
          REFERENCES authors(id_author)
);
-- #########################################################################



-- #########################################################################
-- 8
-- TABLE SUPPLY
DROP TABLE IF EXISTS supply_history CASCADE;
CREATE TABLE  IF NOT EXISTS  supply_history(
  id_supply int GENERATED ALWAYS AS IDENTITY,
  id_book int NOT NULL,
  title varchar(150) DEFAULT('None'),
  quantity int NOT NULL,

  PRIMARY KEY (id_supply),
  CONSTRAINT fk_id_book
      FOREIGN KEY (id_book)
          REFERENCES books(id_book),
  UNIQUE (title)
);
-- #########################################################################