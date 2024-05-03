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

create table #Top10Orders
(
OrderMonth date
,OrderType varchar(32)
,Top10Total money
)

insert into #Top10Orders
(
OrderMonth
,OrderType
,Top10Total
)
select 
OrderMonth
,OrderType = 'Sales'
,sum(TotalDue) as Top10Total
from #Orders 
where OrderRank <= 10 
group by OrderMonth;

truncate table #Orders;

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

insert into #Top10Orders
(
OrderMonth
,OrderType
,Top10Total
)
select 
OrderMonth
,OrderType = 'Purchase'
,sum(TotalDue) as Top10Total
from #Orders 
where OrderRank <= 10 
group by OrderMonth;

select * from #Top10Orders order by OrderMonth;

drop table #Orders;
drop table #Top10Orders;
