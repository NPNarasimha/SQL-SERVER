--INSERT statement to add a new row to a table.
insert into student (Std_Name,Std_Branch,Marks) values ('Bai','AI',48);
--INSERT multiple rows – insert multiple rows into a table using a single INSERT statement
insert into student (Std_Name,Std_Branch,Marks) values ('Krishna Bai','AI',58),('Jhon','CAI',68);
--INSERT INTO SELECT statement to add data from other tables to a table.
insert into student (Std_Name,Std_Branch,Marks) select top 2 Std_name,Std_Branch,marks from Student;


--UPDATE statement to change existing data in a table.
update student set Std_Name='Ram', Std_Branch='CAI',Marks=97 where Std_Id=15;

-- DELETE statement to remove one or more rows from a table.
delete from student where Std_Id=14;

select * from Student;