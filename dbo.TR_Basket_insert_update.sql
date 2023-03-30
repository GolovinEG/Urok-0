use test;
go

create trigger TR_Basket_insert_update on dbo.Basket after insert
as
	set nocount on;

	update dbo.Basket
	set DiscountValue = dbo.Basket.Value * 0.05
	from dbo.Basket
		join dbo.SKU on dbo.SKU.ID = dbo.Basket.ID_SKU
	where (select count(*) from inserted where dbo.SKU.ID = inserted.ID_SKU group by ID_SKU) >= 2;
go