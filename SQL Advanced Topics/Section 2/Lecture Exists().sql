use AdventureWorks2019;
select table1.SalesOrderID,table1.OrderDate,table1.TotalDue from Sales.SalesOrderHeader table1
where not exists(
select 1 from Sales.SalesOrderDetail table2
where table1.SalesOrderID = table2.SalesOrderID
and LineTotal > 10000
);