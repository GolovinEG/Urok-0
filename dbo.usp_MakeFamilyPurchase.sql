use test;

if object_id('dbo.usp_MakeFamilyPurchse', 'P') is not null drop proc dbo.usp_MakeFamilyPurchse;
go

create proc dbo.usp_MakeFamilyPurchse
	@FamilySurName as varchar(255)

as
		if (select count(*) from dbo.Family where dbo.Family.SurName = @FamilySurName) > 0
			update dbo.Family
			set BudgetValue = BudgetValue - (select sum(Value)
											from dbo.Basket
											where dbo.Basket.ID_Family = dbo.Family.ID)
			where dbo.Family.SurName = @FamilySurName;
		else raiserror(N'Нет семьи с данной фамилией.', 0, 1) with nowait
go