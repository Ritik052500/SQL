use AdventureWorks2019;
create table #Sales
(
OrderDate datetime
,OrderMonth date
,OrderRank int
,TotalDue money
);

insert into #Sales
(
OrderDate
,OrderMonth
,OrderRank
,TotalDue
)
select
OrderDate
,OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
,TotalDue
from Sales.SalesOrderHeader;

select * from #Sales;

create table #Top10Sales
(
OrderMonth date
,Top10Sales money
,PreviousTop10Sales money
);

insert into #Top10Sales
(
OrderMonth
,Top10Sales
,PreviousTop10Sales
)
select 
OrderMonth
,sum(TotalDue) as Top10Purchase
,lag(sum(TotalDue),1) over (order by OrderMonth)
from #Sales
where OrderRank <= 10
group by OrderMonth
order by OrderMonth;

select * from #Top10Sales;

drop table #Sales;
drop table #Top10Sales;

