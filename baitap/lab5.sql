create database company
go

use company
go

create table DonDatHang(
	Ma_So_Don_Hang int,
	Nguoi_Dat_Hang nvarchar(100),
	Dia_Chi nvarchar(1000),
	Dien_Thoai int,
	Ngay_Dat_Hang datetime
)
go

insert into DonDatHang values (123, 'Nguyen Van An', '111 Nguyen Trai, Thanh Xuan, Ha Noi', 987654321, '11/18/09')

create table DanhSach(
	STT int identity,
	Ten_Hang nvarchar(1000),
	Mo_Ta_Hang nvarchar(1000),
	Don_Vi nvarchar(100),
	Gia money,
	So_Luong int,
	Thanh_Tien money
)
go

insert into  DanhSach (Ten_Hang, Mo_Ta_Hang, Don_Vi, Gia, So_Luong, Thanh_Tien) 
	values ('May Tinh T450', 'May nhap moi', 'Chiec', 1000, 1, 1000),
			('Dien Thoai Nokia5670', 'Dien thoai dang hot', 'Chiec', 200, 2, 400),
			('May In Samsung450', 'May in dang e', 'Chiec', 100, 1, 100)

SELECT SUM(Thanh_Tien) AS "Tong Tien"
FROM DanhSach

create table Customers(
	Ten_Khach_Hang nvarchar(100),
	Ma_Khanh_Hang nvarchar(100),
	Dia_Chi nvarchar(1000),
	Dien_Thoai int, 
	Email nvarchar(100)
)
go

create table OrderList (
	Ten_Khach_Hang nvarchar(100),
	Ma_So_Don_Hang int,
	Ngay_Dat_Hang datetime,
	Chu_Thich nvarchar(1000) NULL,
	Co_So nvarchar(100)
)
go

create table OrderDetails(
	Ten_Khach_Hang nvarchar(100),
	Ma_Khach_Hang int,
	Dien_Thoai int,
	Ma_So_Don_Hang int,
	Co_So nvarchar(100),
	Ngay_Dat_Hang datetime,
	Ten_Hang nvarchar(1000),
	Mo_Ta_Hang nvarchar(1000),
	Don_Vi nvarchar(100),
	Gia money,
	So_Luong int,
	Thanh_Tien money
)
go

create table Product(
	Ten_Hang nvarchar(1000),
	Ten_Loai_Hang nvarchar(100),
	Ma_Hang int,
	Don_Vi nvarchar(100),
	Mo_Ta_Hang nvarchar(1000),
	Gia money,
	So_Luong int ,
	So_Mat_Hang_Da_Ban int
)
go

create table Category(
	Ten_Loai_Hang nvarchar(100),
	Ma_Loai_Hang int,
	So_Luong int
)

select * from DonDatHang
go

select * from DanhSach
go

select * from Customers
go

select * from OrderDetails
go

select * from OrderList
go

select * from Product
go

select * from Category
go

select * from Customers
	order by Ten_Khach_Hang desc
go

select * from Product
	order by Gia desc
go

select * from OrderDetails
	where Ten_Khach_Hang = 'Nguyen Van An'
go

select count(Ten_Khach_Hang) as "So Khach Hang Da Mua Tai Co So 1" from OrderList
	where Co_So = 1
go

select sum(So_Mat_Hang_Da_Ban) as "So Mat Hang Da Ban" from Product
go

alter table Product 
	add constraint gia check (Gia > 0)
go

alter table OrderList
	add constraint nagydathang check (Ngay_Dat_Hang < curdate())
go

alter table Product
	add Ngay_Xuat_Hien datetime
go

create index ind on OrderDetails (Ten_Hang, Ten_Khach_Hang)
go

create view View_KhachHang as
	select Ten_Khach_Hang, Dia_Chi, Dien_Thoai
	from Customers
go

create view View_SanPham as
	select Ten_Hang, Gia 
	from Product
go

create View View_KhachHang_SanPham as
	select Ten_Khach_Hang, Dien_Thoai, Ten_Hang, So_Luong, Ngay_Dat_Hang
	from OrderDetails
go

create proc SP_TimKH_MaKH 
	@Ma_Khach_Hang int,
	@Ten_Khach_Hang nvarchar(100) output
	as
	select * from Customers
	go
	execute SP_TimKH_MaKH 123
	go

create proc SP_TimKH_MaHD
	@Ma_Don_Hang int,
	@Teen_Khach_Hang nvarchar(100) output
	as
	select * from OrderDetails
	go
	execute SP_TimKH_MaHD 123
	go

