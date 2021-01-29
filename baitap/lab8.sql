create database Lab11
go

use Lab11
go

create view ProductList
as 
	select ProductID, Name from AdventureWorks2019.Production.Product
go

select * from ProductList
go

create view SaleOrderDetail
as 
	select pr.ProductID, pr.Name, od.UnitPrice, od.OrderQty,od.UnitPrice*od.OrderQty as [Total Price]
	from AdventureWorks2019.Sales.SalesOrderDetail od
	join AdventureWorks2019.Production.Product pr
on od.ProductID=pr.ProductID
go

select * from SaleOrderDetail
go

use AdventureWorks2019
go

create view V_Contact_Info as
select FirstName, MiddleName, LastName
from Person.Person
go

create view V_Employee_Contact as
select p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate
from HumanResources.EMployee e
join Person.Person as p on e.BusinessEntityID=p.BusinessEntityID;
go

select * from V_Employee_Contact
go

alter view V_Employee_Contact as
select p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate, e.BirthDate
from HumanResources.EMployee e
join Person.Person as p on e.BusinessEntityID=p.BusinessEntityID
where p.FirstName like '%B%';
go

drop view V_Contact_Info
go

execute sp_helptext 'V_Employee_Contact'

execute sp_depends 'V_Employee_Contact'
go

create view OrderRejects
with ENCRYPTION
as 
select PurchaseOrderID, ReceivedQty, ReceivedQty, RejectedQty / ReceivedQty as RejectRatio, DueDate
from Purchasing.PurchaseOrderDetail
where RejectedQty / ReceivedQty > 0
and DueDate > convert (Datetime, '20010630', 101);

alter view V_Employee_Contact as
select p.FirstName, p.LastName, e.BusinessEntityID, e.HireDate
from HumanResources.EMployee e
join Person.Person as p on e.BusinessEntityID=p.BusinessEntityID
where p.FirstName like 'A%'
with check option
go 

select * from V_Employee_Contact

update V_Employee_Contact set FirstName='Atest' where LastName='Amy'

update V_Employee_Contact set FirstName='BCD' where LastName='Atest'
go

drop view V_Contact_Info
go

create view V_Contact_Info with SCHEMABINDING as
select FirstName, MiddleName, LastName, EmailAddress
from Person.Contact
go

select * from V_Contact_Info
go

create unique clustered index IX_Contact_Email
on V_Contact_Info(EmailAddress)
go

exec sp_rename V_Contact_Info, V_Contact_Infomation

select *from V_Contact_Infomation

insert into V_Contact_Infomation values ('ABC', 'DEF', 'GHI', 'abc@yahoo.com')

delete from V_Contact_Infomation where LastName='Gilbert' and FirstName='Guy'

create database Book
go

use Book
go

create table BookSold(
	BookSoldID int primary key,
	CustomerID int,
	BookCode int,
	Date datetime,
	Price int,
	Amount int,
	constraint cusid foreign key (CustomerID) references Customer(CustomerID),
	constraint bcode foreign key (BookCode) references Books(BookCode)
)
go

insert into BookSold values (1, 1, 1, 1/29/2021, 20000, 1),
								(2, 1, 2, 2/29/2021, 20000, 2),
								(3, 2, 3, 3/29/2021, 20000, 1),
								(4, 2, 4, 4/29/2021, 20000, 2),
								(5, 3, 5, 5/29/2021, 20000, 1),
								(6, 3, 1, 6/29/2021, 20000, 2),
								(7, 4, 2, 7/29/2021, 20000, 1),
								(8, 4, 3, 8/29/2021, 20000, 2),
								(9, 5, 4, 9/29/2021, 20000, 1),
								(10, 5, 5, 10/29/2021, 20000, 2)
go

create table Customer(
	CustomerID int primary key,
	CustomerName varchar(50),
	Address varchar(100),
	Phone varchar(12)
)
go

insert into Customer values (1, 'Bui Huu Thanh', 'Truong Dinh', '0942883190'),
								(2, 'Chu Duc Tung', 'Luong Khanh Thien', '0946275874'),
								(3, 'Hoang Manh Cuong', 'Thanh Liet', '0986647542'),
								(4, 'Hoang Thanh Trung', 'Giai Phong', '0985746395'),
								(5, 'Pham Thanh Long', 'Minh Khai', '0947569348')
go

create table Books(
	BookCode int primary key,
	Category varchar(50),
	Author varchar(50),
	Publisher varchar(50),
	Title varchar(100),
	Price int,
	InStore int
)
go

insert into Books values (1, 'Toan Hoc', 'Thi', 'Tuoi Tre', 'Toan', 25000, 100),
							(2, 'Vat Ly', 'Thi', 'Tuoi Tre', 'Ly', 25000, 100),
							(3, 'Hoa Hoc', 'Thi', 'Tuoi Tre', 'Hoa', 25000, 100),
							(4, 'Van Hoc', 'Thi', 'Tuoi Tre', 'Van', 25000, 100),
							(5, 'Tieng Anh', 'Thi', 'Tuoi Tre', 'Anh', 25000, 100)
go

create view V_Book as
select p.BookCode, p.Title, p.Price, c.Amount, c.BookCode
from Books p
join BookSold as c on p.BookCode = c.BookCode
go

create view V_Customers as
select CustomerID, CustomerName, Address
from Customer

create view V_CustomersLast as
select a.CustomerID, a.CustomerName, a.Address, e.CustomerID, e.BookCode, d.BookCode, d.Title
from Customer
join BookSold as e on a.CustomerID = e.CustomerID
join Books as d on e.BookCode = d.BookCode
Where Date = '12/2020'

create view V_Cus as
select CustomerName 
from Customer

/* bai 4 */
create table Class(
	ClassCode varchar(10) primary key,
	HeadTeacher varchar(30),
	Room varchar(30),
	TimeSlot char,
	CloseDate datetime
)
go

insert into Class values('TH', 'Khanh', 1, 'A', 10/10/2020),
						('HH', 'Hang', 2, 'B', 10/10/2020),
						('VL', 'Huan', 3, 'C', 10/10/2020),
						('VH', 'Huong', 4, 'D', 10/10/2020),
						('TA', 'Thi', 5, 'G', 10/10/2020),
go

create table Student(
	RollNo varchar(10) primary key,
	ClassCode varchar(10),
	FullName varchar(30),
	Male bit,
	BirthDate datetime,
	Address varchar(30),
	Provide char(2),
	Email varchar(30)
	constraint cc foreign key (ClassCode) references Class(ClassCode)
)
go

insert into Student values ('TH1', 'TH', 'A.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH2', 'TH', 'B.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH3', 'HH', 'E.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH4', 'HH', 'F.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH5', 'VL', 'I.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH6', 'VL', 'K.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH7', 'VH', 'N.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH8', 'VH', 'O.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH9', 'TA', 'S.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH10', 'TA', 'R.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com'),
							('TH11', 'TA', 'C.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh28102@gmail.com'),
							('TH12', 'TA', 'D.Thanh', 1, 10/28/2002, 'Truong Dinh', 'HN', 'buithanh281002@gmail.com')
							


create table Subject(
	SubjectCode varchar(10) primary key,
	SubjectName varchar(40),
	WMark bit,
	PMark bit,
	WTest_per int,
	PTest_per int
)
go

insert into Subject values ('EPC', 'Elementary Programing with C', 1, 1, 1, 1),
							('TCC', 'Toan Cao Cap', 1, 1, 1, 1),
							('TRR', 'Toan Roi Rac', 1, 1, 1, 1),
							('CNC', 'C Nang Cao', 1, 1, 1, 1),
							('LTW', 'Lap Trinh Web', 1, 1, 1, 1),

create table Mark(
	RollNo varchar(10),
	SubjectCode varchar(10),
	WMark float,
	PMark float,
	Mark float,
	constraint rn foreign key (RollNo) references Student(RollNo),
	constraint sc foreign key (SubjectCode) references Subject(SubjectCode),
	constraint rs primary key (RollNo, SubjectCode)
)
go

insert into Mark values ('TH1', 'EPC', 1, 1, 1),
						('TH2', 'EPC', 10, 10, 10),
						('TH3', 'EPC', 1, 1, 1),
						('TH4', 'EPC', 1, 1, 1),
						('TH5', 'EPC', 10, 10, 10),
						('TH6', 'EPC', 1, 1, 1),
						('TH7', 'EPC', 10, 10, 10),
						('TH8', 'EPC', 1, 1, 1),
						('TH9', 'EPC', 10, 10, 10),
						('TH10', 'EPC', 1, 1, 1),
						('TH11', 'EPC', 10, 10, 10),
						('TH12', 'EPC', 10, 10, 10),
						('TH1', 'TCC', 1, 1, 1),
						('TH1', 'TRR', 1, 1, 1),
						('TH3', 'TCC', 1, 1, 1),
						('TH3', 'TRR', 1, 1, 1),
						('TH2', 'CNC', 10, 10, 10),
						('TH4', 'LTW', 10, 10, 10),
						('TH6', 'TCC', 10, 10, 10),
						('TH5', 'TRR', 10, 10, 10)
go

create view V_2sub as
select p.RollNo, p.FullName, e.RollNo, e.Mark
from Student p
join Mark as e on p.RollNo = e.RollNo
where Mark < 4
go

create view V_Fail1 as
select p.RollNo, p.FullName, e.RollNo, e.Mark
from Student p
join Mark as e on p.RollNo = e.RollNo
where Mark < 4
go

create view V_TimeSlotG as
select c.ClassCode, s.ClassCode, s.FullName
from Class c
join Student as s on c.ClassCode = s.ClassCode
go

create view V_EPC as
select 