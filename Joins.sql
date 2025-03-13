
create table Course(C_Id int Identity(1,1),C_Name Varchar(25),Std_Id int);
insert into Course (C_Name,Std_Id)values('python',1),('Java',2),('C#',3),('C++',4),('C',5),('DOT NET',6),('MY SQL',7),('Sql',8);
select * from Course;
select * from Student;
--inner Join--
--It return the matching records from both tables.
select s.Std_Id,s.Std_Name,Course.C_Name from Student s
inner Join Course ON Course.Std_Id=s.Std_Id;

--Left join--
select s.Std_Id,c.Std_Id,s.Std_Name,c.C_Name from student s
Left Join Course c on c.C_Id= s.Std_Id;
--Right Join--
select s.Std_Id,c.Std_Id,s.Std_Name,c.C_Name from student s
Right Join Course c on c.C_Id= s.Std_Id;

--full JOin --
select s.Std_Id,c.Std_Id,s.Std_Name,c.C_Name from student s
full Join Course c on c.C_Id= s.Std_Id;

 ---self join --
select s.Std_Id,s1.Std_Name,s1.Std_Id from student s
 Join Student s1 on s1.Std_Id=s.Std_id;
--or
select s.Std_Id,s1.Std_Name,s1.Std_Id from student s
left Join Student s1 on s1.Std_Id=s.Std_id;
--or
select s.Std_Id,s1.Std_Name,s1.Std_Id from student s
inner Join Student s1 on s1.Std_Id=s.Std_id;

 --crose join --
 select s.Std_Id,s.Std_Name,c.C_Name from student s
cross Join Course c 
 

