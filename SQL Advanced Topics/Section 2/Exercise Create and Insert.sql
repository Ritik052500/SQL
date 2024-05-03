use AdventureWorks2019;
-- Exercise 1
create table #Sales
(
OrderDate datetime
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
,OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,TotalDue
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
from Sales.SalesOrderHeader;

create table #NotTop10Sales
(
OrderMonth date
,NotTop10Sales money
)

insert into #NotTop10Sales
(
OrderMonth
,NotTop10Sales
)
select 
OrderMonth
,sum(TotalDue) as Top10Sale
from #Sales 
where OrderRank > 10 
group by OrderMonth;

create table #Purchases
(
OrderDate datetime
,OrderMonth date
,TotalDue money
,OrderRank int
)

insert into #Purchases
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

create table #NotTop10Purchases
(
OrderMonth date
,NotTop10Purchases money
)

insert into #NotTop10Purchases
(
OrderMonth
,NotTop10Purchases
)
select 
OrderMonth
,sum(TotalDue) as Top10Sale
from #Purchases 
where OrderRank > 10 
group by OrderMonth;

select s.OrderMonth,s.NotTop10Sales,p.NotTop10Purchases from #NotTop10Sales s
join #NotTop10Purchases p on s.OrderMonth = p.OrderMonth
order by s.OrderMonth;

drop table #Sales;
drop table #NotTop10Sales;
drop table #Purchases;
drop table #NotTop10Purchases;

