use test;
go

create trigger TR_Basket_insert_update on dbo.Basket after insert
as
	set nocount on;

	if (select count(*) from dbo.Basket group by ID_SKU) >= 2
		update dbo.Basket
		set DiscountValue = dbo.Basket.Value * 0.05
go