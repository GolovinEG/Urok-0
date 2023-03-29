use test;

if object_id('SKUPrice') is not null drop view SKUPrice;
go

create view SKUPrice
as
select ID, Code, Name, dbo.GetSKUPrice(ID) as Price
from dbo.SKU
go