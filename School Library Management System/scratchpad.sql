-- CREATE TABLE customers(
--    customer_id INT GENERATED ALWAYS AS IDENTITY,
--    customer_first_name VARCHAR(255) NOT NULL,
--    customer_last_name VARCHAR(255) NOT NULL,
--    email VARCHAR(255) NOT NULL,
--    PRIMARY KEY(customer_id)
-- );
-- DROP TABLE customers CASCADE;
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

-- CREATE VIEW some_view AS
-- SELECT split_part(lower(customer_first_name), ' ', 1) AS first_name
--      , split_part(lower(customer_first_name), ' ', 2) AS second_name
-- FROM   customers;
-- -- SELECT unnest(
-- --   string_to_array(customers.customer_name, ' ')
-- -- ) AS parts FROM customers;
--
-- SELECT * FROM some_view;
-- --
-- -- DROP VIEW some_view;


CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_first_name VARCHAR(255) NOT NULL,
   customer_last_name VARCHAR(255) NOT NULL,
   email VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);


CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),

   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id)
	  REFERENCES customers(customer_id)
);

CREATE OR REPLACE FUNCTION trigger_function_contacts()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $trigger$
    BEGIN
        INSERT INTO contacts VALUES (default, 1, 'Szymon Rogowski', 111222333, 'szymon_rogowski@gmail.com');
        RETURN NEW;
    END
$trigger$;

CREATE TRIGGER trigger_contacts
   AFTER INSERT
   ON customers
   FOR EACH ROW
       EXECUTE PROCEDURE trigger_function_contacts();
-- INSERT INTO customers VALUES(default, 'Szymon', 'Rogowski', 'szymon_rogowski@gmail.com');

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
SELECT * FROM contacts;