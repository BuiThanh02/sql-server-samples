create database BookLibrary
go

use BookLibrary
go

create table Book(
	BookCode int,
	BookTitle varchar(100) NOT NULL,
	Author varchar(50) NOT NULL,
	Edition int,
	BookPrice money,
	Copies int,
	constraint bookc PRIMARY KEY (BookCode)
)
go

insert into Book values (1, 'toan', 'NXBGD', 5, 20.50, 300)
insert into Book values (2, 'ly', 'NXBGD', 5, 20.50, 300)
insert into Book values (3, 'hoa', 'NXBGD', 5, 20.50, 300)
insert into Book values (4, 'van', 'NXBGD', 5, 20.50, 300)
insert into Book values (5, 'anh', 'NXBGD', 5, 20.50, 300)

create table Member(
	MemberCode int,
	Name varchar(50) NOT NULL,
	Address varchar(100) NOT NULL,
	PhoneNumber int,
	constraint memc PRIMARY KEY (MemberCode)
)
go

insert into Member values (1, 'BUI HUU THANH', 'Truong Dinh', 0942883190)
insert into Member values (2, 'HOANG MANH CUONG', 'Thanh Liet', 0942883190)
insert into Member values (3, 'CHU DUC TUNG', 'Nguyen Duc Canh', 0942883190)
insert into Member values (4, 'KIM DUC DUNG', 'Minh Khai', 0942883190)
insert into Member values (5, 'PHAM THANH LONG', 'Minh Khai', 0942883190)
insert into Member values (6, 'HOANG THANH TRUNG', 'Giai Phong', 0942883190)
insert into Member values (7, 'NGUYEN DUY ANH', 'Truong Dinh', 0942883190)
insert into Member values (8, 'PHAM LE DUY', 'Den Lu', 0942883190)

create table IssueDetails(
	BookCode int,
	MemberCode int,
	IssueDate datetime,
	ReturnDate datetime
	CONSTRAINT bc FOREIGN KEY (BookCode) REFERENCES Book(BookCode),
	CONSTRAINT mc FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode)
)
go

insert into IssueDetails values (1, 1, 10/3, 10/4)
insert into IssueDetails values (1, 1, 10/3, 10/4)
insert into IssueDetails values (1, 1, 10/3, 10/4)

alter table IssueDetails
	drop CONSTRAINT bc,
	constraint mc

alter table Member
	drop constraint memc

alter table Book
	drop constraint bookc

alter table Member
	add constraint MemberCode PRIMARY KEY (MemberCode)
	
alter table Member
	add constraint Phone unique (PhoneNumber)

alter table Book
	add constraint BookCode PRIMARY KEY (BookCode),
	constraint BookPrice Check (BookPrice < 200 and BookPrice > 0 )

alter table IssueDetails
	add CONSTRAINT bc FOREIGN KEY (BookCode) REFERENCES Book(BookCode),
	CONSTRAINT mc FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode)
	
alter table IssueDetails
	alter column BookCode int NOT NULL 

alter table IssueDetails
	alter column MemberCode int NOT NULL

ALTER TABLE IssueDetails 
   ADD CONSTRAINT PK PRIMARY KEY (BookCode, MemberCode);

select * from Book
go

select * from Member
go

select * from IssueDetails
go

drop database BookLibrary
go

drop table Book
go

drop table Member
go

drop table IssueDetails
go