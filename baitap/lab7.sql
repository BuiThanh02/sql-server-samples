create database lab10

use AdventureWorks2019
select * into lab10.dbo.WorkOrder from Production.WorkOrder

use lab10
select * into WorkOrderIX from WorkOrder

select * from WorkOrder
select * from WorkOrderIX

create index IX_WorkOrderID on WorkOrderIX(WorkOrderID)

select * from WorkOrder where WorkOrderID=72000

select * from WorkOrderIX where WorkOrderID=72000

create database CodeLean
go

use CodeLean
go

create table Classes(
	ClassName char(6),
	Teacher varchar(30),
	TimeSlot varchar(30),
	Class int,
	Lab int
)
go

insert into Classes values ('TA', 'Thi', '3', '1', '2'),
							('TH', 'Thi', '6', '3', '4'),
							('VL', 'Thi', '9', '5', '6'),
							('HH', 'Thi', '12', '7', '8'),
							('NV', 'Thi', '15', '9', '10')
go

create unique clustered index MyClusteredIndex on Classes(ClassName)
go

Create nonclustered index TeacherIndex on Classes(Teacher)
go

drop index TeacherIndex on Classes
go

alter index MyClusteredIndex on Classes rebuild with (fillfactor = 30)
go

create index ClassLabIndex on Classes(Class, Lab)
go

exec sp_helpindex 'Classes'
go

create database RiverPlate 
go

use RiverPlate
go

create table Student(
	StudentNo int PRIMARY KEY,
	StudentName nvarchar(50),
	StudentAddress nvarchar(100),
	PhoneNo int
)
go

insert into Student values (1, 'Bui Huu Thanh', 'Truong Dinh', 0942883190),
							(2, 'Chu Duc Tung', 'Luong Khanh Thien', 0946738247),
							(3, 'Pham Thanh Long', 'Minh Khai', 0946283746),
							(4, 'Kim Duc Dung', 'Minh Khai', 0935482436),
							(5, 'Nguyen Duy Anh', 'Truong Dinh', 0946384653),
							(6, 'Pham Le Duy', 'Den Lu', 094634756),
							(7, 'Hoang Manh Cuong', 'Thanh Liet', 0956475645),
							(8, 'Hoang Thanh Trung', 'Giai Phong', 0967674536)
go

create table Department(
	DeptNo int PRIMARY KEY,
	DeptName nvarchar(50),
	ManagerName nvarchar(30)
)
go

insert into Department values (1, 'nhom1', 'Thi'),
								(2, 'nhom2', 'Hang')
go

create table Assignment(
	AssignmentNo int primary key,
	Description nvarchar(100)
)
go

insert into Assignment values (1, 'toan'),
								(2, 'ly')
go

create table Work_Assign(
	JobID int primary key,
	StudentNo int,
	AssignmentNo int,
	TotalHours int,
	JobDetails nvarchar(450),
	constraint stu foreign key (StudentNo) references Student(StudentNo),
	constraint Assign foreign key (AssignmentNo) references Assignment(AssignmentNo)
)
go

insert into Work_Assign values (1, 1, 1, 3, 'chuong1'),
								(2, 2, 2, 3, 'chuong1'),
								(3, 3, 1, 3, 'chuong2'),
								(4, 4, 2, 3, 'chuong2'),
								(5, 5, 1, 3, 'chuong3'),
								(6, 6, 2, 3, 'chuong3'),
								(7, 7, 1, 3, 'chuong4'),
								(8, 8, 2, 3, 'chuong4')
go

alter index IX_Student on Student rebuild 
go

create nonclustered index IX_Dept on Department(DeptName, ManagerName)
go
