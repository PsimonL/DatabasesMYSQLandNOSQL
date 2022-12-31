SELECT s.id_book, s.quantity, q.id_book, q.quantity
FROM quantity_books AS q
RIGHT JOIN supply AS s ON s.id_book = q.id_book;


UPDATE quantity_books SET quantity = 10000
FROM supply_history
WHERE quantity_books.quantity = supply_history.quantity;
SELECT * FROM quantity_books;