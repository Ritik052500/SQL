use AdventureWorks2019;
--lead and lag functions very useful in time series data applications

-- lead function on total due to grab next value
select SalesOrderID,OrderDate,CustomerID,TotalDue,
[Next Total Due] = lead(TotalDue,1) over(order by SalesOrderID)
from Sales.SalesOrderHeader
order by SalesOrderID;

-- lag function on total due to grab previous value
select SalesOrderID,OrderDate,CustomerID,TotalDue,
[Previous Total Due] = lag(TotalDue,1) over(order by SalesOrderID)
from Sales.SalesOrderHeader
order by SalesOrderID;

-- lead function on total due to grab next value, lag function to grab previous value partitioned by customer
select SalesOrderID,OrderDate,CustomerID,TotalDue,
[Next Total Due] = lead(TotalDue,1) over(partition by CustomerID order by SalesOrderID),
[Previous Total Due] = lag(TotalDue,1) over(partition by CustomerID order by SalesOrderID)
from Sales.SalesOrderHeader
order by CustomerID,SalesOrderID;