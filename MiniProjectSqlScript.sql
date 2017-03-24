Use Training_18Jan2017_Talwade

--Employee Management System Schema

Create Schema EMS

-- 1.Department Table
Create Table EMS.Department
(
	DeptID int IDENTITY(1,1) Primary Key,
	DeptName Varchar(50) NOT NULL UNIQUE
)
go
Insert into EMS.Department(DeptName) values('Account and Finance')
Insert into EMS.Department(DeptName) values('Marketing')
Insert into EMS.Department(DeptName) values('Human Resource Management')
Insert into EMS.Department(DeptName) values('Research and Development')
Insert into EMS.Department(DeptName) values('IT')
go

--drop table EMS.Department
select * from [EMS].[Department]


-- 2.Designation Table
Create table EMS.Designation
(
	DesigCode varchar(10) primary key Not Null,
	DesigName varchar(30) NOT NULL UNIQUE
)

go
Insert into EMS.Designation values('A5','Assistant Software Engineer')
Insert into EMS.Designation values('A4','Software Engineer')
Insert into EMS.Designation values('A3','Senior Software Engineer')
Insert into EMS.Designation values('A2','Team Lead')
Insert into EMS.Designation values('F04','Delivery Manager')
Insert into EMS.Designation values('F03','Account Manager')
Insert into EMS.Designation values('F02','Resource Manager')
Insert into EMS.Designation values('F01','Location Manager')
Insert into EMS.Designation values('S1','Senior Project Manager')
Insert into EMS.Designation values('P3','Chief Operating Officer')
Insert into EMS.Designation values('P2','Vice President')
Insert into EMS.Designation values('P1','President')

go

select * from EMS.Designation
drop table EMS.Designation

-- 3.Employee Table

Create table EMS.Employee
(
	EmpID int IDENTITY(1,1) Primary Key Not Null,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20) NOT NULL,
	DateOfBirth datetime NOT NULL,
	DateOfJoining datetime NOT NULL,
	Gender varchar(6) NOT NULL,
	Address varchar(100) NOT NULL,
	MaritalStatus varchar(12) NOT NULL,
	Salary int NOT NULL,
	PhoneNumber Bigint NOT NULL,
	DesigCode varchar(10) foreign key references EMS.Designation(DesigCode),
	DeptID int foreign key references EMS.Department(DeptID),
	MgrID int foreign key references EMS.Employee(EmpID),
	GradeCode varchar(10) foreign key references EMS.GradeMaster(GradeCode)

)

alter table EMS.Employee
add constraint check_gender Check(Gender='Male' or Gender='Female')

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
	MgrID int foreign key references EMS.Employee(EmpID),
	ProjectDetails varchar(100) 
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
	TimeIn time,
	TimeOut time,
	NoOfHours int
)

Select * from EMS.ShiftDetails

-- 8.EmployeeShiftDetails table

create table EMS.EmployeeShiftDetails
(
	EmpID int foreign key references EMS.Employee(EmpID),
	ShiftID varchar(10) foreign key references EMS.ShiftDetails(ShiftID)
)

Select * from EMS.EmployeeShiftDetails

-- 9.GradeMaster table

create table EMS.GradeMaster
(
	GradeCode varchar(10) Primary key Not Null,
	Description varchar(100) Not Null,
	MinSalary int Not Null,
	MaxSalary int Not Null
)

Select * from EMS.GradeMaster

go 
insert into [EMS].[GradeMaster]
values('Y', 'ASE,SE,SSE' , 15000, 40000)
insert into [EMS].[GradeMaster]
values('C1Y', 'TL,DM,AM' , 45000, 60000)
insert into [EMS].[GradeMaster]
values('C2Y', 'RM,LM' , 60000, 40000)
insert into [EMS].[GradeMaster]
values('C3Y', 'ASE,SE,SSE' , 15000, 40000)
insert into [EMS].[GradeMaster]
values('C4Y', 'ASE,SE,SSE' , 15000, 40000)
