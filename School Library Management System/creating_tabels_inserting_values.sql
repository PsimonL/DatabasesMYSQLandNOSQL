-- #########################################################################
-- TABLE STUDENTS
CREATE TABLE students(
  id_student int PRIMARY KEY,
  full_name char(50),
  student_card_id int,
  email char(70),
  phone char(15)
);

INSERT INTO students VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM students;
-- DROP TABLE students;
-- #########################################################################


-- #########################################################################
-- TABLE BOOKS
CREATE TABLE books(
  id_book int PRIMARY KEY,
  title char(150),
  id_author int,
  isbn int,
  for_adults boolean,
  publication_year int,
  book_topic varchar(1000)
);

INSERT INTO books VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM books;
-- DROP TABLE books;
-- #########################################################################


-- #########################################################################
-- TABLE AUTHORS
CREATE TABLE authors(
  id_author int PRIMARY KEY,
  first_name char(10),
  last_name char(10)
);

INSERT INTO authors VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM authors;
-- DROP TABLE authors;
-- #########################################################################


-- #########################################################################
-- TABLE RENTALS
CREATE TABLE rentals(
  id_rental int PRIMARY KEY,
  id_student int,
  id_employee int
);

INSERT INTO rentals VALUES (1, 'Elizabeth Swann', 111);

SELECT * FROM rentals;
-- DROP TABLE rentals;
-- #########################################################################


-- #########################################################################
-- TABLE RENTALS
CREATE TABLE completion_date(
  id_rental int PRIMARY KEY,
  id_student int,
  id_employee int,
  rental_date date,
  return_date date
);

INSERT INTO completion_date VALUES (1, 'Elizabeth Swann', 111);

SELECT * FROM completion_date;
-- DROP TABLE completion_date;
-- #########################################################################


-- #########################################################################
-- TABLE STUDENTS
CREATE TABLE students(
  id_student int PRIMARY KEY,
  full_name char(50),
  student_card_id int,
  email char(70),
  phone int
);

INSERT INTO students VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM students;
-- DROP TABLE students;
-- #########################################################################


-- #########################################################################
-- TABLE STUDENTS
CREATE TABLE employees(
  id_employee int PRIMARY KEY,
  full_name char(50),
  employee_card_id int,
  email char(70),
  phone int
);

INSERT INTO employees VALUES (0, 'Jack Sparrow', 000);

SELECT * FROM employees;
-- DROP TABLE students;
-- #########################################################################