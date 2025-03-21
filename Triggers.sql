/*-----------------------------Triggers-----------------------

Def:-
Triggers are special stored procedures that are executed automatically in response to the database object, database, and server events.

----------------------------The triggers provides three types:
1.Data manipulation language (DML):- This triggers which are invoked automatically in response to INSERT, UPDATE, and DELETE events against tables.
		==>This are AFTER/FOR triggers both are same.
				-->This are executed after the actions of insert ,update,merge and delete statement is performed.
		==>instead of 
				-->this are override the standard actions of the triggers statement.


2.Data definition language (DDL):-   This triggers which fire in response to CREATE, ALTER, and DROP statements. DDL triggers also fire in response to some system stored procedures that perform DDL-like operations.
		==>These events created normally starts with one of the following keywords CREATE, ALTER, DROP, GRANT, DENY, REVOKE, or UPDATE STATISTICS.
		The DDL triggers are useful in the following cases:
			--Record changes in the database schema.
			--Prevent some specific changes to the database schema.
			--Respond to a change in the database schema.
			===========syntax---------
			create or alter triger name
			on database or all servers
			with ddl triger options
			for (event_type)
			event group
			as sql_statement

3.Logon triggers which fire in response to LOGON events.

--------------Steps to crate a triggers
1.create a table for logging details.
2.Creating an after DML trigger.
3.Testing the trigger.


===============SYNTAX================
create [or] Alter Trigger trigger_name
on {table,view}
with <options>[...,n]
{for |After | instead of} {[insert][,][update][,]delete]}
not for replication
as
begin 
sql statements
end
with encription.

*/
use sqlserver_queries;
-----------------------INSERTING DATA-----------------
---1.create a table for logging details.
create table studentLog
(logId int identity(1,1),
Std_Id int
,std_name varchar(25)
,operation varchar(20),
creationTime datetime
)

-->Deleting Records from the Log Table
delete from studentLog where logId=7;
--drop table studentLog

--------2.Creating an after DML trigger.

create trigger insertStdDetails
on Students 
after insert
as
begin 
insert into studentLog(Std_Id,std_name,operation,creationTime)
select i.std_Id,i.std_Name,'inserted',GETDATE() from inserted i
end


---3.Testing the trigger.
select * from students;

insert into students values(10,'NP','5th','11-12-2002','A+');

select * from studentLog;

-->you set the SET NOCOUNT to ON to suppress the number of rows affected messages from being returned whenever the trigger is fired.

alter trigger insertStdDetails
on Students 
after insert
as
begin 
---it no tshowing the  i row effected when insert the data if their is no then they showing two '1 row effects' we can use only one showing 
set nocount on;
insert into studentLog(Std_Id,std_name,operation,creationTime)
select i.std_Id,i.std_Name,'inserted',GETDATE() from inserted i
end

insert into students values(11,'NPKrishna','6th','10-12-2002','B+');
select * from studentLog;
-------------------------update
create trigger UpdateStdDetails
on Students 
after update
as
begin 
---it no tshowing the  i row effected when insert the data if their is no then they showing two '1 row effects' we can use only one showing 
set nocount on;
insert into studentLog(Std_Id,std_name,operation,creationTime)
select i.std_Id,i.std_Name,'updated',GETDATE() from inserted i
end

update students set std_Class='10th' where std_Id=10;
select * from studentLog;
select * from students;

------------------DELETE---
create trigger DeleteStdDetails
on Students 
after delete
as
begin 
---it no tshowing the  i row effected when insert the data if their is no then they showing two '1 row effects' we can use only one showing 
set nocount on;
insert into studentLog(Std_Id,std_name,operation,creationTime)
select d.std_Id,d.std_Name,'Delete',GETDATE() from deleted d
end

delete  from students where std_Id=11;
select * from studentLog;
select * from students;

--======================================================================================================================================================
---Ex 2:-
select * from Employee;

create table EmployeeLogs(
Log_id int identity(1,1),
emp_Id int,
Emp_Name varchar(25),
Operations varchar(20),
CreationDate datetime)

alter trigger InsertEmpData
on Employee
After insert
as
begin 

declare @Emp_salary int

select @Emp_salary=i.Emp_Salary from inserted i;
--salry must greater then 20000;
if @Emp_salary>20000
begin
	print'data inserted successfully'
	insert into employeeLogs(emp_Id,Emp_Name ,Operations ,CreationDate )
	select i.Emp_Id,i.Emp_Name,'inserted',GETDATE() from inserted i
end
else
begin 
	print'data not inserted successfully '+cast(@Emp_salary as varchar(20))
	rollback
end
end

Insert into Employee values(6,'NP','IT Recruter',200000);
select * from EmployeeLogs;
select * from Employee;

--==============================update============================--

alter trigger UpdateEmpData
on Employee
After update
as
begin 
set nocount on;
declare @Emp_salary int
select @Emp_salary=i.Emp_Salary from inserted i;

if update(Emp_salary)
begin
	print'data updated successfully'
	insert into employeeLogs(emp_Id,Emp_Name ,Operations ,CreationDate )
	select i.Emp_Id,i.Emp_Name,'updated',GETDATE() from inserted i
end
else
begin 
	print'data not updated successfully '+cast(@Emp_salary as varchar(20))
	rollback
end
end

update Employee set Emp_salary=230000 where Emp_id=1;
select * from EmployeeLogs;
select * from Employee;


-------------------------------============================delete-----------------------

create trigger DeleteEmpData
on Employee
After delete
as
begin 
set nocount on;
insert into employeeLogs(emp_Id,Emp_Name ,Operations ,CreationDate )
select i.Emp_Id,i.Emp_Name,'deleted',GETDATE() from deleted i
end
delete from Employee where Emp_id=5;
select * from EmployeeLogs;
select * from Employee;


--==================================================DDL TRIGERS
--==>DDL_TABLE_EVENTS--for all create or drop or alter
--==>Create_table prvent the create table
--==>alter_table prvent the alter table
--==>drop_table prvent the drop table
create trigger createtable
on database
for create_table
as
begin 
print 'you cannot create a table in this database'
rollback transaction
end

create table s (id int)--//database canot create a table
drop table s;
create trigger PrventTables
on database
for alter_table,drop_table
as
begin 
print 'you cannot aletr or delete a table in this database'
rollback transaction
end
drop table s;
----------------ALL SERVER 
--it is in all database in server
create trigger prventTables
on all server
for DDL_TABLE_Events
as
begin 
print 'you cannot create or aletr or delete a tables in all database'
rollback transaction
end
