use sqlserver_queries;
select * from Student
--UNION to combine the results of two or more queries into a single result set.--UNION operator removes all duplicate rows from the result sets.
select * from Student where Std_Id between 1 and 4
union 
select * from Student where Std_Id between 3 and 6;
--UNION ALL operator includes the duplicate rows in the final result set.
select * from Student where Std_Id between 1 and 4
union All
select * from Student where Std_Id between 3 and 6;
--INTERSECT operator to combine result sets of two input queries and return the distinct rows that appear in both inputs.
select * from Student where Std_Id between 1 and 4
intersect
select * from Student where Std_Id between 3 and 6;

-- EXCEPT operator to subtract a result set of a query from another result set of another query.
select * from Student where Std_Id between 1 and 4
Except
select * from Student where Std_Id between 3 and 6;

