use sqlserver_queries;
--Assending order 
select * from Student order by marks ASC;
--Desecinding Order
select * from Student order by marks DESC;
--Sort a result set by multiple columns
select * from Student order by Std_Name,marks ASC;
--Sort a result set by multiple columns in different orders
select * from Student order by Std_Name Desc,marks asc;
--Sort a result set by an expression
select Std_Name from Student order by Len(std_Name) desc;
--Sort by ordinal positions of columns numbers
select * from Student order by 2;
