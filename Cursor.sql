---------------------------------------cursor-------------------

/*
-->cursor is a database object that allows us to retrieve and manipulate each row one at a time.
-->It acts as a loop just like the looping mechanism found in any other programming language like C#.
-->We can use cursors when we want to do data manipulation operations like update, delete and etc.

-----------------------Life Cycle of Cursor:-
The life cycle of a cursor can be divided into five phases, as follows:

Declare Cursor
Open Cursor
Fetch Cursor
Close Cursor
Deallocate Cursor

-----------------------Fetch Data From the cursor:-
they are 6 ways to fetch from the cursor table:
1.First      :-it is used fetch only the first row from the cursor table.
			===>	FIRST from cursor_name
2.Last       :-it is used fetch only the last row from the cursor table.
			===>	FETCh Last from cursor_name
3.Next       :-it is used fetch data in the forward direction from the cursor table.
			===>	Fetch next from cursor_name
4.prior		 :-it is used fetch data in the backward direction from the cursor table.
			===>	fetch prior  from cursor_Name
5.Absolute(N):-it is used fetch Nth row from the cursor table.
			===>	fetch Absolute n from cursor_Name
6.Relative(N):-it is used to fetch the data in incremental ways as well s decremental way.
			===>	fetch Relative n from cursor_Name

----------------------Types of Cursors in SQL Server---
The different types of cursors in SQL Server are given below:
Static Cursors
-->SQL Server static cursors retrieve a snapshot of the result set at the moment of cursor formation and keep that snapshot for the duration of the cursor's life.
Changes made to the underlying data after the cursor is created do not affect the result set displayed by the cursor.
-->Does not reflect changes (INSERT, UPDATE, DELETE) after the cursor is opened.
-->Slower, as it stores data temporarily.
Dynamic Cursors:-
-->SQL Server dynamic cursors are more flexible because they reflect changes in the underlying data, updating the result set dynamically as changes occur.
Because of the dynamic nature of the result set, this form of cursor allows for real-time updates, although it may incur additional expense.
-->Reflects real-time changes made to the table while the cursor is open.
Faster, but uses more memory for live data access.
*/
-->static
DECLARE
@emp_id int ,@emp_Name varchar(25)
Declare staticCursorName CURSOR
STATIC FOR
SELECT Emp_ID, Emp_Name FROM Employee;

OPEN staticCursorName;
  
FETCH NEXT FROM staticCursorName into @emp_id,@emp_Name;
WHILE @@FETCH_STATUS = 0 
begin
	 PRINT 'Emp_Id : ' + CAST(@emp_id AS VARCHAR)+'  Emp_Name '+cast(@Emp_name as varchar);
      FETCH NEXT FROM staticCursorName into @emp_id,@emp_Name;
END 

CLOSE staticCursorName;
DEALLOCATE staticCursorName;


-->dynamic

create table StudentCursor  
    (  
      Id INT ,  
      RollNo INT ,  
      EnrollmentNo NVARCHAR(15) ,  
      Name NVARCHAR(50) ,  
      Branch NVARCHAR(50) ,  
      University NVARCHAR(50)  
    ) 
	
INSERT  INTO StudentCursor 
        ( Id, RollNo, EnrollmentNo, Name, Branch, University )  
VALUES  ( 1, 1,N'', N'Nikunj Satasiya', N'CE', N'RK University' ),  
        ( 2, 2, N'', N'Hiren Dobariya', N'CE', N'RK University' ),  
        ( 3, 3, N'', N'Sapna Patel', N'IT', N'RK University' ),  
        ( 4, 4, N'', N'Vivek Ghadiya', N'CE', N'RK University' ),  
        ( 5, 5, N'', N'Pritesh Dudhat', N'CE', N'RK University' ),  
        ( 5, 5, N'', N'Hardik Goriya', N'EC', N'RK University' ),  
        ( 6, 6, N'', N'Sneh Patel', N'ME', N'RK University' )  

select * from StudentCursor
--------------------update-------------------
DECLARE 
@Id INT ,  
@RollNo INT,  
@Branch NVARCHAR(50) ,
--not in table
@Year AS INT  
set @year=right(year(getDate()),2)
DECLARE StdCursor CURSOR  
FOR  
    SELECT  Id ,  
            Branch,  
            RollNo,  
            @Year  FROM StudentCursor 
open StdCursor
FETCH NEXT FROM StdCursor INTO @Id, @Branch, @RollNo,@Year  
WHILE @@FETCH_STATUS = 0  --for looping
begin
	DECLARE @EnrollmentNo NVARCHAR(15)  
            SET @EnrollmentNo = 'SOE' + CAST(@Year AS VARCHAR(2)) + CAST(@Branch AS NVARCHAR(50)) + '000' + CAST(@RollNo AS NVARCHAR(10))--SOE 25 CE 000 1==> SOE25CE0001
                  
                UPDATE StudentCursor SET EnrollmentNo =  @EnrollmentNo WHERE Id =  @Id  
   
        FETCH NEXT FROM StdCursor INTO  @Id, @Branch, @RollNo,@Year  
END 

CLOSE   StdCursor
DEALLOCATE  StdCursor 

select  * from StudentCursor

-------------------delete----------------
DECLARE 
@id INT ,  
@name nvarchar(50)
DECLARE StdDeleteCursor CURSOR FOR  
    SELECT  Id ,name FROM StudentCursor            
open StdDeleteCursor

FETCH NEXT FROM StdDeleteCursor INTO @Id,@name  
WHILE @@FETCH_STATUS = 0  --for looping
begin
	if @name='Sneh patel' or @id=5         
                delete StudentCursor where CURRENT OF StdDeleteCursor  
   
        FETCH NEXT FROM StdDeleteCursor INTO  @Id,@name 
END 

CLOSE   StdDeleteCursor
DEALLOCATE  StdDeleteCursor 

select  * from StudentCursor


