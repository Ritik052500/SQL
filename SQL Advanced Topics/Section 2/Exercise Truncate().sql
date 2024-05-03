use AdventureWorks2019;
-- Exercise 1
create table #Orders
(
OrderDate datetime
,OrderMonth date
,TotalDue money
,OrderRank int
)

insert into #Orders
(
OrderDate 
,OrderMonth 
,TotalDue 
,OrderRank 
)
select
OrderDate
,OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,TotalDue
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
from Sales.SalesOrderHeader;

create table #NotTop10Orders
(
OrderMonth date
,OrderType varchar(32)
,NotTop10Total money
)

insert into #NotTop10Orders
(
OrderMonth
,OrderType
,NotTop10Total
)
select 
OrderMonth
,OrderType = 'Sales'
,sum(TotalDue) as NotTop10Total
from #Orders 
where OrderRank > 10 
group by OrderMonth;

--select * from #Orders;
--select * from #NotTop10Orders;
truncate table #Orders;
--drop table #NotTop10Orders;

insert into #Orders
(
OrderDate 
,OrderMonth 
,TotalDue 
,OrderRank 
)
select
OrderDate
,OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,TotalDue
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
from Purchasing.PurchaseOrderHeader;

insert into #NotTop10Orders
(
OrderMonth
,OrderType
,NotTop10Total
)
select 
OrderMonth
,OrderType = 'Purchase'
,sum(TotalDue) as NotTop10Total
from #Orders 
where OrderRank > 10 
group by OrderMonth;

select a.OrderMonth,a.NotTop10Total as TotalSales,b.NotTop10Total as TotalPurchases from #NotTop10Orders a
left join #NotTop10Orders b 
on a.OrderMonth = b.OrderMonth
where b.OrderType = 'Purchase'
and a.OrderType = 'Sales'
order by 1;

drop table #Orders;
drop table #NotTop10Orders;

