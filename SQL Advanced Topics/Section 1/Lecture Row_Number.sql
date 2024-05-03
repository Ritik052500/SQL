-- rank all records within each group by sales order ID
use AdventureWorks2019;
select 
SalesOrderID,
SalesOrderDetailID,
LineTotal,
sum(LineTotal) over(partition by SalesOrderID) as ProductIdLineTotal,
ROW_NUMBER() over(partition by SalesOrderID order by LineTotal desc) as Ranking
from Sales.SalesOrderDetail