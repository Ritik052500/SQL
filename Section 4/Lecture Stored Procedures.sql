
create procedure dbo.OrdersReport

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
		where LineTotalSumRank <= 10;

end;

exec dbo.OrdersReport;

drop procedure dbo.OrdersReport;

