Select * from [EMS].[Employee]
Select * from  [EMS].[ShiftDetails]
select * from [EMS].[EmployeeShiftDetails]
select * from [EMS].[Client]
select * from [EMS].[Department]
select * from [EMS].[Designation]
select * from [EMS].[EmployeeProject]
select * from [EMS].[GradeMaster]
select * from [EMS].[Project]
select * from [EMS].[UserMaster]

Insert Into [EMS].[ShiftDetails] Values('S01','Morning Shift','9:00 AM','6:00 PM')
Insert Into [EMS].[ShiftDetails] Values('S02','Evening Shift','2:00 PM','11:00 PM')
Insert Into [EMS].[ShiftDetails] Values('S03','Night Shift','10:00 PM','7:00 AM')

drop table [EMS].[Employee]

Insert Into [EMS].[Employee]
values('Deepak','Gupta',25/01/1995,18/01/2017,'Male','bjhsddbjhsdbjhc','Unmarried',15000,1234567891,'A1',1,1002,'Level 1')
Insert Into [EMS].[Employee]
values('Rahul','Bane',10/02/1994,18/01/2017,'Male','dbjhsdbjhc','Unmarried',15000,8794567891,'A2',2,1001,'Level 2')


Insert Into [EMS].[EmployeeShiftDetails] Values(1001,'S01')
Insert Into [EMS].[EmployeeShiftDetails] Values(1002,'S02')

--View Employee Shift Details

Create Procedure ViewEmpshftDetails
(
	@EmpID int
)
AS 
Select s1.EmpID, s1.ShiftID,s2.ShiftName
from  [EMS].[ShiftDetails] s2
Inner Join [EMS].[EmployeeShiftDetails] s1
ON s1.ShiftID = s2.ShiftID
Where EmpId=@EmpID

Exec ViewEmpshftDetails 1001


Insert into [EMS].[Project]
values('P01','ABC','CG01',1001)
Insert into [EMS].[Project]
values('P02','XYZ','CG03',1002)

Insert Into [EMS].[EmployeeProject] values('P01',1001)
Insert Into [EMS].[EmployeeProject] values('P02',1002)

Create Procedure EmployeeProjDetails
(
	@EmpID int,
	@ProjectID varchar(20)
)
AS 
Select e.EmpID,e.FirstName,p.ProjectID,p.ProjectName,p.MgrID
from [EMS].[Employee] e
Inner Join [EMS].[EmployeeProject] ep ON e.EmpID = ep.EmpID 
Inner Join [EMS].[Project] p ON e.MgrID = p.MgrID
Where e.EmpID = @EmpID and p.ProjectID = @ProjectID