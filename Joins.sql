create table College(col_Id int Identity(1,1),col_Name varchar(20),Col_branch varChar(25));
insert into College(Col_Name,Col_branch)values('St Johns','CSE'),('JNTUA','ECE'),('St Johns','EEE%'),('Bheema','Civil'),('Bheema','CSE'),('JNTUA','Mech'),('Pullareddy','CSE'),('Pullareddy','ECE');
create table Course(C_Id int Identity(1,1),C_Name Varchar(25),Std_Id int);
insert into Course (C_Name,Std_Id)values('python',1),('Java',2),('C#',3),('C++',4),('C',5),('DOT NET',6),('MY SQL',7),('Sql',8);
select * from Course;
select * from Student;
select * from College;
--inner Join--
--It return the matching records from both tables.
select s.Std_Id,s.Std_Name,Course.C_Name from Student s
inner Join Course ON Course.Std_Id=s.Std_Id;

--Left join--
select s.Std_Id,c.Std_Id,s.Std_Name,c.C_Name from student s
Left Join Course c on c.C_Id= s.Std_Id;
--Right Join--
select s.Std_Id,c.Std_Id,s.Std_Name,c.C_Name from student s
Right Join Course c on c.C_Id= s.Std_Id;

--full JOin --
select s.Std_Id,c.Std_Id,s.Std_Name,c.C_Name from student s
full Join Course c on c.C_Id= s.Std_Id;

 ---self join --
select s.Std_Id,s1.Std_Name,s1.Std_Id from student s
 Join Student s1 on s1.Std_Id=s.Std_id;
--or
select s.Std_Id,s1.Std_Name,s1.Std_Id from student s
left Join Student s1 on s1.Std_Id=s.Std_id;
--or
select s.Std_Id,s1.Std_Name,s1.Std_Id from student s
inner Join Student s1 on s1.Std_Id=s.Std_id;

 --crose join --
 select s.Std_Id,s.Std_Name,c.C_Name from student s
cross Join Course c;
 


 ------------------------- Joins in 3 tables---------------------
 --inner Join in 3 tables--
select s.Std_Id,s.Std_Name,Course.C_Name ,col.col_Name from Student s
inner Join Course ON Course.Std_Id=s.Std_Id inner join College col on col.col_Id=s.Std_Id;

--Left join--
select s.Std_Id,s.Std_Name,c.C_Id,c.C_Name,col.Col_Name from student s
Left Join Course c on c.C_Id= s.Std_Id left join College col on col.col_Id=s.Std_Id;
--Right Join--
select s.Std_Id,s.Std_Name,c.C_Id,c.C_Name,col.Col_Name from student s
Right Join Course c on c.C_Id= s.Std_Id right join College col on col.col_Id=s.Std_Id;

--full JOin --
select  s.Std_Id,s.Std_Name,c.C_Id,c.C_Name,col.Col_Name from student s
full Join Course c on c.C_Id= s.Std_Id full join College col on col.col_Id=s.Std_Id;

--crose join --
 select s.Std_Id,s.Std_Name,c.C_Id,c.C_Name,col.Col_Name from student s
cross Join Course c cross join College col;
 


 ---------------------------------------joins in Advance---------------------------------------
 
 CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100),
    start_date DATE,
    end_date DATE,
	std_Id int,
	enroll_id int
);

select * from Student;
INSERT INTO Courses (course_id,course_name, instructor, start_date, end_date,std_Id,enroll_Id) VALUES
(1,'Data Structures', 'Dr. Smith', '2025-01-10', '2025-05-15',1,1),
(2,'Database Systems', 'Prof. Johnson', '2025-02-01', '2025-06-10',2,2),
(3,'Operating Systems', 'Dr. Williams', '2025-03-05', '2025-07-20',3,3);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    std_id INT,
    course_id INT,
    FOREIGN KEY (std_id) REFERENCES Student(std_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments (enrollment_id, std_id, course_id) VALUES
(1, 1, 1), 
(2, 1, 3), 
(3, 2, 2),
(4, 3, 1),
(5, 3, 2);

 CREATE TABLE Assignments (
    assignment_id INT PRIMARY KEY,
    course_id INT,
    title VARCHAR(100),
    due_date DATE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Assignments (assignment_id, course_id, title, due_date) VALUES
(1, 1, 'Assignment 1', '2024-01-15'),
(2, 2, 'Assignment 2', '2024-02-10'),
(3, 3, 'Midterm Project', '2024-03-01'),
(4, 3, 'Final Exam', '2024-04-20');
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    std_id INT,
    assignment_id INT,
    score DECIMAL(5, 2),
    FOREIGN KEY (std_id) REFERENCES Student(std_id),
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id)
);

INSERT INTO Grades (grade_id, std_id, assignment_id, score) VALUES
(1, 1, 1, 85.5),
(2, 2, 1, 90.0),
(3, 3, 2, 75.0),
(4, 1, 3, 88.0),
(5, 2, 4, 92.0);
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    course_id INT,
    name VARCHAR(50),
    email VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Instructors (instructor_id, course_id, name, email) VALUES
(1, 1, 'Dr. Smith', 'smith@example.com'),
(2, 2, 'Dr. Johnson', 'johnson@example.com'),
(3, 3, 'Dr. Lee', 'lee@example.com');
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    std_id INT,
    course_id INT,
    attendance_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (std_id) REFERENCES Student(std_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
select * from Attendance
INSERT INTO Attendance (attendance_id, std_id, course_id, attendance_date, status) VALUES
(1, 1, 1, '2024-01-10', 'Present'),
(2, 2, 1, '2024-01-10', 'Absent'),
(3, 3, 2, '2024-02-05', 'Present'),
(4, 1, 3, '2024-02-07', 'Absent'),
(5, 2, 3, '2024-02-07', 'Present');

--1) Retrieve a List of Students Along with the Names of Courses They Are Enrolled In
select s.Std_Id, s.Std_Name, c.course_name from Student s
inner join Enrollments e on e.std_id=s.std_Id
inner join courses c on c.enroll_id=e.enrollment_id ;

--2) List All Students and the Courses They Are Enrolled In, Including Students Not Enrolled in Any Course
select s.Std_Name,c.course_name from student s
left join Enrollments e on s.std_id=e.std_Id
left join Courses c on e.course_id=c.course_id;
--3) List All Courses and the Students Enrolled in Each Course, Including Courses with No Students
select s.Std_Name,c.course_name from courses c
left join Enrollments e on c.course_Id=e.course_id
left join student s on e.std_id=s.std_id;

 --4) Retrieve Each Student's Name Along with Their Course Name and Instructor’s Name
 select s.Std_name,c.Course_name,i.name from Student s
 inner join Enrollments e on e.std_id=s.Std_Id
 inner join Courses c on c.course_id = e.enrollment_Id
 inner join Instructors i on i.course_id=c.course_id;

 --6) Use LEFT JOIN to Find Students Who Are Not Enrolled in Any Course

select * from student s
left join Enrollments e on e.std_id = s.Std_Id
where e.course_id is null
--7) Use LEFT JOIN to Find Students Who Are Enrolled in Any Course

select * from student s
left join Enrollments e on e.std_id = s.Std_Id
where e.course_id is not null

--8) Retrieve the Title of Each Assignment Along with the Student’s Name and Their Score
select a.title ,s.std_name ,g.score from Assignments a
inner join Grades g on g.assignment_id=a.assignment_id
inner join Student s on s.Std_Id=g.grade_id;

--9) List Each Course Name, the Total Number of Enrolled Students, and the Instructor's Name

select c.course_Name,count(e.std_id) as total_stds ,i.name from courses c
left join Enrollments e on e.course_id=c.course_id
inner join Instructors i on i.course_id=c.course_id
group by c.course_name,i.name;

--10) Calculate the Average Attendance Rate for Each Course (Percentage of "Present" Status)
select c.course_Name,avg(case when a.status='present' then 1 else 0 end)*100 as attendence_Rate from Courses c
inner join Attendance a on a.course_id=c.course_id
group by c.course_name;
