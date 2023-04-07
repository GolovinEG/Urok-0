use test;
go

create trigger dbo.TR_Basket_insert_update on dbo.Basket after insert
as
	set nocount on;

	update dbo.Basket
	set DiscountValue = case
		when (select count(*) from inserted where dbo.SKU.ID = inserted.ID_SKU group by ID_SKU) >= 2 then dbo.Basket.Value * 0.05
		else 0
	end
	from dbo.Basket
		join dbo.SKU on dbo.SKU.ID = dbo.Basket.ID_SKU;
go