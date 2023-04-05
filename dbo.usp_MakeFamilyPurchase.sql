use test;

if object_id('MakeFamilyPurchse', 'P') is not null drop proc MakeFamilyPurchse;
go

create proc MakeFamilyPurchse
	@FamilySurName as varchar(255)

as
		if (select count(*) from dbo.Family where dbo.Family.SurName = @FamilySurName) > 0
			update dbo.Family
			set BudgetValue = BudgetValue - (select sum(Value)
											from dbo.Basket
											where dbo.Basket.ID_Family = dbo.Family.ID)
			where dbo.Family.SurName = @FamilySurName;
		else print(N'Нет семьи с данной фамилией.')
go