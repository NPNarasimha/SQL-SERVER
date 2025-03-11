--GROUP BY
--GROUP BY clause to arrange rows in groups by one or more columns.
select Std_Branch from Student
group by Std_Branch;

select Distinct Std_Branch from Student
group by Std_Branch;
--Using GROUP BY clause with the COUNT() function example
select Std_Branch,Count(std_ID) as Count_stds from Student
group by Std_Branch;


-------------------------The HAVING ---------------
--It clause is often used with the GROUP BY clause to filter groups based on a specified list of conditions.
select Std_Branch from Student 
group by Std_Branch
having Count(Std_Id)<2; 
 