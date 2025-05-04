create database SISDB;
use SISDB;

CREATE table Students
(
student_id int auto_increment primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
dob date not null ,
email varchar(50) not null,
phone_num varchar(12) not null
);
CREATE table Teachers
(
teacher_id int auto_increment primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
email varchar(30) not null
);
CREATE table Courses
(
course_id int auto_increment primary key,
course_name varchar(30) not null,
credits int,
teacher_id int,
constraint fk_teacher foreign key(teacher_id) references Teachers(teacher_id) on delete cascade
);
CREATE table Enrollments
(
enrollment_id int auto_increment primary key,
student_id int,
course_id int,
enrollment_date date,
constraint fk_student foreign key (student_id) references Students(student_id) on delete cascade,
constraint fk_course foreign key(course_id) references Courses(course_id) on delete cascade
);
CREATE table Payments
(
payment_id int auto_increment primary key,
student_id int,
amount int,
payment_date date,
constraint fk_studentpay foreign key (student_id) references Students(student_id) on delete cascade
);

INSERT into Students (first_name, last_name, dob, email, phone_num)
VALUES
('Alice', 'Johnson', '2000-05-15', 'alice.johnson@example.com', '9876543210'),
('Bob', 'Smith', '1999-08-21', 'bob.smith@example.com', '8765432109'),
('Charlie', 'Brown', '2001-12-03', 'charlie.brown@example.com', '7654321098'),
('David', 'Wilson', '2002-07-19', 'david.wilson@example.com', '6543210987'),
('Emma', 'Davis', '1998-03-27', 'emma.davis@example.com', '5432109876');

INSERT into Teachers (first_name, last_name, email) 
VALUES
('John', 'Doe', 'john.doe@example.com'),
('Sarah', 'White', 'sarah.white@example.com'),
('Michael', 'Green', 'michael.green@example.com'),
('Emily', 'Taylor', 'emily.taylor@example.com'),
('Robert', 'Brown', 'robert.brown@example.com');

INSERT into Courses (course_name, credits, teacher_id) 
VALUES
('Mathematics', 4, 1),
('Computer Science', 3, 2),
('Physics', 4, 3),
('English Literature', 2, 4),
('History', 3, 5);

INSERT into Enrollments (student_id, course_id, enrollment_date) 
VALUES
(1, 1, '2025-01-10'),
(2, 2, '2025-02-15'),
(3, 3, '2025-03-20'),
(4, 4, '2025-04-25'),
(5, 5, '2025-05-30');

INSERT into Payments (student_id, amount, payment_date) 
VALUES
(1, 1000, '2025-02-05'),
(2, 1200, '2025-03-10'),
(3, 1500, '2025-04-15'),
(4, 1300, '2025-05-20'),
(5, 1100, '2025-06-25');

SELECT * from Students;
SELECT * from Teachers;
SELECT * from Courses;
SELECT * from Enrollments;
SELECT * from Payments;
 -- =============Task2===============
 INSERT into Students (first_name,last_name,dob,email,phone_num)
 values ("Sai","Ram","2003-06-06","saisiri@gmail.com","1234567899");
 
 INSERT into Enrollments (student_id,course_id,enrollment_date)
 values ("1","2","2024-04-30");
 
 UPDATE Teachers
 set email = "taylor@gmail.com"
 where teacher_id = 4;

DELETE from Enrollments
where student_id = 1 and course_id = 2;

UPDATE Courses
set teacher_id = 3
where course_id = 2;

DELETE from Students where student_id = 4;

UPDATE Payments
set amount = 2000
where payment_id = 3;







