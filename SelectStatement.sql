--createing the database--
Create database Sql_Sarver_Queries;
--we can also alter the database name--
Alter database Sql_Sarver_Queries modify name =sqlserver_queries;
--using the database--
use sqlserver_queries;
create table Student(Std_Id int Identity(1,1) Primary key, Std_Name varchar(30) Not null,Std_Branch varchar(35),Marks int check(marks>35));
insert into Student(Std_Name,Std_Branch,Marks)values('Krishna','CSE',85),('NP','ECE',75),('Narasimha','Mech',55),('Prakowsalya','Civil',80);
