--The CREATE DATABASE statement creates a new database.
create database Sample_programs

--This statement lists all databases in the SQL Server:
SELECT name FROM master.sys.databases
ORDER BY name;

--drop database Sample_programs;
--To remove an existing database from a SQL Server instance, you use the DROP DATABASE statement
DROP DATABASE IF EXISTS Sample_programs;


-- IDENTITY property to create an identity column for a table.IDENTITY[(seed,increment)]
Create table Employee(Emp_Id int Identity(1,1),Emp_Name varchar(25),Emp_Depart varchar(25),Emp_salary int);

--ALTER TABLE ADD statement to add one or more columns to a table.
alter table Employee
Add Emp_Lang varchar(20);

--ALTER TABLE ALTER COLUMN statement to modify a column of a table.
--Modify the data type add the new data type
alter table Employee
alter column Emp_Lang varchar(20)
--Change the size of the column
alter table Employee
alter column Emp_Lang varchar(30)
--Add a Not Null constraints 
alter table Employee
alter column Emp_Id int Not Null

alter table Employee
Add Constraint Emp_Id Primary key (Emp_Id);

--ALTER TABLE DROP column statement to remove one or more columns from existing table.
alter table Employee
drop column Emp_Lang;
--drop the Constaints 
alter table Employee
drop Constraint Emp_Id;

--Drop tables if Exist, show you how to delete tables from the database.
drop table if Exists krishna

--TRUNCATE TABLE – delete all data from a table faster and more efficiently.
truncate table Employee;



