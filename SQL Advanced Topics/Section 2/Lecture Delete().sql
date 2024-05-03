use AdventureWorks2019;
create table #Sales
(
OrderDate date
,OrderMonth date
,TotalDue money
,OrderRank int
)

insert into #Sales
(
OrderDate
,OrderMonth
,TotalDue
,OrderRank
)
select 
OrderDate
,OrderMonth = DATEFROMPARTS(year(OrderDate),MONTH(OrderDate),1) 
,TotalDue
,OrderRank = ROW_NUMBER() over(partition by month(OrderDate) order by TotalDue desc)
from Sales.SalesOrderHeader;

delete from #Sales
where OrderRank > 10;

select * from #Sales;
drop table #Sales;