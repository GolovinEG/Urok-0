use test;

if object_id('MakeFamilyPurchse', 'P') is not null drop proc MakeFamilyPurchse;
go

create proc MakeFamilyPurchse
	@FamilySurName as varchar(255)

as
		update dbo.Family
		set BudgetValue = BudgetValue - (select sum(Value)
										from dbo.Basket
										where dbo.Basket.ID_Family = dbo.Family.ID)
go