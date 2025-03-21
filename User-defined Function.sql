
/*
-----------------------------------user-defined functions----------------------------------
--> It is a function created by the -user- to perform operations and return a result.

This are divide two ways 
1.scalar valued functions:-
						scalar function takes one or more parameters and returns a single value.

ex:-
*/
create function addNums(@n1 int,@n2 int)
returns int
as 
begin 
Declare @result int;
set @result =@n1+@n2;
return @result;
end;

select dbo.addNums(10,20) as adding;

--example 2 with using table
create table studentMarks(std_Id int primary key,Tel_marks int ,Eng_marks int ,Math_marks int);

INSERT INTO studentMarks (std_Id, Tel_marks, Eng_marks, Math_marks) VALUES
(1, 78, 85, 92),
(2, 88, 76, 90),
(3, 67, 80, 75),
(4, 92, 89, 96),
(5, 85, 84, 88);

create function Total_Marks(@Std_Id int )
returns int 
as
begin
declare @total int;
select @total= (Tel_marks+Eng_marks+Math_marks) from studentMarks where std_id=@std_id;
return @total;
end;

select *,dbo.Total_Marks(std_Id)as TotalMarks from studentMarks; 



/*

2.Table valued functions:-
						A table-valued function is a user-defined function that returns data of a table type.
						The return type of a table-valued function is a table,
						therefore, you can use the table-valued function just like you would use a table.
ex:-
*/

create function findStudent(@id int)
returns table
as
return 
select * from studentMarks where std_Id=@id;
--execute the query
select * from findStudent(2);
select *, dbo.Total_Marks(2) as Total from findStudent(2);

--modifying 
alter function findStudent(@id int)
returns table
as
return 
select std_Id from studentMarks where std_Id=@id;
--execute the query
select * from findStudent(2);
select *, dbo.Total_Marks(2) as Total from findStudent(2);

/*----------------------multi-valued tablefunction------------------------
A multi-statement table-valued function or MSTVF is a table-valued function that returns the result of multiple statements enclosed with bigin and end.

The multi-statement-table-valued function is very useful because you can execute multiple queries within the function and aggregate results into the returned table.

*/
create function studentMarksheet(@id int)
returns @markSheet table (std_id int ,tel_marks int,eng_marks int,Math_marks int,TotalMarks int) 
as
begin 
declare @Total int;
select @Total=(Tel_marks+eng_marks+Math_marks) from studentMarks where std_id=@id;

insert into @markSheet(std_id,Tel_marks,eng_marks,Math_marks,TotalMarks)
select @id,Tel_marks,eng_marks,Math_marks,@Total from StudentMarks where std_id=@id;
return
end;

select * from dbo.studentMarksheet(2);

