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
  first_name char (20),
  last_name char (25),
  student_card_id int UNIQUE,
  email char(70),
  phone int,

  PRIMARY KEY (id_student)
);
-- #########################################################################


-- #########################################################################
-- 2
-- TABLE STUDENTS
DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE  IF NOT EXISTS  employees(
  id_employee int GENERATED ALWAYS AS IDENTITY,
  first_name varchar(20) UNIQUE,
  last_name varchar(20) UNIQUE,
  employee_card_id int UNIQUE,
  email char(70),
  phone int CHECK (phone >= 111111111 and phone <= 999999999), -- phone number greater must contain 9 digits
  -- no DATALENGTH func in postgres and aggregate functions not allowed in check syntax

  PRIMARY KEY (id_employee)
);
-- #########################################################################


-- #########################################################################
-- 3
-- TABLE AUTHORS
DROP TABLE IF EXISTS authors CASCADE;
CREATE TABLE  IF NOT EXISTS  authors(
  id_author int GENERATED ALWAYS AS IDENTITY,
  first_name char(20),
  last_name char(30),

  PRIMARY KEY (id_author)
);
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
  for_adults boolean,
  publication_year int,
  genre varchar(100),

  PRIMARY KEY (id_book),
  CONSTRAINT fk_id_author
      FOREIGN KEY (id_author)
          REFERENCES authors(id_author)
);
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
  rental_date date NOT NULL DEFAULT CURRENT_DATE,
  return_date date CHECK (return_date >= CURRENT_DATE),

  PRIMARY KEY (id_completion),
  CONSTRAINT fk_id_rental
      FOREIGN KEY (id_rental)
          REFERENCES rentals(id_rental),
  CONSTRAINT  fk_id_student
      FOREIGN KEY (id_student)
          REFERENCES students(id_student)
);
-- #########################################################################