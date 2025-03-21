/*
-----------------------------VIEWS-------------------------------------
Definition:-
-->A view is created using the CREATE VIEW statement and retrieves data from one or more tables using a SELECT query.
-->A view is a virtual table that is based on the result of a SQL query. It does not store data physically but provides a way to simplify complex queries, enhance security.

*/
create view VWEmployee
as
select * from Employee

select * from VWEmployee;
--modifing
Alter view VWEmployee
as
select * from Employee where Emp_Salary>26000;

select * from VWEmployee;

--delete view
drop view IF EXISTS VWEmployee

------------------------provide security-------------

create view vwStudent 
as 
select * from Student

select * from vwStudent

ALTER TABLE student ADD Std_kjdck int;
ALTER TABLE student drop column Std_kjdck ;


--===========================security ==with schemaBinding==------------------
alter view vwStudent1
with schemaBinding--security
as 
select std_id,std_Name,Std_kjdck from dbo.Student

ALTER TABLE student ADD Std_kjdck int;
ALTER TABLE student drop column Std_kjdck ;

select * from vwStudent1


------=================rowlevel security----
create view VWRowlevel
as
select * from student where Std_Id>5;

select* from VWRowlevel;


------=================Column level security----
create view VWCollevel
as
select Std_Id,Std_Name from student;

select* from VWCollevel;

-----------------check option 
create view vwInsertstd
as
select * from students where Std_Name='Krishna'--name compalsary in krishna
WIth check option

insert into vwInsertstd(Std_Id,Std_Name,std_Class,std_DOB,std_Grade) values (12,'Krishna','1st','11-12-2003','B+');
select* from students;