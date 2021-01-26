create database Company1
go

use Company1
go

create table Product(
	ProductID int primary key,
	Name nvarchar(100),
	Description nvarchar(100),
	Unit nvarchar(100),
	Price money,
	Qty int,
	CategoryID int,
	soled int,
	constraint fk foreign key (CategoryID) references Category(CategoryID)
)
go

insert into Product values (1, 'MACBOOK', 'no', 'chiec', 50000000, 5, 1, 5),
							(2, 'IPHONE', 'no', 'chiec', 20000000, 10, 1, 5),
							(3, 'SAMSUNG Phone', 'no', 'chiec', 10000000, 10, 2, 5),
							(4, 'SAMSUNG Print', 'no', 'chiec', 5000000, 5, 2, 5),
							(5, 'SONY TV', 'no', 'chiec', 30000000, 5, 3, 5),
							(6, 'SONY Phone', 'no', 'chiec', 15000000, 10, 3, 5),
							(7, 'ASUS PC', 'no', 'chiec', 20000000, 10, 4, 5)
go

create table Category(
	CategoryID int PRIMARY KEY,
	Name nvarchar(100),
	Qty int,
	Address nvarchar(100),
	Phone int
)
go

insert into Category values (1, 'APPLE', 2, 'AMERICA', 096478356),
								(2, 'SAMSUNG', 2, 'KOREA', 094582438),
								(3, 'SONY', 2, 'JAPAN', 0923175368),
								(4, 'ASUS', 1, 'TAIWAN', 0954825617)
go

select Name from Category
go

select Name from Product
go

select Name from Category
	order by Name desc
go

select Name from Product
	order by Price desc
go

select * from Category
	where CategoryID = 4
go

select Name from Product
	where Qty < 11
go

select * from Product
	where CategoryID = 4
go

select count(Name) from Category as "So hang san pham cua cua hang"
go

select Sum(soled) from Product as "So mat hang da ban"
go

select Name, Qty from Category
go

alter table Product 
	add constraint Price  Check (Price > 0)
go

alter table Product
	alter column Phone 