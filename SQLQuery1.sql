use TestDB

--Department Table

Create Table department
(
	DeptID int Primary Key,
	DeptName varchar(100) Not Null
)
go
Insert Into department Values(10,'Account and Finance')
Insert Into department Values(20,'HR')
Insert Into department Values(30,'Learning and Development')
Insert Into department Values(40,'IT')
go

Select * from department

--Add Department
Create Procedure AddDepartment
(
	@DeptID int,
	@DeptName varchar(100)
)
AS 
Insert Into department
values(@DeptID,@DeptName)

Exec AddDepartment 50,'R&D'

--Delete Department By Department ID
Create Procedure DeleteDepartment
(
	@DeptID int
)
AS
Delete 
From department
where DeptID = @DeptID

Exec DeleteDepartment 50

--View All Department
Create Procedure ViewAllDepartment
AS
Select * From department

Exec ViewAllDepartment

--View Department By Dept ID
Create Procedure ViewDeptByID
(
	@DeptID int
)
AS 
Select * From department
where DeptID = @DeptID

Exec ViewDeptByID 10

------------------------------------------------------------------------------------------------

Create Table Project
(
	ProjectID varchar(20) Primary Key Not Null,
	Project Name varchar(50) Not Null,
	ClientID varchar(20) Foreign Key References Client(ClientID),
	MgrID int foreign key references Employee(EmployeeID)
)

Create Table ShiftDetails
(
	[Shift ID] varchar(10) Primary Key,
	[Shift Name] varchar(30) Not Null,
	[Time IN] varchar(10) Not Null,
	[Time OUT] varchar(10) Not Null,
)

drop Table ShiftDetails

Insert Into ShiftDetails Values('S01','Morning Shift','9:00 AM','6:00 PM')
Insert Into ShiftDetails Values('S02','Evening Shift','2:00 PM','11:00 PM')
Insert Into ShiftDetails Values('S03','Night Shift','10:00 PM','7:00 AM')

Select * from ShiftDetails


create table Employees
(
	[Emp ID] int Identity(1001,1) Primary key,
	[First Name] varchar(50) Not Null,
	[Last Name] varchar(50) Not Null
)

go
Insert Into Employees values('Deepak','Gupta')
Insert Into Employees values('Albert','Wasco')
Insert Into Employees values('John','Smith')
go


--Employee Shift Details table and stored procedures
Create Table EmployeeShiftDetails
(
	[Shift ID] varchar(10) Foreign key references ShiftDetails([Shift ID]),
	[Emp ID] int foreign key references Employees([Emp ID])
)

--Assign shifts to Employees

Create Procedure AssignShiftDetails
(
	@ShiftID varchar(10),
	@EmpID int
)
AS 
Insert Into EmployeeShiftDetails
Values(@ShiftID,@EmpID)

Exec AssignShiftDetails 'S01',1002

--Update employee Shift Details

Create Procedure UpdateShiftDetails
(
	@ShiftID varchar(10),
	@EmpID int
)
As
Update EmployeeShiftDetails
Set [Shift ID] = @ShiftID
where [Emp ID] = @EmpID

Exec UpdateShiftDetails 'S02',1001

Select * from EmployeeShiftDetails

--View all Employees shift details

Create Procedure RetrieveShiftDetails
AS 
select * from EmployeeShiftDetails

Exec RetrieveShiftDetails

--View Individual employee shift information

Create Procedure RetrieveEmpShftInfo
(
	@EmpID int
)
AS 
select * from EmployeeShiftDetails
where [Emp ID] = @EmpID

Exec RetrieveEmpShftInfo 1002