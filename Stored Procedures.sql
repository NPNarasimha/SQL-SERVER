create database ProcedureDatabase;
use ProcedureDatabase;

create table student(id int primary key,name varchar(28),branch varchar(39),grade decimal);
INSERT INTO student (id, name, branch, grade) VALUES
(1, 'Rahul Sharma', 'Computer Science', 89.75),
(2, 'Aditi Verma', 'Electronics', 91.50),
(3, 'Vikram Singh', 'Mechanical', 85.25),
(4, 'Neha Gupta', 'Civil', 88.00),
(5, 'Aman Kumar', 'Information Technology', 92.30);


--Stored procedure creation ----
--create proc GetStudentDetails or--
CREATE PROCEDURE GetStudentDetails
as
begin 
select * from Student;
end;
--GetStudentDetails; or
--exec GetStudentDetails; or
execute GetStudentDetails;

--Modifying a stored procedure

alter Proc GetStudentDetails
as
begin
select * from Student order by grade desc;
end;
exec GetStudentDetails;

--Deleting a stored procedure
drop Proc GetStudentDetails;

--Creating a stored procedure with one parameter
create procedure FindStudent 
(@id int)
as
begin
select * from student where id=@id;
end;

exec FindStudent 3;
--modifying 
Alter procedure FindStudent 
(@id int)
as
begin
select name from student where id=@id;
end;

exec FindStudent 6;
--create the passing parameters
Alter procedure FindStudent 
(@ExpectGrade decimal)

as
begin
select * from student where grade>@ExpectGrade;
end;

FindStudent 90;

--insert data 
create procedure InsertStudent 
(
@id int,
@name varchar(29),
@branch varchar(39),
@grade decimal
)
as
begin
insert into student(id,name,branch,grade)values(@id,@name,@branch,@grade);
end;

InsertStudent 6,'Krishna','CSE',88;
InsertStudent @id=7,@name='Kowsalya',@branch='ECE',@grade=89;
--find name using like operator 
create proc FindStudentByName
(@studentName varchar(max))
as 
begin 
select * from student where name Like '%'+@studentName+'%';
end;

exec FindStudentByName'K';

--find name using like operator with default value. because while calling the proc we can't enter the name it while take default.
create proc FindStudentName
(@studentName varchar(max)='kri')
as 
begin 
select * from student where name Like '%'+@studentName+'%';
end;

exec FindStudentName ;
--because while calling the proc we can enter the name but default is present but it is use the user enter name.
create proc FindStudentdefaultName
(@studentName varchar(max)='kri')
as 
begin 
select * from student where name Like '%'+@studentName+'%';
end;

exec FindStudentdefaultName 'shar';
--variable declearation run at a time entire delcre to print or use select @totalStds.

declare @TotalStds int;
set @TotalStds=(
select count(id) from student
);
print @TotalStds



--output parameter
create proc adding
(@n1 int 
,@n2 int,
@res int output
)
as
begin 
set @res=@n1+@n2;
end;

declare @result int
exec adding 2,4,@result output;
select @result;


-----------------------------------practice purpuse------------------------
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,       -- Unique account identifier
    AccountHolderName VARCHAR(100),  -- Name of the account holder
    Balance DECIMAL(10,2) CHECK (Balance >= 0)  -- Account balance (cannot be negative)
);
INSERT INTO Accounts (AccountID, AccountHolderName, Balance) VALUES
(1, 'John Doe', 1000.00),
(2, 'Alice Smith', 500.00),
(3, 'Bob Johnson', 200.00);

/*Implement a stored procedure to handle bank account withdrawals. Ensure:
The withdrawal amount does not exceed the account balance.
Raise errors for insufficient funds or non-existent accounts.
*/
select * from Accounts
create procedure withdrawAmt
@Accountid int ,
@amount decimal 
as 
begin
begin try
	if not Exists(select 1 from Accounts where AccountID=@Accountid)
	begin 
	THROW 5003,'Not-Account Exist',1;
	end

	declare @balance decimal;
	select @balance= balance from Accounts where Accountid=@Accountid;
	if @balance<@amount
	begin 
	throw 5002,'insuffcient balance',1;
	end
	 UPDATE Accounts
        SET Balance = Balance - @Amount
        WHERE AccountID = @AccountID;
		PRINT 'Withdrawal successful. Remaining Balance: ' + CAST(@Balance - @Amount AS VARCHAR(50));
		END TRY
		BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage VARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
		end catch
end;

exec withdrawAmt 5,500;

/*--2.Inventory Management: Stock Update
Problem:
Implement a stored procedure to update the stock for a product:
Raise an error if the product doesn’t exist.
Raise an error if the quantity to remove exceeds available stock.
*/
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Stock INT CHECK (Stock >= 0)  -- Stock cannot be negative
);
INSERT INTO Products (ProductID, ProductName, Stock) VALUES
(1, 'Laptop', 50),
(2, 'Mouse', 100),
(3, 'Keyboard', 75);

CREATE PROCEDURE UpdateStock
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    BEGIN TRY
        -- Check if product exists
        IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
        BEGIN
            THROW 50006, 'Product not found.', 1;
        END

        -- Check if sufficient stock is available
        DECLARE @CurrentStock INT;
        SELECT @CurrentStock = Stock FROM Products WHERE ProductID = @ProductID;

        IF @CurrentStock < @Quantity
        BEGIN
            THROW 50007, 'Insufficient stock.', 1;
        END

        -- Update stock
        UPDATE Products
        SET Stock = Stock - @Quantity
        WHERE ProductID = @ProductID;

        PRINT 'Stock updated successfully. Remaining Stock: ' + CAST(@CurrentStock - @Quantity AS VARCHAR(50));
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH
END;

exec UpdateStock 2,3;

/*Problem:
Create a stored procedure to apply a discount code to an order:
Ensure the discount code is valid and not expired.
Check if the discount amount is less than or equal to the total order amount.

Solution:
*/

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0)  -- Ensures amount is not negative
);

CREATE TABLE DiscountCodes (
    Code NVARCHAR(50) PRIMARY KEY,
    DiscountAmount DECIMAL(10,2) CHECK (DiscountAmount > 0),  -- Ensures positive discount
    ExpiryDate DATE
);
INSERT INTO Orders (OrderID, TotalAmount) VALUES
(1, 500.00),
(2, 300.00),
(3, 150.00);

INSERT INTO DiscountCodes (Code, DiscountAmount, ExpiryDate) VALUES
('SUMMER50', 50.00, '2025-12-31'),
('BIGSALE100', 100.00, '2024-06-30'),
('EXPIRED20', 20.00, '2023-12-31');

CREATE PROCEDURE ApplyDiscount
    @OrderID INT,
    @DiscountCode NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        -- Check if order exists
        IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
        BEGIN
            THROW 50008, 'Order not found.', 1;
        END

        -- Check if discount code is valid
        IF NOT EXISTS (SELECT 1 FROM DiscountCodes WHERE Code = @DiscountCode AND ExpiryDate >= GETDATE())
        BEGIN
            THROW 50009, 'Invalid or expired discount code.', 1;
        END

        -- Get order total and discount value
        DECLARE @OrderTotal DECIMAL(10, 2), @DiscountValue DECIMAL(10, 2);
        SELECT @OrderTotal = TotalAmount FROM Orders WHERE OrderID = @OrderID;
        SELECT @DiscountValue = DiscountAmount FROM DiscountCodes WHERE Code = @DiscountCode;

        -- Ensure discount value does not exceed order total
        IF @DiscountValue > @OrderTotal
        BEGIN
            THROW 50010, 'Discount value exceeds the order total.', 1;
        END

        -- Apply the discount
        UPDATE Orders
        SET TotalAmount = TotalAmount - @DiscountValue
        WHERE OrderID = @OrderID;

        PRINT 'Discount applied successfully. New Total: ' + CAST(@OrderTotal - @DiscountValue AS NVARCHAR(50));
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH
END;
exec ApplyDiscount 1,'SUMMER50';

/*--4. Student Management: Update Grades
Problem:
Create a stored procedure to update a student’s grade for a specific subject:
Ensure the student and subject exist.
Validate that the grade is within the accepted range (e.g., 0–100).
Solution:
*/

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY,
    SubjectName NVARCHAR(100)
);

CREATE TABLE Grades (
    StudentID INT,
    SubjectID INT,
    Grade INT CHECK (Grade BETWEEN 0 AND 100),
    PRIMARY KEY (StudentID, SubjectID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

INSERT INTO Students (StudentID, Name) VALUES
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Subjects (SubjectID, SubjectName) VALUES
(101, 'Mathematics'), (102, 'Physics'), (103, 'Chemistry');

INSERT INTO Grades (StudentID, SubjectID, Grade) VALUES
(1, 101, 85),
(2, 102, 90),
(3, 103, 78);
CREATE PROCEDURE UpdateStudentGrade
    @StudentID INT,
    @SubjectID INT,
    @Grade DECIMAL(5, 2)
AS
BEGIN
    BEGIN TRY
        -- Check if student exists
        IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentID = @StudentID)
        BEGIN
            THROW 50011, 'Student not found.', 1;
        END

        -- Check if subject exists
        IF NOT EXISTS (SELECT 1 FROM Subjects WHERE SubjectID = @SubjectID)
        BEGIN
            THROW 50012, 'Subject not found.', 1;
        END

        -- Validate grade
        IF @Grade < 0 OR @Grade > 100
        BEGIN
            THROW 50013, 'Invalid grade. Grade must be between 0 and 100.', 1;
        END

        -- Update grade
        UPDATE Grades
        SET Grade = @Grade
        WHERE StudentID = @StudentID AND SubjectID = @SubjectID;

        PRINT 'Grade updated successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH
END;
--before 
select * from grades;
exec  UpdateStudentGrade 1,102,78;
--after
select * from grades;