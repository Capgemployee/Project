Use Training_18Jan2017_Talwade

--Employee Management System Schema

Create Schema EMS

-- 1.Department Table
Create Table EMS.Department
(
	DeptID int Primary Key Not Null,
	DeptName Varchar(50) NOT NULL UNIQUE
)
go
Insert into EMS.Department(DeptID,DeptName) values(1,'Account and Finance')
Insert into EMS.Department(DeptID,DeptName) values(2,'Human Resource Management')
Insert into EMS.Department(DeptID,DeptName) values(3,'Research and Development')
Insert into EMS.Department(DeptID,DeptName) values(4,'IT')
go

--drop table EMS.Department
select * from [EMS].[Department]


-- 2.Designation Table
Create table EMS.Designation
(
	DesigCode varchar(10) primary key Not Null,
	DesigName varchar(100) NOT NULL UNIQUE
)

go
Insert into EMS.Designation values('A3','Assistant Software Engineer/Software Engineer/Accountant')
Insert into EMS.Designation values('A2','Senior Software Engineer/Team Lead/Senior Accountant')
Insert into EMS.Designation values('A1','Project Manager')
Insert into EMS.Designation values('F02','Account Manager/Senior Project Manager')
Insert into EMS.Designation values('F01','Resource Manager/HR')
Insert into EMS.Designation values('P3','Chief Operating Officer')
Insert into EMS.Designation values('P2','Vice President')
Insert into EMS.Designation values('P1','President')
go

select * from EMS.Designation
drop table EMS.Designation

-- 3.Employee Table

Create table EMS.Employee
(
	EmpID int IDENTITY(1001,1) Primary Key Not Null,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	DateOfBirth datetime NOT NULL,
	DateOfJoining datetime NOT NULL,
	Gender varchar(6) NOT NULL Check(Gender='Male' or Gender='Female'),
	Address varchar(100) NOT NULL,
	MaritalStatus varchar(12) NOT NULL,
	Salary int NOT NULL,
	PhoneNumber Bigint NOT NULL,
	DesigCode varchar(10) foreign key references EMS.Designation(DesigCode),
	DeptID int foreign key references EMS.Department(DeptID),
	MgrID int foreign key references EMS.Employee(EmpID),
	GradeCode varchar(10) foreign key references EMS.GradeMaster(GradeCode)

)

Select * from EMS.Employee

-- 4.Client Table
Create table EMS.Client
(
	ClientCode varchar(30) primary key Not Null,
	ClientName varchar(50) NOT NULL UNIQUE
)

go
Insert into EMS.Client(ClientCode,ClientName) values('CG01','Barclays')
Insert into EMS.Client(ClientCode,ClientName) values('CG02','IBM')
Insert into EMS.Client(ClientCode,ClientName) values('CG03','Oracle')
Insert into EMS.Client(ClientCode,ClientName) values('CG04','ESCorp')
Insert into EMS.Client(ClientCode,ClientName) values('CG05','Vmware')
go

select * from EMS.Client


-- 5.Project Table
Create table EMS.Project
(
	ProjectID varchar(20) primary key Not Null,
	ProjectName varchar(40) NOT NULL UNIQUE,
	ClientCode varchar(30) foreign key references EMS.Client(ClientCode),
	MgrID int foreign key references EMS.Employee(EmpID)
	
)

Select * from EMS.Project

-- 6.Employee Project table

create table EMS.EmployeeProject
(
	ProjectID varchar(20) foreign key references EMS.Project(ProjectID),
	EmpID int foreign key references EMS.Employee(EmpID)
)

Select * from EMS.EmployeeProject

-- 7.ShiftDetails table

Create table EMS.ShiftDetails
(
	ShiftID varchar(10) Primary key Not Null,
	ShiftName varchar(20) NOT NULL UNIQUE,
	TimeIn varchar(10),
	TimeOut varchar(10),
	
)
Drop table EMS.ShiftDetails
Select * from EMS.ShiftDetails

-- 8.EmployeeShiftDetails table

create table EMS.EmployeeShiftDetails
(
	EmpID int foreign key references EMS.Employee(EmpID),
	ShiftID varchar(10) foreign key references EMS.ShiftDetails(ShiftID)
)
DROP TABLE EMS.EmployeeShiftDetails

Select * from EMS.EmployeeShiftDetails

-- 9.GradeMaster table

create table EMS.GradeMaster
(
	GradeCode varchar(10) Primary key Not Null,
	Description varchar(100) Not Null,
	MinSalary int Not Null,
	MaxSalary int Not Null
)

insert into EMS.GradeMaster values('Level 1','ABC',15000,30000)
insert into EMS.GradeMaster values('Level 2','DEF',35000,60000)
insert into EMS.GradeMaster values('Level 3','ABC',75000,100000)
insert into EMS.GradeMaster values('Level 4','ABC',150000,300000)

Select * from EMS.GradeMaster

-- 10. UserMaster Table
create table EMS.UserMaster( 
EmpID int foreign key references EMS.Employee(EmpID),
Username varchar(20),
Password varchar(10)
)


go 
insert into [EMS].[GradeMaster]
values('Level 1', 'ASE,SE,SSE' , 15000, 40000)
insert into [EMS].[GradeMaster]
values('Level 2', 'TL,DM,AM' , 45000, 60000)
insert into [EMS].[GradeMaster]
values('Level 3', 'RM,LM' , 60000, 40000)
insert into [EMS].[GradeMaster]
values('Level 4', 'ASE,SE,SSE' , 15000, 40000)
insert into [EMS].[GradeMaster]
values('Level 5', 'ASE,SE,SSE' , 15000, 40000)

--Admin's Add Employee
CREATE PROCEDURE Admin_AddEmployee
(
	@EmpID int,
	@FirstName varchar(30) ,
	@LastName varchar(30) ,
	@DateOfBirth datetime ,
	@DateOfJoining datetime,
	@Gender varchar(6) ,
	@Address varchar(100) ,
	@MaritalStatus varchar(12) ,
	@Salary int ,
	@PhoneNumber Bigint ,
	@DesigCode varchar(10) ,
	@DeptID int,
	@MgrID int ,
	@GradeCode varchar(10) 
)
AS
BEGIN

INSERT INTO EMS.Employee VALUES(@FirstName,@LastName,@DateOfBirth,@DateOfJoining,@Gender,@Address,@MaritalStatus,@Salary,@PhoneNumber,@DesigCode,@DeptID,@MgrID,@GradeCode)

END

--Admin's Display Employee
CREATE PROCEDURE Admin_DisplayEmployee
AS
BEGIN
   SELECT *
   FROM EMS.Employee;
END

--Admin's Search Employee

CREATE PROCEDURE Admin_SearchEmployee
(@EmpID int) AS
BEGIN
   SELECT *
   FROM EMS.Employee
   WHERE EmpID = @EmpID;
END

--Admin's Update Employee

CREATE PROCEDURE Admin_UpdateEmployee
(
	@EmpID int,
	@FirstName varchar(30) ,
	@LastName varchar(30) ,
	@DateOfBirth datetime ,
	@DateOfJoining datetime,
	@Gender varchar(6) ,
	@Address varchar(100) ,
	@MaritalStatus varchar(12) ,
	@Salary int ,
	@PhoneNumber Bigint ,
	@DesigCode varchar(10) ,
	@DeptID int,
	@MgrID int ,
	@GradeCode varchar(10) 

	
)
AS
BEGIN
UPDATE EMS.Employee 
SET 
FirstName = @FirstName,
LastName =  @LastName,
Address = @Address,
MaritalStatus = @MaritalStatus,
Salary = @Salary,
DesigCode =@DesigCode,
DeptID = @DeptID ,
MgrID = @MgrID,
GradeCode = @GradeCode


WHERE EmpID= @EmpID;

END

--Admin's Delete Employee

CREATE PROCEDURE Admin_DeleteEmployee
(@EmpID int) AS
BEGIN
   DELETE 
   FROM EMS.Employee
   WHERE EmpID = @EmpID;
END

--Add Department
Create Procedure Admin_AddDepartment1
(
	@DeptID int,
	@DeptName varchar(100)
)
AS 
Insert Into EMS.Department
values(@DeptID,@DeptName)

--Delete Department By Department ID
Create Procedure Admin_DeleteDepartment
(
	@DeptID int
)
AS
Delete 
From EMS.Department
where DeptID = @DeptID

--View All Department
Create Procedure Admin_ViewAllDepartment
AS
Select * From EMS.Department
exec Admin_ViewAllDepartment

--View Department By Dept ID
Create Procedure Admin_ViewDeptByID
(
	@DeptID int
)
AS 
Select * From EMS.Department
where DeptID = @DeptID

--Assign shifts to Employees

Create Procedure AssignShiftDetails
(
	@ShiftID varchar(10),
	@EmpID int
)
AS 
Insert Into EMS.EmployeeShiftDetails
Values(@ShiftID,@EmpID)


--Update employee Shift Details

Create Procedure UpdateShiftDetails
(
	@ShiftID varchar(10),
	@EmpID int
)
As
Update EMS.EmployeeShiftDetails
Set ShiftID= @ShiftID
where EmpID= @EmpID

--View all Employees shift details

Create Procedure RetrieveShiftDetails
AS 
select * from EMS.EmployeeShiftDetails

--View Individual employee shift information

Create Procedure RetrieveEmpShftInfo
(
	@EmpID int
)
AS 
select * from EMS.EmployeeShiftDetails 
where EmpID = @EmpID

--Add Project 
Create Procedure Admin_AddProject
(
	@ProjectID varchar(20) ,
	@ProjectName varchar(40),
	@ClientCode varchar(30) ,
	@MgrID int

)
AS
BEGIN
Insert into EMS.Project Values(@ProjectID, @ProjectName, @ClientCode, @MgrID )
END

--Admin's Display Project
CREATE PROCEDURE Admin_DisplayProject
AS
BEGIN
   SELECT *
   FROM EMS.Project;
END

--Admin's Assignment of Project to Employee

Create Procedure Admin_AssignProject
(
	@ProjectID varchar(20) ,
	@EmpID int

)
AS
Insert Into EMS.EmployeeProject Values (@ProjectID  ,
	@EmpID 
)

Create Procedure Admin_CreateUser
(
 @EmpID int ,
@Username varchar(20),
@Password varchar(10)
)
AS
BEGIN
	SELECT UserName FROM  EMS.UserMaster
	WHERE EmpID = @EmpID AND UserName = @Username AND Password = @Password
END


--Employee's Employee Update
CREATE PROCEDURE Employee_UpdateEmployee
(
	@EmpID int,
	@FirstName varchar(30) ,
	@LastName varchar(30) ,
	@DateOfBirth datetime ,
	@DateOfJoining datetime,
	@Gender varchar(6) ,
	@Address varchar(100) ,
	@MaritalStatus varchar(12) ,
	@Salary int ,
	@PhoneNumber Bigint ,
	@DesigCode varchar(10) ,
	@DeptID int,
	@MgrID int ,
	@GradeCode varchar(10) 

	
)
AS
BEGIN
UPDATE EMS.Employee 
SET 
FirstName = @FirstName,
LastName =  @LastName,
Address = @Address,
MaritalStatus = @MaritalStatus,
PhoneNumber = @PhoneNumber



WHERE EmpID= @EmpID;

END

--Employee's Display Project  
CREATE PROCEDURE Employee_DisplayProject
(
	@ProjectID varchar(20),
	@EmpID int
)
AS
BEGIN
   SELECT *
   FROM EMS.Project
   WHERE ProjectID=@ProjectID;
END

--Employee's Search Employee

CREATE PROCEDURE Employee_SearchEmployee
(@EmpID int) AS
BEGIN
   SELECT FirstName,DesigCode,DeptID
   FROM EMS.Employee
   WHERE EmpID = @EmpID;
END

select * from Admin_CreateUser