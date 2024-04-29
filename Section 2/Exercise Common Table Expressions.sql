use AdventureWorks2019;
-- Exercise 1
with t1 as 
(select
OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
,TotalDue
from Purchasing.PurchaseOrderHeader),
t2 as 
(select
OrderMonth = DATEFROMPARTS(year(OrderDate),month(OrderDate),1)
,OrderRank = ROW_NUMBER() over(partition by DATEFROMPARTS(year(OrderDate),month(OrderDate),1) order by TotalDue desc)
,TotalDue
from Sales.SalesOrderHeader),
t3 as
(select OrderMonth,sum(TotalDue) as Top10Purchase from t1 where OrderRank > 10 group by OrderMonth),
t4 as
(select OrderMonth,sum(TotalDue) as Top10Sale from t2 where OrderRank > 10 group by OrderMonth)
select t3.OrderMonth,t4.Top10Sale,t3.Top10Purchase from t3
join t4 on t3.OrderMonth = t4.OrderMonth
order by t3.OrderMonth;