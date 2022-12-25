CREATE TABLE example(
  id int PRIMARY KEY,
  name varchar(255),
  number int
);

INSERT INTO example VALUES (0, 'Jack Sparrow', 000);
INSERT INTO example VALUES (1, 'Elizabeth Swann', 111);
INSERT INTO example VALUES (2, 'Will Turner', 222);

SELECT * FROM example;