USE [AdventureWorks2019]
GO

/****** Object:  StoredProcedure [dbo].[OrdersReport]    Script Date: 10/21/2022 2:29:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[OrdersReport] (@Top int, @OrderType int)

as 

begin

	if @OrderType = 1
		begin
			select * from 
			(
				select 
					b.Name
					,SalesLineTotalSum = sum(LineTotal)
					,SalesLineTotalSumRank = DENSE_RANK() over (order by sum(LineTotal) desc)
						from AdventureWorks2019.Sales.SalesOrderDetail a
							join AdventureWorks2019.Production.Product b
							on a.ProductID = b.ProductID
								group by b.name
			) table1
				where SalesLineTotalSumRank <= @Top;
		end

		-- can use multiple if statements or an else statement
		if @OrderType = 2
		begin
			select * from 
			(
				select 
					b.Name
					,PurchasingLineTotalSum = sum(LineTotal)
					,PurchasingLineTotalSumRank = DENSE_RANK() over (order by sum(LineTotal) desc)
						from AdventureWorks2019.Purchasing.PurchaseOrderDetail a
							join AdventureWorks2019.Production.Product b
							on a.ProductID = b.ProductID
								group by b.name
			) table1
				where PurchasingLineTotalSumRank <= @Top;
		end

end;

GO

exec dbo.OrdersReport 10, 2;
