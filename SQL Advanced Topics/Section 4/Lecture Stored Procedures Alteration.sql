USE [AdventureWorks2019]
GO

/****** Object:  StoredProcedure [dbo].[OrdersReport]    Script Date: 10/21/2022 1:45:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[OrdersReport] (@Top int)

as 

begin

	select * from 
	(
		select 
			b.Name
			,LineTotalSum = sum(LineTotal)
			,LineTotalSumRank = DENSE_RANK() over (order by sum(LineTotal) desc)
				from AdventureWorks2019.Sales.SalesOrderDetail a
					join AdventureWorks2019.Production.Product b
					on a.ProductID = b.ProductID
						group by b.name
	) table1
		where LineTotalSumRank <= @Top;

end;


GO

exec dbo.OrdersReport 10;


