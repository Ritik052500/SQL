use AdventureWorks2019;
select 
a.SalesOrderID
,a.OrderDate
,a.TotalDue
from Sales.SalesOrderHeader a
where exists
(
select 1 from Sales.SalesOrderDetail b
where a.SalesOrderID = b.SalesOrderID
and b.LineTotal > 10000
);

create table #Sales
(
SalesOrderID int
,OrderDate date
,TotalDue money
,LineTotal money
)

insert into #Sales
(
SalesOrderID
,OrderDate
,TotalDue
)
select
SalesOrderID
,OrderDate
,TotalDue
from Sales.SalesOrderHeader

update #Sales
set LineTotal = b.LineTotal
from #Sales a
join Sales.SalesOrderDetail b 
on a.SalesOrderID = b.SalesOrderID
where b.LineTotal > 10000;

select * from #Sales where LineTotal is not null;
drop table #Sales;