use test;

if object_id('dbo.Basket' , 'u') is not null drop table dbo.Basket;
if object_id('dbo.SKU' , 'u') is not null drop table dbo.SKU;

create table dbo.SKU 
(
	ID int not null identity(1,1)
		constraint PK_SKU_ID primary key(ID),
	Code as 's' + cast(ID as varchar)
		constraint UNQ_SKU_Code unique(Code),
	Name varchar(50) not null
);

if object_id('dbo.Family' , 'u') is not null drop table dbo.Family;

create table dbo.Family
(
	ID int not null identity(1,1)
		constraint PK_Family_ID primary key(ID),
	SurName varchar(255) not null,
	BudgetValue int not null
);

create table dbo.Basket
(
	ID int not null identity(1,1)
		constraint PK_Basket_ID primary key(ID),
	ID_SKU int not null,
	ID_Family int not null,
	Quantity int not null
		constraint CHK_Basket_Quantity check(Quantity >= 0),
	Value int not null
		constraint CHK_Basket_Value check(Value >= 0),
	PurchaseDate date not null default getdate(),
	DiscountValue int not null default 0
);