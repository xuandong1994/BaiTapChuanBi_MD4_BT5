create database IF NOT EXISTS demo;
use demo;
create table Products(
  id int primary key auto_increment,
  productCode varchar(10) ,
  productName varchar(30) not null,
  productPrice double not null check(productPrice > 0),
  productAmount int ,
  productDescription varchar (100),
  productStatus bit default true
);
insert into Products (productCode, productName, productPrice, productAmount, productDescription, productStatus) 
values ('MSP1', 'Sản Văn Phẩm', 500000.0, 5, 'aaaa', 1),
       ('MSP2', 'Sản Văn Phẩm 2', 900000.0, 5, 'aaaa', 0),
       ('MSP3', 'Sản Văn Phẩm 3', 700000.0, 5, 'aaaa', 1),
       ('MSP4', 'Sản Văn Phẩm 4', 1000000.0, 5, 'aaaa', 1),
       ('MSP5', 'Sản Văn Phẩm 5', 800000.0, 5, 'aaaa', 1);
-- Bước 3:
-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)

create unique index idx_productCode ON Products (productCode);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)

create index idx_productNamePrice ON Products (productName, productPrice);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào

explain select * from Products ;

-- Bước 4:
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.

create view viewProduct as
select productCode, productName, productPrice, productStatus from products;

-- Tiến hành sửa đổi view

alter view viewProduct as select productCode, productName, productPrice, productStatus from products
where productStatus = 1 and productName = 'Socola';

-- Tiến hành xoá view

drop view viewProduct;

-- Bước 5:
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure procedureProducts()
begin
	select*from products;
end //

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure AddNewProduct  (
	in p_productCode varchar(10),
    in p_productName varchar(30),
    in p_productPrice double,
    in p_productAmount int,
    in p_productDescription varchar(100),
    in p_productStatus bit
)
begin
	insert into Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    values (p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus);
end //
-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure updatebyid  (
	in p_productCode varchar(10),
    in p_productName varchar(30),
    in p_productPrice double,
    in p_productAmount int,
    in p_productDescription varchar(100),
    in p_productStatus bit
)
begin
	update Products set
	productCode = p_productCode,
	productName = p_productName,
	productPrice = p_productPrice,
	productAmount = p_productAmount,
	productDescription = p_productDescription,
	productStatus = p_productStatus
	where id = p_id;
end //

-- Tạo store procedure xoá sản phẩm theo id
create procedure deleteById(
	in p_id int
)
begin
	delete from Products where id = p_id;
end //

