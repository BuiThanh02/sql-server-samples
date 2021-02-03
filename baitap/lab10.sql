create database CitySoftWare
go

use CitySoftWare
go

create table Employee(
	EmployeeID int primary key,
	Name varchar(100),
	Tel char(11),
	Email varchar(30)
)
go

insert into Employee values (1, 'Bui Huu Thanh', '0942883190', 'buithanh281002@gmail.com'),
							(2, 'Chu Duc Tung', '0974525739', 'chutung@gmail.com'),
							(3, 'Hoang Manh Cuong', '0948364825', 'hoangcuong@gmail.com'),
							(4, 'Hoang Thanh Trung', '0974539284', 'hoangtrung@gmail.com'),
							(5, 'Pham Thanh Long', '0973940567', 'phamlong@gmail.com'),
							(6, 'Nguyen Duy Anh', '0928467037', 'nguyenanh@gmail.com')
go

create table Groups(
	GroupID int primary key,
	GroupName varchar(30),
	LeaderID int,
	ProjectID int,
	constraint pid foreign key (ProjectID) references Project(ProjectID)
)
go

insert into Groups values (1, 'BHT', 1, 1),
							(2, 'CDT', 2, 2)
go

create table Project(
	ProjectID int primary key,
	ProjectName varchar(30),
	StartDate datetime,
	EndDate datetime,
	Period int,
	cost money
)
go

insert into Project values (1, 'Chinh Phu Dien Tu', 1/1/2021, 5/1/2021, 4, 1000000000),
							(2, 'Cong Nghiep Dien Tu', 1/1/2021, 5/1/2021, 4, 1000000000)
go

create table GroupDetail(
	GroupID int,
	EmployeeID int,
	Status char(20),
	constraint gid foreign key (GroupID) references Groups(GroupID),
	constraint eid foreign key (EmployeeID) references Employee(EmployeeID)
)
go

insert into GroupDetail values (1, 1, 'improgress'),
								(2, 2, 'improgress'),
								(1, 3, 'improgress'),
								(2, 4, 'improgress'),
								(1, 5, 'improgress'),
								(2, 6, 'improgress')
go

select * from Employee
go

select e.EmployeeID, e.Name, g.EmployeeID, g.GroupID, gs.GroupID, gs.ProjectID from Employee e
join GroupDetail as g on e.EmployeeID = g.EmployeeID
join Groups as gs on g.GroupID = gs.GroupID
where ProjectID = 1
go

select count(EmployeeID) as 'So luong nhan vien tai nhom 1' from GroupDetail
where GroupID = 1
go

select count(EmployeeID) as 'So luong nhan vien tai nhom 2' from GroupDetail
where GroupID = 2
go

select r.LeaderID, r.GroupID, gd.GroupID, gd.EmployeeID, m.* from Groups r
join GroupDetail  as gd on r.GroupID = gd.GroupID
join Employee as m on gd.EmployeeID = m.EmployeeID
go

select p.*, d.*, t.*, j.* from Employee p
join GroupDetail as d on p.EmployeeID = d.EmployeeID
join Groups as t on d.GroupID = t.GroupID
join Project as j on t.ProjectID = j.ProjectID
where Status = 'improgress' and StartDate < 10/12/2021
go

select y.EmployeeID, y.Name, k.EmployeeID, k.GroupID from Employee y
join GroupDetail as k on y.EmployeeID= k.EmployeeID
where GroupID = 1
go

select y.EmployeeID, y.Name, k.EmployeeID, k.GroupID from Employee y
join GroupDetail as k on y.EmployeeID= k.EmployeeID
where GroupID = 2
go

select p.*, d.*, t.*, j.* from Employee p
join GroupDetail as d on p.EmployeeID = d.EmployeeID
join Groups as t on d.GroupID = t.GroupID
join Project as j on t.ProjectID = j.ProjectID
where Status = 'improgress'
go

alter table Project
	add constraint ck check(StartDate < EndDate)
go

alter table Employee
	alter column Name varchar(100) not null
go

alter table GroupDetail 
	add constraint ck2 check (Status = 'improgress' or Status = 'pending' or Status = 'done')
go

alter table Project
	add constraint ck3 check (Cost > 1000)
go

alter table Groups 
	add constraint fk foreign key (LeaderID) references Employee(EmployeeID)
go

alter table Employee
	add constraint ck4 check (Tel = '0%')
go

create procedure CostIncrease as 
select * from Project
update Project
set Cost = 1.1 * Cost 
where Cost <2000000000
select * from CostIncrease 
go

create procedure ImProject as
select p.GroupID, p.Status, e.GroupID, e.ProjectID, d.* from GroupDetail p
join Groups as e on p.GroupID = e.GroupID
join Project as d on e.ProjectID = d.ProjectID
go

Create unique index IX_Group 
on GroupDetail (GroupID, EmployeeID)
go

create index IX_Project 
on Project (ProjectName, StartDate, EndDate)
go

create view Employ as
select e.*, g.* from Employee e
join GroupDetail as g on e.EmployeeID = g.EmployeeID
go

create view Names as
select e.Name, e.EmployeeId, g.EmployeeID, g.GroupID, g.Status, r.GroupID, r.GroupName, r.ProjectID, p.ProjectID, p.ProjectName from Employee e
join GroupDetail as g on e.EmployeeID = g.EmployeeID
join Groups as r on g.GroupID = r.GroupID
join Project as p on r.ProjectID = p.ProjectID
group by Name, GroupName, ProjectName, Status
go