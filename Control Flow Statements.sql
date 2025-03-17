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
-- It simply means that you can place a BEGIN...END statement within another BEGIN... END statement.
begin 
select * from Student;
begin select * from student order by grade desc;
end;
end;