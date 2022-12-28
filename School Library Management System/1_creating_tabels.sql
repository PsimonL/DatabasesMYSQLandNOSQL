-- #########################################################################
-- 1
-- TABLE STUDENTS
CREATE TABLE  IF NOT EXISTS  students(
  id_student int GENERATED ALWAYS AS IDENTITY,
  full_name char(50),
  student_card_id int UNIQUE,
  email char(70),
  phone int,

  PRIMARY KEY (id_student)
);
-- #########################################################################


-- #########################################################################
-- 2
-- TABLE STUDENTS
CREATE TABLE  IF NOT EXISTS  employees(
  id_employee int GENERATED ALWAYS AS IDENTITY,
  full_name char(50),
  employee_card_id int UNIQUE,
  email char(70),
  phone int,

  PRIMARY KEY (id_employee)
);
-- #########################################################################


-- #########################################################################
-- 3
-- TABLE AUTHORS
CREATE TABLE  IF NOT EXISTS  authors(
  id_author int GENERATED ALWAYS AS IDENTITY,
  first_name char(10),
  last_name char(10),

  PRIMARY KEY (id_author)
);
-- #########################################################################


-- #########################################################################
-- 4
-- TABLE BOOKS
CREATE TABLE  IF NOT EXISTS  books(
  id_book int GENERATED ALWAYS AS IDENTITY,
  title varchar(150),
  id_author int NOT NULL,
  isbn int UNIQUE,
  for_adults boolean,
  publication_year int,
  book_topic varchar(1000),

  PRIMARY KEY (id_book),
  CONSTRAINT fk_id_author
      FOREIGN KEY (id_author)
          REFERENCES authors(id_author)
);
-- #########################################################################


-- #########################################################################
-- 5
-- TABLE RENTALS
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
CREATE TABLE  IF NOT EXISTS  completion_date(
  id_completion int GENERATED ALWAYS AS IDENTITY,
  id_rental int NOT NULL,
  id_student int NOT NULL,
  id_employee int NOT NULL,
  rental_date timestamp DEFAULT now(),
  return_date date,

  PRIMARY KEY (id_completion),
  CONSTRAINT fk_id_rental
      FOREIGN KEY (id_rental)
          REFERENCES rentals(id_rental),
  CONSTRAINT  fk_id_student
      FOREIGN KEY (id_student)
          REFERENCES students(id_student),
  CONSTRAINT fk_id_employee
      FOREIGN KEY (id_employee)
          REFERENCES employees(id_employee)
);
-- #########################################################################