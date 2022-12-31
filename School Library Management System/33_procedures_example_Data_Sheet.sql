-- SELECT c.id_rental, c.employee_card_id, c.id_student,
--        (Select concat(s.last_name, s.first_name) AS full_name),
--        s.student_card_id, c.return_date
-- FROM completion_date AS c
-- LEFT JOIN students AS s ON c.id_student = s.id_student;

SELECT c.id_rental, c.employee_card_id, c.id_student,
       (Select concat(s.last_name, s.first_name) AS full_name),
       s.student_card_id, c.return_date
FROM completion_date AS c
LEFT JOIN students AS s ON c.id_student = s.id_student;