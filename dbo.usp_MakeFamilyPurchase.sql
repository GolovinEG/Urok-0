use test;

if object_id('dbo.usp_MakeFamilyPurchse', 'P') is not null drop proc dbo.usp_MakeFamilyPurchse;
go

create proc dbo.usp_MakeFamilyPurchse
	@FamilySurName as varchar(255)

as
	begin try
		if (select count(*) from dbo.Family where dbo.Family.SurName = @FamilySurName) > 0
			update dbo.Family
			set BudgetValue = BudgetValue - (select sum(Value)
											from dbo.Basket
											where dbo.Basket.ID_Family = dbo.Family.ID)
			where dbo.Family.SurName = @FamilySurName;
		else raiserror(N'Нет семьи с данной фамилией.', 16, 1) with nowait
	end try
	begin catch
		declare @ErrorMessage nvarchar(4000);
		declare @ErrorSeverity int;
		declare @ErrorState int;

		select
			@ErrorMessage = error_message(),
			@ErrorSeverity = error_severity(),
			@ErrorState = error_state();
		raiserror(@ErrorMessage, @ErrorSeverity, @ErrorState);
	end catch;
go