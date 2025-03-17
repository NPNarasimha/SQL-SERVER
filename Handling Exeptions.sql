--TRY CATCH construct to handle exceptions in stored procedures.
/*
	BEGIN TRY  
   -- statements that may cause exceptions
END TRY 
BEGIN CATCH  
   -- statements that handle exception
END CATCH 
*/

 /* ==========================CATCH block functions=================
ERROR_LINE() returns the line number on which the exception occurred.
ERROR_MESSAGE() returns the complete text of the generated error message.
ERROR_PROCEDURE() returns the name of the stored procedure or trigger where the error occurred.
ERROR_NUMBER() returns the number of the error that occurred.
ERROR_SEVERITY() returns the severity level of the error that occurred.
ERROR_STATE() returns the state number of the error that occurred.
Note that you only use these functions in the CATCH block. If you use them outside of the CATCH block, all of these functions will return NULL.
*/
--we can create saparate or directly use in catch block
 create proc catchError
 as

        SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
 go 

alter PROC usp_divide(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        exec catchError;
    END CATCH
END;

DECLARE @r decimal;
EXEC usp_divide 10, 0, @r output;
PRINT @r;

---============The THROW
--statement raises an exception and transfers execution to a CATCH block of a TRY CATCH construct.

/*
THROW [ error_number ---> The error_number is an integer that represents the exception. The error_number must be greater than 50,000 and less than or equal to 2,147,483,647. ,  
        message ---->The message is a string of type NVARCHAR(2048) that describes the exception. ,  
        state -->The state is a TINYINT with the value between 0 and 255. The state indicates the state associated with the message.
		];
		ex:-> THROW 50005, N'An error occurred', 1;
*/
