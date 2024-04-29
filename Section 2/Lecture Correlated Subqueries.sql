use AdventureWorks2019;
select SalesOrderID,OrderDate,SubTotal,TaxAmt,Freight,TotalDue
,MultiOrderCount = 
(
select count(*) from Sales.SalesOrderDetail table2
where table2.SalesOrderID = table1.SalesOrderID
and table2.OrderQty > 1
) 
from Sales.SalesOrderHeader table1;

