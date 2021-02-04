/* Cau 1 */

create database SellingPoint 
go

use SellingPoint
go

/* Cau 2 */

create table Categories(
	CateID char(6) primary key,
	CateName nvarchar(100) not null,
	Description nvarchar(200)
)
go

create table Parts(
	PartID int primary key identity,
	PartName nvarchar(100) not null,
	CateID char(6) foreign key references Categories(CateID),
	Description nvarchar(1000),
	Price money not null default '0',
	Quantity int default '0',
	Warranty int default '1',
	Photo nvarchar(200) default 'photo/nophoto.png'
)
go

/* Cau 3 */

insert into Categories values ('RAM', 'RAM', 'Help our computer tun faster'),
								('CPU', 'CPU', 'Central Processing Unit'),
								('HDD', 'HDD', 'More space for our computer memories')
go

insert into Parts(PartName, CateID, Description, Price, Quantity) values ('RAM DDR3', 'RAM', 'Hot sale', 30, 10),
																			('CPU Intel', 'CPU', 'Hot sale', 300, 10),
																			('CPU Intel 2', 'CPU', 'Hot sale', 300, 10),
																			('CPU Intel 3', 'CPU', 'Hot sale', 300, 10),
																			('CPU Intel 4', 'CPU', 'Hot sale', 300, 10),
																			('CPU Intel 5', 'CPU', 'Hot sale', 300, 10),
																			('HDD Seagate 1TB', 'HDD', 'Hot sale', 10, 10)
go

/* Cau 4 */

select PartName from Parts
where Price > 100
go

/* Cau 5 */

select c.CateName, p.PartName from Categories c
join Parts as p on c.CateID = p.CateID
go

/* Cau 6 */

create view V_Part as 
select c.CateName, p.PartName, p.Price, p.Quantity, p.PartID from Categories c
join Parts as p on c.CateID = p.CateID
go

/* Cau 7 */

create view V_TopParts as
select PartName, Price from Parts
where @@ROWCOUNT <=5
Order by Price desc
go