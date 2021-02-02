use AdventureWorks2019
go

create procedure sp_DisplayEmployeesHireYear
	@HireYear int
as
select * from HumanResources.Employee
Where  datepart (YY, HireDate) = @HireYear 
go

exec sp_DisplayEmployeesHireYear 2003 
go

create Procedure SP_EmployeesHireYearCount
	@HireYear int,
	@Count int OUTPUT
as
select @Count = Count(*) from HumanResources.Employee
where datepart (YY, HireDate) = @HireYear 
go

declare @Number int
exec SP_EmployeesHireYearCount 2003, @Number OUTPUT
PRINT @Number
GO

--Tạo thủ tục lưu trữ đếm số người vào làm trong một năm xác định có tham số đầu vào là một năm, hàm trả về số người vào làm năm đó
CREATE PROCEDURE sp_EmployeesHireYearCount2
@HireYear int
AS
DECLARE @Count int
SELECT @Count=COUNT(*) FROM HumanResources.Employee
WHERE DATEPART(YY, HireDate)=@HireYear
RETURN @Count
GO
--Chạy thủ tục lưu trữ cần phải truyền vào 1 tham số đầu và lấy về số người làm trong năm đó.
DECLARE @Number int
EXECUTE @Number = sp_EmployeesHireYearCount2 2003
PRINT @Number
GO

--Tạo bảng tạm #Students
CREATE TABLE #Students
(
RollNo varchar(6) CONSTRAINT PK_Students PRIMARY KEY,
FullName nvarchar(100),
Birthday datetime constraint DF_StudentsBirthday DEFAULT
DATEADD(yy, -18, GETDATE()))
GO
--Tạo thủ tục lưu trữ tạm để chèn dữ liệu vào bảng tạm
CREATE PROCEDURE #spInsertStudents
@rollNo varchar(6),
@fullName nvarchar(100),
@birthday datetime
AS BEGIN
IF(@birthday IS NULL)
SET @birthday=DATEADD(YY, -18, GETDATE())
INSERT INTO #Students(RollNo, FullName, Birthday)
VALUES(@rollNo, @fullName, @birthday)

END
GO
--Sử dụng thủ tục lưu trữ để chèn dữ liệu vào bảng tạm
EXEC #spStudents 'A12345', 'abc', NULL
EXEC #spStudents 'A54321', 'abc', '12/24/2011'
SELECT * FROM #Students
--Tạo thủ tục lưu trữ tạm để xóa dữ liệu từ bảng tạm theo RollNo
CREATE PROCEDURE #spDeleteStudents
@rollNo varchar(6)
AS BEGIN
DELETE FROM #Students WHERE RollNo=@rollNo
END
--Xóa dữ liệu sử dụng thủ tục lưu trữ
EXECUTE #spDeleteStudents 'A12345'
GO

--Tạo một thủ tục lưu trữ sử dung lệnh RETURN để trả về một số nguyên
CREATE PROCEDURE Cal_Square @num int=0 AS
BEGIN
RETURN (@num * @num);
END
GO
--Chạy thủ tục lưu trữ
DECLARE @square int;
EXEC @square = Cal_Square 10;
PRINT @square;
GO

--Xem định nghĩa thủ tục lưu trữ bằng hàm OBJECT_DEFINITION
SELECT
OBJECT_DEFINITION(OBJECT_ID('HumanResources.uspUpdateEmployeePersonalI
nfo')) AS DEFINITION

--Xem định nghĩa thủ tục lưu trữ bằng
SELECT definition FROM sys.sql_modules
WHERE
object_id=OBJECT_ID('HumanResources.uspUpdateEmployeePersonalInfo')
GO

--Thủ tục lưu trữ hệ thống xem các thành phần mà thủ tục lưu trữ phụ thuộc
sp_depends 'HumanResources.uspUpdateEmployeePersonalInfo'
GO

USE AdventureWorks2019
GO
--Tạo thủ tục lưu trữ sp_DisplayEmployees
CREATE PROCEDURE sp_DisplayEmployees AS
SELECT * FROM HumanResources.Employee
GO

--Thay đổi thủ tục lưu trữ sp_DisplayEmployees
ALTER PROCEDURE sp_DisplayEmployees AS
SELECT * FROM HumanResources.Employee
WHERE Gender='F'
GO
--Chạy thủ tục lưu trữ sp_DisplayEmployees
EXEC sp_DisplayEmployees
GO

--Xóa một thủ tục lưu trữ
DROP PROCEDURE sp_DisplayEmployees
GO

--
CREATE PROCEDURE sp_EmployeeHire
AS
BEGIN
--Hiển thị
EXECUTE sp_DisplayEmployeesHireYear 1999
DECLARE @Number int
EXECUTE sp_EmployeesHireYearCount 1999, @Number OUTPUT
PRINT N'Số nhân viên vào làm năm 1999 là: ' +
CONVERT(varchar(3),@Number)
END
GO
--Chạy thủ tục lưu trữ
EXEC sp_EmployeeHire
GO

--Thay đổi thủ tục lưu trữ sp_EmployeeHire có khối TRY ... CATCH
ALTER PROCEDURE sp_EmployeeHire
@HireYear int

5

Store Procedure Thủ tục lưu trữ
AS
BEGIN
BEGIN TRY
EXECUTE sp_DisplayEmployeesHireYear @HireYear
DECLARE @Number int
--Lỗi xảy ra ở đây có thủ tục sp_EmployeesHireYearCount chỉ truyền 2 tham số mà ta truyền 3

EXECUTE sp_EmployeesHireYearCount @HireYear, @Number OUTPUT,'123'

PRINT N'Số nhân viên vào làm năm là: ' +

CONVERT(varchar(3),@Number)
END TRY
BEGIN CATCH
PRINT N'Có lỗi xảy ra trong khi thực hiện thủ tục lưu trữ'
END CATCH
PRINT N'Kết thúc thủ tục lưu trữ'
END
GO
--Chạy thủ tục sp_EmployeeHire
EXEC sp_EmployeeHire 1999
--Xem thông báo lỗi bên Messages không phải bên Result
GO

--Thay đổi thủ tục lưu trữ sp_EmployeeHire sử dụng hàm @@ERROR
ALTER PROCEDURE sp_EmployeeHire
@HireYear int
AS
BEGIN
EXECUTE sp_DisplayEmployeesHireYear @HireYear
DECLARE @Number int
--Lỗi xảy ra ở đây có thủ tục sp_EmployeesHireYearCount chỉ truyền 2 tham số mà ta truyền 3

EXECUTE sp_EmployeesHireYearCount @HireYear, @Number OUTPUT,
'123'
IF @@ERROR <> 0
PRINT N'Có lỗi xảy ra trong khi thực hiện thủ tục lưu trữ'
PRINT N'Số nhân viên vào làm năm là: ' +
CONVERT(varchar(3),@Number)
END
GO
--Chạy thủ tục sp_EmployeeHire
EXEC sp_EmployeeHire 1999
--Xem thông báo lỗi bên Messages không phải bên Result


/* Phan 2*/

create database ToyzUnlimited 
go

use ToyzUnlimited
go

create table Toys(
	ProductCode varchar(5) primary key,
	Name varchar(30),
	Category varchar(30),
	Manufacturer varchar(40),
	AgeRange varchar(15),
	UnitPrice money,
	Netweight int,
	QtyOnHand int
)
go 
insert into Toys values (1, 'Lego', 'Lap ghep', 'LEGO', 'no limit', 10000000, 1000, 20),
						(2, 'Were Wolf', 'Card Game', 'Were Wolf', 'no limit', 500000, 1000, 20),
						(3, 'Explosive Cat', 'Card Game', 'Cat', 'no limit', 200000, 1000, 20),
						(4, 'Uno', 'Card Game', 'Uno', 'no limit', 300000, 400, 20),
						(5, 'Elsa', 'Firgue', 'Catoon', 'no limit', 10000000, 400, 20),
						(6, 'Cindrela', 'Firgue', 'Catoon', 'no limit', 10000000, 400, 20),
						(7, 'Power Ranger', 'Firgue', 'Catoon', 'no limit', 10000000, 400, 20),
						(8, 'Super Sentai', 'Firgue', 'Catoon', 'no limit', 10000000, 400, 20),
						(9, 'SPD', 'Firgue', 'Catoon', 'no limit', 10000000, 400, 20),
						(10, 'Kamen Rider', 'Firgue', 'Catoon', 'no limit', 10000000, 400, 20),
						(11, 'Catan', 'Broad Game', 'Broad Game', 'no limit', 10000000, 1000, 20),
						(12, 'Hunter', 'Broad Game', 'Broad Game', 'no limit', 10000000, 1000, 20),
						(13, 'chess', 'Broad Game', 'Broad Game', 'no limit', 10000000, 1000, 20),
						(14, 'Ca Ngua', 'Broad Game', 'Broad Game', 'no limit', 10000000, 1000, 20),
						(15, 'Co Ti Phu', 'Broad Game', 'Broad Game', 'no limit', 10000000, 1000, 20)
go

create procedure HeavyToys as
select * from Toys 
where Netweight > 500
go

create procedure PriceIncrease as
select * from Toys
update Toys
set UnitPrice = UnitPrice + 10000
go

create procedure QtyOnHand as
select * from Toys 
update Toys 
set QtyOnHand = QtyOnHand - 5
go

exec HeavyToys
go

exec PriceIncrease
go

exec QtyOnHand
go

drop table Toys
go

drop procedure PriceIncrease
go

drop procedure QtyOnHand
go

select * from Toys
go

/* Phan 3*/
exec SP_helptext 'HeavyToys'
go

exec SP_helptext 'PriceIncrease'
go

exec SP_helptext 'QtyOnHand'
go

select OBJECT_DEFINITION ( OBJECT_ID('HeavyToys'))
go

select OBJECT_DEFINITION ( OBJECT_ID('PriceIncrease'))
go

select OBJECT_DEFINITION ( OBJECT_ID('QtyOnHand'))
go


SELECT definition FROM sys.sql_modules WHERE object_id = OBJECT_ID('HeavyToys')
go

SELECT definition FROM sys.sql_modules WHERE object_id = OBJECT_ID('PriceIncrease')
go

SELECT definition FROM sys.sql_modules WHERE object_id = OBJECT_ID('QtyOnHand');
go

exec sp_depends 'HeavyToys'
go

exec sp_depends 'PriceIncrease'
go

exec sp_depends 'QtyOnHand'
go

alter procedure PriceIncreace as
update Toys Set UnitPrice = UnitPrice + 10000
go
select * from Toys 
go

alter procedure QtyOnHand as
select * from Toys 
update Toys 
set QtyOnHand = QtyOnHand - 5
go
select * from Toys 
go

create Procedure SpecificPriceIncrease as
update Toys set UnitPrice = UnitPrice + QtyOnHand
go
select * from Toys 
go

alter procedure SpecificPriceIncrease 
	@number int output
as 
update Toys set UnitPrice = UnitPrice + QtyOnHand
select ProductCode, Name, UnitPrice as Price, QtyOnHand from Toys
where QtyOnHand >0
select @number = @@ROWCOUNT
go
declare @num int 
Exec SpecificPriceIncrease
@num output
print @num

alter procedure SpecificPriceIncrease 
@number int output
as
update Toys set UnitPrice = UnitPrice + QtyOnHand
select ProductCode, Name, UnitPrice 
as Price, QtyOnHand 
from Toys 
where QtyOnHand > 0
select @number = @@ROWCOUNT
exec HeavyToys

drop procedure SpecificPriceIncrease
go