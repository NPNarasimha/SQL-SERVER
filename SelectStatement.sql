--createing the database--
Create database Sql_Sarver_Queries;
--we can also alter the database name--
Alter database Sql_Sarver_Queries modify name =sqlserver_queries;
--using the database--
use Sql_Sarver_Queries;
--drop the database;
drop database Sql_Sarver_Queries;
--create the table 
create table Student(Std_Id int Identity(1,1) Primary key, Std_Name varchar(30) Not null,Std_Branch varchar(35),Marks int check(marks>35)); 
--delete the table into the database;
drop table Student;
--insert the multiple data into the student table.
insert into Student(Std_Name,Std_Branch,Marks)values('Krishna','CSE',85),('NP','ECE',75),('Narasimha','Mech',55),('Prakowsalya','Civil',80);
--insert the single data into the table;
insert into Student values('Kowsalya','CSE',38);
insert into Student values('Kowsalya NP','CSE',95);
--Retrive the data
select * from Student;
--Retrive the the specific column
select Std_Branch from Student;
-- WHERE clause to filter rows returned by a query.
select * from Student
where Marks >70 and Std_Branch='CSE';
--Using the WHERE clause to filter rows that meet any of two conditions
select * from Student
where Marks >70 or Std_Branch='CSE';
--Using the WHERE clause to filter rows with the value between two values
select * from Student
where Marks between 70 and 85;
--Using the WHERE clause to filter rows that have a value in a list of values
select * from Student
where Marks in (75,85);
--Finding rows whose values contain a string [% , _ ]
select * from Student
where Std_name like '%N_%';


