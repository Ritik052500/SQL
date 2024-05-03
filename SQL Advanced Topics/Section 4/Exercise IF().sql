-- Exercise 1
USE [AdventureWorks2019]
GO

/****** Object:  StoredProcedure [dbo].[OrdersAboveThreshold]    Script Date: 10/21/2022 2:38:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[OrdersAboveThreshold] @Threshold int, @StartYear int, @EndYear int, @OrderType int
as
begin

	if @OrderType = 1
		begin
			select * from AdventureWorks2019.Sales.SalesOrderHeader
			where TotalDue > @Threshold
			and year(OrderDate) between @StartYear and @EndYear;
		end;
	if @OrderType = 2
		begin
			select * from AdventureWorks2019.Purchasing.PurchaseOrderHeader
			where TotalDue > @Threshold
			and year(OrderDate) between @StartYear and @EndYear;
		end
end
GO

exec dbo.OrdersAboveThreshold 100000,2012,2013,2;

-- Exercise 2

/****** Object:  StoredProcedure [dbo].[OrdersAboveThreshold]    Script Date: 10/21/2022 2:38:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[OrdersAboveThreshold] @Threshold int, @StartYear int, @EndYear int, @OrderType int
as
begin

	if @OrderType = 1
		begin
			select * from AdventureWorks2019.Sales.SalesOrderHeader
			where TotalDue > @Threshold
			and year(OrderDate) between @StartYear and @EndYear;
		end;
	if @OrderType = 2
		begin
			select * from AdventureWorks2019.Purchasing.PurchaseOrderHeader
			where TotalDue > @Threshold
			and year(OrderDate) between @StartYear and @EndYear;
		end
	if @OrderType = 3
		begin
			create table #Orders
				(
				ID int
				,OrderDate date
				,TotalDue money
				)

				insert into #Orders
				(ID,OrderDate,TotalDue)
				select SalesOrderID,OrderDate,TotalDue 
				from AdventureWorks2019.Sales.SalesOrderHeader;

				insert into #Orders
				(ID,OrderDate,TotalDue)
				select PurchaseOrderID,OrderDate,TotalDue 
				from AdventureWorks2019.Purchasing.PurchaseOrderHeader;

				select * from #Orders
				where TotalDue > @Threshold
				and year(OrderDate) between @StartYear and @EndYear;

				drop table #Orders
		end
end
GO

exec dbo.OrdersAboveThreshold 100000,2012,2013,3;