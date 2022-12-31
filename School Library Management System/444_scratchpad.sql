CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_first_name VARCHAR(255) NOT NULL,
   customer_last_name VARCHAR(255) NOT NULL,
   email VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);
DROP TABLE customers CASCADE;

CREATE OR REPLACE PROCEDURE insert_vals_customers(
  customer_first_name VARCHAR(255),
     customer_last_name VARCHAR(255))
LANGUAGE plpgsql
AS $procedure$
    BEGIN
        if customer_last_name LIKE 'Rogowski' then
            INSERT INTO customers VALUES (default, customer_first_name, customer_last_name, (Select concat(lower(customer_first_name), '_', lower(customer_last_name), '@gmail.com')));
        elsif customer_last_name LIKE 'HDASD' then
            raise notice 'Sth.';
        else
		    raise notice 'Domain not found.';
		end if;
	raise notice 'Last %, first %.', customer_last_name, customer_first_name;
    END
$procedure$;

CALL insert_vals_customers('Szymon', 'Rogowski');

SELECT * FROM customers;

CREATE VIEW some_view AS
SELECT split_part(lower(customer_first_name), ' ', 1) AS first_name
     , split_part(lower(customer_first_name), ' ', 2) AS second_name
FROM   customers;
-- SELECT unnest(
--   string_to_array(customers.customer_name, ' ')
-- ) AS parts FROM customers;

SELECT * FROM some_view;
--
-- DROP VIEW some_view;

-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################
-- CREATE TABLE customers(
--    customer_id INT GENERATED ALWAYS AS IDENTITY,
--    customer_first_name VARCHAR(255) NOT NULL,
--    customer_last_name VARCHAR(255) NOT NULL,
--    email VARCHAR(255) NOT NULL,
--    PRIMARY KEY(customer_id)
-- );
--
--
-- CREATE TABLE contacts(
--    contact_id INT GENERATED ALWAYS AS IDENTITY,
--    customer_id INT,
--    contact_name VARCHAR(255) NOT NULL,
--    phone VARCHAR(15),
--    email VARCHAR(100),
--    PRIMARY KEY(contact_id),
--
--    CONSTRAINT fk_customer
--       FOREIGN KEY(customer_id)
-- 	  REFERENCES customers(customer_id)
-- );
--
-- CREATE OR REPLACE FUNCTION trigger_function_contacts()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $trigger$
--     BEGIN
--         INSERT INTO contacts VALUES (default, 1, 'Szymon Rogowski', 111222333, 'szymon_rogowski@gmail.com');
--         RETURN NEW;
--     END
-- $trigger$;
--
-- CREATE TRIGGER trigger_contacts
--    AFTER INSERT
--    ON customers
--    FOR EACH ROW
--        EXECUTE PROCEDURE trigger_function_contacts();
-- -- INSERT INTO customers VALUES(default, 'Szymon', 'Rogowski', 'szymon_rogowski@gmail.com');
--
-- CREATE OR REPLACE PROCEDURE insert_vals_customers(
--   customer_first_name VARCHAR(255),
--      customer_last_name VARCHAR(255))
-- LANGUAGE plpgsql
-- AS $procedure$
--     BEGIN
--         if customer_last_name LIKE 'Rogowski' then
--             INSERT INTO customers VALUES (default, customer_first_name, customer_last_name, (Select concat(lower(customer_first_name), '_', lower(customer_last_name), '@gmail.com')));
--         elsif customer_last_name LIKE 'HDASD' then
--             raise notice 'Sth.';
--         else
-- 		    raise notice 'Domain not found.';
-- 		end if;
-- 	raise notice 'Last %, first %.', customer_last_name, customer_first_name;
--     END
-- $procedure$;
--
-- CALL insert_vals_customers('Szymon', 'Rogowski');
--
-- SELECT * FROM customers;
-- SELECT * FROM contacts;

-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################

-- CREATE TABLE customers(
--    customer_id INT GENERATED ALWAYS AS IDENTITY,
--    customer_first_name VARCHAR(255) NOT NULL,
--    customer_last_name VARCHAR(255) NOT NULL,
--    PRIMARY KEY(customer_id)
-- );
-- INSERT INTO customers VALUES(default, 'aaa', 'aaaaa');
-- INSERT INTO customers VALUES(default, 'bbbb', 'bbbb');
-- INSERT INTO customers VALUES(default, 'ccccc', 'cccc');
--
-- SELECT * FROM customers;
--
-- SELECT max(customer_id) FROM customers;
--
-- ALTER TABLE customers ADD date date;
--
-- SELECT * FROM customers;
--
-- INSERT INTO customers VALUES(default, 'dddd', 'dddd', '2022-01-10');
--
-- SELECT * FROM customers;
--
-- DROP TABLE customers;


-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################
-- CREATE TABLE lol
-- AS (
--   SELECT *
--   FROM Customers
--   WHERE country = 'USA'
-- );
--
--
--
--     SELECT split_part(col, ',', 1) AS col1
--      , split_part(col, ',', 2) AS col2;
-- SELECT * FROM lol;
-- SELECT parts FROM lol WHERE id = 1;
--
-- DROP TABLE lol CASCADE;
-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################
DROP PROCEDURE IF EXISTS proccedure();
CREATE OR REPLACE PROCEDURE proccedure(
    author_name varchar(60)
  )
LANGUAGE plpgsql
AS $procedure$
    DECLARE
        name_2nd varchar(30);
    BEGIN
       SELECT SPLIT_PART(author_name, ' ', 2) INTO name_2nd;

--         INSERT INTO books VALUES (default, title, (Select id_author From authors Where last_name = l_name),
--                                   isbn, for_adults, publication_year, genre);
    END;
$procedure$;

-- CALL proccedure('Roman Godday');
-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################
DROP PROCEDURE IF EXISTS func();
DROP FUNCTION IF EXISTS func();
CREATE OR REPLACE FUNCTION func(
    author_name varchar(60)
  )
    RETURNS varchar
LANGUAGE plpgsql
AS $procedure$
    DECLARE
        name_2nd varchar(30);
    BEGIN
       SELECT SPLIT_PART(author_name, ' ', 2) INTO name_2nd;
       RETURN name_2nd;
--         INSERT INTO books VALUES (default, title, (Select id_author From authors Where last_name = l_name),
--                                   isbn, for_adults, publication_year, genre);
    END;
$procedure$;

-- CALL proccedure('Roman Godday');

select func('Roman Godday');

-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################

-- https://www.cybertec-postgresql.com/en/what-to-return-from-a-postgresql-row-level-trigger/

CREATE TABLE mytab (
   id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
   val text
);

CREATE TABLE mytab_hist (
   mod_time timestamp with time zone
      DEFAULT clock_timestamp() NOT NULL,
   operation text NOT NULL,
   id bigint NOT NULL,
   val text,
   PRIMARY KEY (id, mod_time)
);


CREATE FUNCTION mytab_hist() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
   IF TG_OP = 'DELETE' THEN
      INSERT INTO mytab_hist (operation, id, val)
         VALUES (TG_OP, OLD.id, NULL);

      RETURN OLD;
   ELSE
      INSERT INTO mytab_hist (operation, id, val)
         VALUES (TG_OP, NEW.id, NEW.val);

      RETURN NEW;
   END IF;
END;$$;

CREATE TRIGGER mytab_hist
   BEFORE INSERT OR UPDATE OR DELETE ON mytab FOR EACH ROW
   EXECUTE FUNCTION mytab_hist();

INSERT INTO mytab VALUES (default, 'AAAAAAAAA');

SELECT * FROM mytab;
SELECT * FROM mytab_hist;



-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################

DROP TABLE IF EXISTS tabA CASCADE;
CREATE TABLE  IF NOT EXISTS  tabA(
    id int GENERATED ALWAYS AS IDENTITY,
    val1 int,
    val2 int
);

DROP TABLE IF EXISTS tabB CASCADE;
CREATE TABLE  IF NOT EXISTS  tabB(
    id int GENERATED ALWAYS AS IDENTITY,
    sum int
);

DROP FUNCTION IF EXISTS exmaple_function_trigger() CASCADE;
CREATE FUNCTION exmaple_function_trigger() RETURNS trigger
   LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO tabB (id, sum) VALUES (default, NEW.val1 + NEW.val2);
   RETURN NEW;
END;$$;

DROP TRIGGER IF EXISTS example_trigger ON tabA;
CREATE TRIGGER example_trigger
AFTER INSERT ON tabA
    FOR EACH ROW
        EXECUTE  FUNCTION exmaple_function_trigger();


INSERT INTO tabA VALUES (default, 1, 2);
INSERT INTO tabA VALUES (default, 10, 20);
INSERT INTO tabA VALUES (default, 100, 200);

SELECT * FROM tabA;
SELECT * FROM tabB;

-- Working trigger


-- ######################################################################################################################################
-- ######################################################################################################################################
-- ######################################################################################################################################


DROP TABLE IF EXISTS students CASCADE;
CREATE TABLE  IF NOT EXISTS  students(
  id_student int GENERATED ALWAYS AS IDENTITY,
  first_name char (20),
  last_name char (25),
  student_card_id int UNIQUE,
  email char(70), -- every email adress MUST contain @     CHECK(email LIKE '%@%')
  phone int,

  PRIMARY KEY (id_student)
);
ALTER TABLE students ADD CONSTRAINT first_name CHECK(first_name ~* '[A-Za-z]');
ALTER TABLE students ADD CONSTRAINT last_name CHECK(last_name ~* '[A-Za-z]');
ALTER TABLE students ADD CONSTRAINT email CHECK(email NOT LIKE '%uniNameS.com');
ALTER TABLE students ADD CONSTRAINT phone CHECK(phone >= 111111111 AND phone <= 999999999);

INSERT INTO students VALUES (default, 'James', 'Smith', 123, 'james_smith@uniNameS.com', 222222222);

SELECT * FROM students;

-----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS product_segment CASCADE;
CREATE TABLE product_segment (
    id SERIAL PRIMARY KEY,
    segment VARCHAR NOT NULL,
    discount NUMERIC (4, 2)
);
INSERT INTO
    product_segment (segment, discount)
VALUES
    ('Grand Luxury', 0.05),
    ('Luxury', 0.06),
    ('Mass', 0.1);


DROP TABLE IF EXISTS product CASCADE;
CREATE TABLE product(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    price NUMERIC(10,2),
    net_price NUMERIC(10,2),
    segment_id INT NOT NULL,
    FOREIGN KEY(segment_id) REFERENCES product_segment(id)
);
INSERT INTO
    product (name, price, segment_id)
VALUES
    ('diam', 804.89, 1),
    ('vestibulum aliquet', 228.55, 3),
    ('lacinia erat', 366.45, 2),
    ('scelerisque quam turpis', 145.33, 3),
    ('justo lacinia', 551.77, 2),
    ('ultrices mattis odio', 261.58, 3),
    ('hendrerit', 519.62, 2),
    ('in hac habitasse', 843.31, 1),
    ('orci eget orci', 254.18, 3),
    ('pellentesque', 427.78, 2),
    ('sit amet nunc', 936.29, 1),
    ('sed vestibulum', 910.34, 1),
    ('turpis eget', 208.33, 3),
    ('cursus vestibulum', 985.45, 1),
    ('orci nullam', 841.26, 1),
    ('est quam pharetra', 896.38, 1),
    ('posuere', 575.74, 2),
    ('ligula', 530.64, 2),
    ('convallis', 892.43, 1),
    ('nulla elit ac', 161.71, 3);

SELECT * FROM product;
SELECT * FROM product_segment;

UPDATE product
SET net_price = price - price * discount
FROM product_segment
WHERE product.segment_id = product_segment.id;

SELECT * FROM product;