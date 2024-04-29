use AdventureWorks2019;
--method 1 using with clause
with t1 as(
select 
SalesOrderID,
SalesOrderDetailID,
LineTotal,
ROW_NUMBER() over(partition by SalesOrderID order by LineTotal desc) as LineTotalRanking
from Sales.SalesOrderDetail)
select * from t1 where LineTotalRanking = 1;

--method 2 using from sub query
select * from (
select 
SalesOrderID,
SalesOrderDetailID,
LineTotal,
ROW_NUMBER() over(partition by SalesOrderID order by LineTotal desc) as LineTotalRanking
from Sales.SalesOrderDetail) table1
where LineTotalRanking = 1;
