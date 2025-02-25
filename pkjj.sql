USE [Training_18Jan2017_Talwade]
GO
/****** Object:  StoredProcedure [dbo].[Employee_DisplayProject]    Script Date: 3/31/2017 7:16:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_DisplayProject]
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
GO
/****** Object:  StoredProcedure [dbo].[Employee_UpdateEmployee]    Script Date: 3/31/2017 7:16:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_UpdateEmployee]
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
GO
