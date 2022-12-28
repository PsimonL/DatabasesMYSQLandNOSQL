CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

INSERT INTO customers VALUES (default, 'aaa');
INSERT INTO customers VALUES (default, 'bbb');
INSERT INTO customers VALUES (default, 'ccc');

SELECT * FROM customers;


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

INSERT INTO contacts VALUES (default, (select customer_id from customers where customer_name = 'aaa'), 'ddd', '112233', 'mail1@gmail.com');
INSERT INTO contacts VALUES (default, (select customer_id from customers where customer_name = 'bbb'), 'eee', '445566', 'mail2@gmail.com');
INSERT INTO contacts VALUES (default, (select customer_id from customers where customer_name = 'ccc'), 'fff', '778899', 'mail3@gmail.com');

SELECT * FROM contacts;