-- #########################################################################
-- TABLE STUDENTS
CREATE TABLE students(
  id_student SERIAL,
  full_name char(50),
  student_card_id int,
  email char(70),
  phone char(15),

  PRIMARY KEY (id_student)
);

INSERT INTO students VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM students;
-- DROP TABLE students;
-- #########################################################################


-- #########################################################################
-- TABLE BOOKS
CREATE TABLE books(
  id_book SERIAL,
  title char(150),
  id_author int ,
  isbn int,
  for_adults boolean,
  publication_year int,
  book_topic varchar(1000),

  PRIMARY KEY (id_book),
  FOREIGN KEY (id_author) REFERENCES authors(id_author)
);

INSERT INTO books VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM books;
-- DROP TABLE books;
-- #########################################################################


-- #########################################################################
-- TABLE AUTHORS
CREATE TABLE authors(
  id_author SERIAL,
  first_name char(10),
  last_name char(10),

  PRIMARY KEY (id_author)
);

INSERT INTO authors VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM authors;
-- DROP TABLE authors;
-- #########################################################################


-- #########################################################################
-- TABLE RENTALS
CREATE TABLE rentals(
  id_rental SERIAL,
  id_student int NOT NULL,
  id_employee int NOT NULL ,

  PRIMARY KEY (id_rental),
  FOREIGN KEY (id_student) REFERENCES students(id_student),
  FOREIGN KEY (id_employee) REFERENCES employees(id_employee)
);

INSERT INTO rentals VALUES (1, 'Elizabeth Swann', 111);

SELECT * FROM rentals;
-- DROP TABLE rentals;
-- #########################################################################


-- #########################################################################
-- TABLE RENTALS
CREATE TABLE completion_date(
  id_completion SERIAL,
  id_rental int NOT NULL,
  id_student int NOT NULL,
  id_employee int NOT NULL,
  rental_date date,
  return_date date,

  PRIMARY KEY (id_completion),
  FOREIGN KEY (id_rental) REFERENCES rentals(id_rental),
  FOREIGN KEY (id_student) REFERENCES students(id_student),
  FOREIGN KEY (id_employee) REFERENCES employees(id_employee)
);

INSERT INTO completion_date VALUES (1, 'Elizabeth Swann', 111);

SELECT * FROM completion_date;
-- DROP TABLE completion_date;
-- #########################################################################


-- #########################################################################
-- TABLE STUDENTS
CREATE TABLE employees(
  id_employee SERIAL,
  full_name char(50),
  employee_card_id int,
  email char(70),
  phone int,

  PRIMARY KEY (id_employee)
);

INSERT INTO employees VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM employees;
-- DROP TABLE students;
-- #########################################################################