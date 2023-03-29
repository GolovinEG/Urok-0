use test;

if OBJECT_ID('dbo.GetSKUPrice') is not null drop function dbo.GetSKUPrice;
go

create function dbo.GetSKUPrice
(
	@ID_SKU as int
)
returns decimal(18, 2)
as
	begin
		return 
			(select sum(Value) as SKU_Value
			FROM dbo.Basket
			WHERE ID_SKU = @ID_SKU) /
			(select sum(Quantity) as SKU_Quantity
			FROM dbo.Basket
			WHERE ID_SKU = @ID_SKU) 
	end;
go