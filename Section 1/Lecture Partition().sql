-- sum of line total via over
use AdventureWorks2019;
select *,
[ProductIDLineTotal] = sum(LineTotal) over(partition by ProductID,OrderQty)
from Sales.SalesOrderDetail
order by ProductID,OrderQty desc;