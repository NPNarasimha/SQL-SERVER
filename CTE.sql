-------------------------CTE--------------

/*
-->A CTE allows you to define a temporary named result set that available temporarily in the execution scope of a statement such as SELECT, INSERT, UPDATE, DELETE, or MERGE.
-->A Common Table Expression (CTE) is like a named subquery. It functions as a virtual table that only its main query can access.
--> Each SQL CTE is like a named query
==>syntax--
		WITH expression_name[(column_name [,...])]
		AS
			(CTE_definition)
		SQL_statement;
*/
--example:-
select * from students;
with FindGrades as(
select *  from students where std_Grade='A+'
)
select * from FindGrades where std_DOB>='2002-02-12';

with findStudents(std_id,std_name,std_Grade)
as(
select std_id,std_name,std_grade from students where std_Grade='A+'
)
select std_id,Std_name from findStudents where std_id>2;

----insert data
with insertStudent
as(
select * from students
)

insert insertStudent values(1,'vali','2nd','2003-2-22','C+')


----update---
with updateStudent
as(
select * from students
)
update updateStudent set std_Id=10,std_Name='raj' where std_Grade='c+';

------delete--
with deleteStudent
as(
select * from students
)
delete deleteStudent  where std_Grade='c+';

--------------------Multiple CTE tables ----------------------
with CTE1findStd
as
(select * from students where std_Grade='A+')
,
CTE2findStd
as(select * from students where std_Grade='A')
select * from CTE1findStd
union all 
select * from CTE2findStd
