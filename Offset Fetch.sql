--OFFSET FETCH clauses to limit the number of rows returned by a query.

--The OFFSET clause specifies the number of rows to skip before starting to return rows from the query
--NOTE:- must use the OFFSET and FETCH clauses with the ORDER BY clause {order by is mandatory}
select * from Student order by Marks OFFSET 2 Rows;

--The FETCH clause specifies the number of rows to return after the OFFSET clause has been processed
select * from Student order by Marks
select * from Student order by Marks OFFSET 2 Rows Fetch next 1 row only;
select * from Student order by Marks OFFSET 1 Row Fetch next 2 rows only;


-------select top-------------
--SELECT TOP clause allows you to limit the rows or percentage of rows returned by a query.

--Using SQL Server SELECT TOP with a constant value
select top 3 * from student 
--Using SELECT TOP to return a percentage of rows
select top 20 percent * from student;