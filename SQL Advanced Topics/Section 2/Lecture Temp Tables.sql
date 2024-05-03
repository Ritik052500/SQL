use AdventureWorks2019;
-- Lecture 1 and 2
select 
OrderDate
,TotalDue
,OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
into #Sales
from Sales.SalesOrderHeader;

select OrderMonth,sum(TotalDue) as Top10Total,lag(sum(TotalDue),1) over (order by OrderMonth) as PreviousTop10Total
into #Top10Sales
from #Sales
where OrderRank <= 5
group by OrderMonth
;

select * from #Sales;
select * from #Top10Sales;
drop table #Sales;
drop table #Top10Sales;


