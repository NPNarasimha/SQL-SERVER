--Create a statement block that consists of multiple SQL statements that execute together.
/*
BEGIN
    { sql_statement | statement_block}
END
*/
Begin 
select * from student;
end;
--Nested begin..End
--It simply means that you can place a BEGIN...END statement within another BEGIN... END statement.
begin 
select * from Student;
begin select * from student order by grade desc;
end;
end;

--======================================if Else==============================================--
/*
IF boolean_expression   
BEGIN
    { statement_block }
END
*/
create proc FindIds
(@id int)
as 
begin 
select * from student where id=@id;
end;

exec FindIds 3;
--using if else conditions
alter proc FindIds
(@id int)
as 
	if @id >4
		begin 
		print'Id is greater then 4'
		end;
	else
		begin 
		print'Id is not greater then 4'
		end;

exec FindIds 3;
--using nested if else conditions
alter proc FindIds
(@id int)
as 
	if @id>=4
		begin 
		if @id<=7
			begin
			print'Id is greater then 4 and less then 7'
			end;
		else
			begin 
			print'Id is greater then 4 and not less then 7'
			end;
		end;
	else
		begin 
		print'Id is not greater then 4'
		end;

exec FindIds 9;

begin 
declare @grade int=90
if @grade>=10
	begin
	print 'grater then 10'
	end;
end;
 
