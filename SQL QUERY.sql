-- Step 1: Create database
CREATE DATABASE college;

-- Step 2: Use the database
USE college;

-- Step 3: Create table named student
CREATE TABLE student (
    rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT,
    grade CHAR(1),
    city VARCHAR(50)
);

INSERT INTO student (rollno, name, marks, grade, city)
VALUES
    (101, 'anil', 78, 'C', 'Pune'),
    (102, 'bhumika', 93, 'A', 'Mumbai'),
    (103, 'chetan', 85, 'B', 'Mumbai'),
    (104, 'dhruv', 96, 'A', 'Delhi'),
    (105, 'emanuel', 12, 'F', 'Delhi'),
    (106, 'farah', 82, 'B', 'Delhi');

select * from student;
--
SELECT * FROM STUDENT WHERE MARKS > 80;


SELECT GRADE, COUNT(ROLLNO)
FROM STUDENT 
GROUP BY GRADE; 

SELECT CITY, COUNT(ROLLNO)
FROM STUDENT
GROUP BY CITY
HAVING MAX(MARKS) > 90;

UPDATE STUDENT
SET GRADE = "O"
WHERE GRADE = "A";

-- TO OFF SAFE MODE WHERE YOU CAN UPDATE

SET SQL_SAFE_UPDATES = 0;
 
 -- TO ON SAFE MODE WHERE YOU PREVENT DATA OF DATABASE

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM student;

--------------------------

alter table student
add column class varchar(10); 

alter table student
modify age varchar(2);

alter table student 
change age stu_age int;

alter table student
rename to stu;

alter table stu
rename to student;

alter table student 
drop column class;

truncate  table student;

-- INNER JOIN

CREATE TABLE stu(
 id INT PRIMARY KEY,
 name VARCHAR(50)
);

INSERT INTO stu (id, name)
VALUES
(101, 'adam'),
(102, 'bob'),
(103, 'casey');

CREATE TABLE course(
 id INT PRIMARY KEY,
 course VARCHAR(50)
);

INSERT INTO course (id, course)
VALUES
(102, 'english'),
(105, 'math'),
(103, 'science'),
(107, 'computer science');

select * from stu;

select * from course;

select * from stu as s
inner join course as c
on stu.id = course.id;

/* stu as s and course as c is aliases 
last line can be on s.id = c.id; */

-- LEFT JOIN

select * from stu
left join course
on stu.id = course.id;

-- right JOIN

select * from stu
right join course
on stu.id = course.id;

-- Full JOIN

select * from stu
left join course
on stu.id = course.id
UNION
select * from stu
right join course
on stu.id = course.id;

-- LEFT EXCLUSIVE JOIN mtlb keval A table ka data chahiye jo B table ke sath overlap na kr raha ho.

select * from stu
left join course
on stu.id = course.id
WHERE COURSE.ID IS NULL;

-- RIGHT EXCLUSIVE JOIN

select * from stu
right join course
on stu.id = course.id
WHERE STU.ID IS NULL;


-- FULL EXCLUSIVE JOIN

select * from stu
left join course
on stu.id = course.id
UNION
select * from stu
right join course
on stu.id = course.id
WHERE stu.id = course.id IS NULL;

-- SELF JOIN

create table employee(
id int primary key,
name varchar(50),
manager_id int
);

Insert into employee(id, name, manager_id)
values
(101, "adam", 103),
(102, "bob", 104),
(103, "casey", null),
(104, "donald", 103);


SELECT a.name as manager_name, b.name
FROM employee AS a
JOIN employee AS b
ON a.id = b.manager_id;


-- UNION - ye unique value deta hai 



select name from employee
UNION
select name from employee;

-- UNION ALL - ye duplicate value deta hai mtlb sari ki sari value de deta hai

select name from employee
UNION ALL
select name from employee;

-- SQL SUB QUERY

CREATE TABLE studentss (
    rollno INT ,
    name VARCHAR(50),
    marks INT,
    grade CHAR(1),
    city VARCHAR(50)
);

INSERT INTO studentss (rollno, name, marks, grade, city)
VALUES
    (101, 'anil', 78, 'C', 'Pune'),
    (102, 'bhumika', 93, 'A', 'Mumbai'),
    (103, 'chetan', 85, 'B', 'Mumbai'),
    (104, 'dhruv', 96, 'A', 'Delhi'),
    (105, 'emanuel', 12, 'F', 'Delhi'),
    (106, 'farah', 82, 'B', 'Delhi');
    
/* 
Ques: get names of al the students who scored more than class average.

step1. find the avg of class
step2. find the names of students with marks > avg

*/    

-- METHOD 1

select avg(marks)
from studentss;
    
select name 
from studentss
where marks > 74.3333;

-- METHOD 2 isme yadi table ka data change hota hai ye automatically change hoti jayegi

select name 
from studentss
where marks > (select avg(marks) from studentss);

/* 
Ques2: Find the names of all students with even roll numbers.
Step 1. Find the even roll numbers
Step 2. Find the names of students with even roll no
*/

-- METHOD 1

select rollno
from studentss where rollno % 2 = 0;

select name, rollno from studentss
where rollno IN ( 102, 104, 106);

-- METHOD2 

select name, rollno from studentss
where rollno IN ( select rollno
from studentss where rollno % 2 = 0 );

/*
Example with FROM
Find the max marks from the students of Delhi
Step 1. Find the students of Delhi
Step 2. Find their max marks using the sublist in step 1
*/

select max(marks)
FROM (select * 
from studentss
where city = "Delhi") as temp;

-- as temp is alias which is mandatory to use

# Normal Method

select max(marks)
from studentss
where city = "Delhi";

/*
Example with SELECT
*/

SELECT 
    (SELECT MAX(marks) FROM studentss) AS max_marks,
    name
FROM studentss;


# MYSQL VIEWS

create view view1 as
select rollno, name, marks 
from studentss;

select * from view1;


select * from view1
where marks > 90;

Drop View view1;