create database ProcedureDatabase;
use ProcedureDatabase;

create table student(id int primary key,name varchar(28),branch varchar(39),grade decimal);
INSERT INTO student (id, name, branch, grade) VALUES
(1, 'Rahul Sharma', 'Computer Science', 89.75),
(2, 'Aditi Verma', 'Electronics', 91.50),
(3, 'Vikram Singh', 'Mechanical', 85.25),
(4, 'Neha Gupta', 'Civil', 88.00),
(5, 'Aman Kumar', 'Information Technology', 92.30);


--Stored procedure creation ----
--create proc GetStudentDetails or--
CREATE PROCEDURE GetStudentDetails
as
begin 
select * from Student;
end;
--GetStudentDetails; or
--exec GetStudentDetails; or
execute GetStudentDetails;

--Modifying a stored procedure

alter Proc GetStudentDetails
as
begin
select * from Student order by grade desc;
end;
exec GetStudentDetails;

--Deleting a stored procedure
drop Proc GetStudentDetails;

--Creating a stored procedure with one parameter
create procedure FindStudent 
(@id int)
as
begin
select * from student where id=@id;
end;

exec FindStudent 3;
--modifying 
Alter procedure FindStudent 
(@id int)
as
begin
select name from student where id=@id;
end;

exec FindStudent 6;
--create the passing parameters
Alter procedure FindStudent 
(@ExpectGrade decimal)

as
begin
select * from student where grade>@ExpectGrade;
end;

FindStudent 90;

--insert data 
create procedure InsertStudent 
(
@id int,
@name varchar(29),
@branch varchar(39),
@grade decimal
)
as
begin
insert into student(id,name,branch,grade)values(@id,@name,@branch,@grade);
end;

InsertStudent 6,'Krishna','CSE',88;
InsertStudent @id=7,@name='Kowsalya',@branch='ECE',@grade=89;
--find name using like operator 
create proc FindStudentByName
(@studentName varchar(max))
as 
begin 
select * from student where name Like '%'+@studentName+'%';
end;

exec FindStudentByName'K';

--find name using like operator with default value. because while calling the proc we can't enter the name it while take default.
create proc FindStudentName
(@studentName varchar(max)='kri')
as 
begin 
select * from student where name Like '%'+@studentName+'%';
end;

exec FindStudentName ;
--because while calling the proc we can enter the name but default is present but it is use the user enter name.
create proc FindStudentdefaultName
(@studentName varchar(max)='kri')
as 
begin 
select * from student where name Like '%'+@studentName+'%';
end;

exec FindStudentdefaultName 'shar';
--variable declearation run at a time entire delcre to print or use select @totalStds.

declare @TotalStds int;
set @TotalStds=(
select count(id) from student
);
print @TotalStds



--output parameter
create proc adding
(@n1 int 
,@n2 int,
@res int output
)
as
begin 
set @res=@n1+@n2;
end;

declare @result int
exec adding 2,4,@result output;
select @result;