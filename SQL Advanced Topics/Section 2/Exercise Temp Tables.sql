use AdventureWorks2019;
-- Exercise 1
select
OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
,TotalDue
into #Purchases
from Purchasing.PurchaseOrderHeader;

select
OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
,TotalDue
into #Sales
from Sales.SalesOrderHeader;

select 
OrderMonth
,sum(TotalDue) as NotTop10Purchase
into #NotTop10Purchases
from #Purchases
where OrderRank > 10
group by OrderMonth;

select 
OrderMonth
,sum(TotalDue) as NotTop10Sale
into #NotTop10Sales
from #Sales 
where OrderRank > 10 
group by OrderMonth;

select s.OrderMonth,s.NotTop10Sale,p.NotTop10Purchase from #NotTop10Sales s
join #NotTop10Purchases p on s.OrderMonth = p.OrderMonth
order by s.OrderMonth;

drop table #Purchases;
drop table #Sales;
drop table #NotTop10Purchases;
drop table #NotTop10Sales;
