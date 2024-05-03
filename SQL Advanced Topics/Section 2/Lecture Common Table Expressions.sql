use AdventureWorks2019;
--- Lecture 1
-- my method
select *,
lag(MonthlyTotal,1) over(order by OrderMonth) as PreviousMonthlyTotal
from (
select month(OrderDate) as OrderMonth,sum(TotalDue) as MonthlyTotal
from (select *,
ROW_NUMBER() over(partition by month(OrderDate) order by TotalDue desc) as Ranking
from Sales.SalesOrderHeader) table1
where Ranking <= 10
group by month(OrderDate)) table2;

--- Lecture method
select OrderMonth,sum(TotalDue) as Top10Total
,[PreviousTop10Total] = lag(sum(TotalDue),1) over (order by OrderMonth)
from (
select 
OrderDate
,TotalDue
,OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
from Sales.SalesOrderHeader) table1
where OrderRank <= 10
group by OrderMonth;

--- Lecture 2, using with clause
with Sales as 
(select 
OrderDate
,TotalDue
,OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
from Sales.SalesOrderHeader),
Top10 as
(
select OrderMonth,sum(TotalDue) as Top10Total from Sales
where OrderRank <= 10
group by OrderMonth)
select *
,PreviousTop10Total = lag(Top10Total,1) over(order by OrderMonth) 
from Top10;
