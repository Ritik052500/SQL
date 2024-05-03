-- exercise 1
create procedure dbo.OrdersAboveThreshold @Threshold int, @StartYear  int, @EndYear int
as
begin
select * from AdventureWorks2019.Sales.SalesOrderHeader
where TotalDue > @Threshold
and year(OrderDate) between @StartYear and @EndYear;
end;

exec dbo.OrdersAboveThreshold 100000,2012,2013;

drop procedure dbo.OrdersAboveThreshold;