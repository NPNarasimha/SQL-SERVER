/*subqueries:-query contains inside the another query
sub queries are dividing two ways based on execution process
	1.Non-Corelated sub queries
	def:- 
		It execute first inner query and after the outer query is executed.
		**this also divide two types:
			1.Simple/Single row sub queries 
			def:-
				when the sub query is return single value is called a simple subqueries
			2.multiple row sub Quereis
			def:-
				when the sub query is return multiple values is called a multiple subqueries

	2.Corelated sub Queries
	def:-
		->It execute first outer query and after inner query executes.
		->Co related sub query is executed repeatedly,each row is evalueted by the outer query
		->it is also known as the repeated sub Query.
*/

/*1. Subquery with SELECT
A subquery is used to filter or fetch specific data.
Example: Fetch employees with a salary greater than the average salary
*/
select Emp_id,Emp_Name from Employee where Emp_Salary>(Select avg(emp_salary) from Employee);

/*2. Subquery with INSERT
A subquery can provide data for an INSERT statement.
Example: Insert employees from another department into a temporary table

*/
INSERT INTO Employee (Emp_ID, Emp_Name)
SELECT Emp_ID, Emp_Name
FROM Employee
WHERE Emp_Department in(SELECT Emp_Department FROM Departments WHERE Emp_Department = 'Sales');

select * from Employee;

/*
3. Subquery with UPDATE
A subquery can be used to compute new values for an UPDATE.
Example: Update employee salaries based on the department average

*/

UPDATE Employee
SET Emp_Salary = Emp_Salary + 500
WHERE Emp_id IN (SELECT Emp_id FROM Departments WHERE Emp_Salary>20000);

/*4.Subquery with DELETE
A subquery can specify which rows to delete.
Example: Delete customers who have not placed any orders
*/

DELETE FROM Employe
WHERE Emp_ID NOT IN (SELECT DISTINCT Emp_ID FROM Employe);


/*
---------------------------- Correlated Subquery

A correlated subquery refers to columns from the outer query, making it re-evaluate for each row of the outer query.
Example: Fetch employees with a salary higher than the average salary in their department

*/

SELECT Emp_ID, Emp_Name, emp_Salary
FROM Employe E1
WHERE emp_Salary > (SELECT AVG(Emp_Salary)
                FROM Employee E2
                WHERE E1.emp_ID = E2.Emp_ID);
