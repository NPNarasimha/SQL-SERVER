-- SELECT DISTINCT clause to return distinct rows from a result set.
select Distinct Std_Branch from student 
--Using SELECT DISTINCT with multiple columns
select distinct Std_Branch,Marks from student 
----------WHERE clause to filter rows returned by a query.
select * from student where  Marks>50;

------------------------AND-------------

-- combine two Boolean expressions and return true if all expressions are true.
select * from student where  Std_Branch='CSE' and marks=85;

---OR–-----
--combine two Boolean expressions and return true if either of the conditions is true
select * from student where  Std_Branch='CSE' or marks=85;

--IN----
--check whether a value matches any value in a list or a subquery.
select * from student where marks in(55,85,95);
--not matches the records
select * from student where marks not in(55,85,95);

--BETWEEN
--test if a value is between a range of values
select * from student where marks between 50 and 80;
--not priesent values;
select * from student where marks not between 50 and 80;

--Like
--LIKE operator to check whether a character string matches a specified pattern.
/*The percent wildcard (%): any string of zero or more characters.
The underscore (_) wildcard: any single character.
The [list of characters] wildcard: any single character within the specified set.
The [character-character]: any single character within the specified range.
The [^]: any character that is not within a list or a range.
The wildcard characters make the LIKE operator more flexible than the equal (=) and not equal (!=) string comparison operators.
*/
--Using the LIKE operator with the % wildcard examples
select * from Student
where Std_name like 'N%';
select * from Student
where Std_name like '%N';
select * from Student
where Std_name like 'N%P';
--Using the LIKE operator with the _ (underscore) wildcard
select * from Student
where Std_name like 'N_';
select * from Student
where Std_name like '%_P';
--Using the LIKE operator with the [list of characters] wildcard
select * from Student
where Std_name like '%[NK]';
select * from Student
where Std_name like '[NK]%';

--The square brackets with a character range ,
-- represent a single character that must be within a specified range.
insert into student values('Simha','EEE%',86);
select * from student

select * from Student where Std_Name like '[K-N]%';

--Using the LIKE operator with the [^Character List or Range]
-- represent a single character that is not in the specified range or character list.
select * from Student where Std_Name like '[^K-N]%';

--Using the NOT LIKE operator example
select * from Student where Std_Name Not like 'N%';

--If you want to search for 30% in the comment column, you may come up with a
select * from student where Std_Branch Like 'EEE%%';--OR ESCAPE is USE 
select * from student where Std_Branch Like 'EEE!%%' escape '!';


--------------------------------ALIASing 
/*A column alias is a temporary name assigned to a column or an expression in a query’s result set.
Use a column alias to rename the output of a column or an expression to make it more meaningful.
A table alias is a shorthand or temporary name assigned to a table in a query.
Use table aliases when joining multiple tables or when referencing the same table more than once in a query.*/

select Std_name as Student_Names from Student



