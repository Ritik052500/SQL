use AdventureWorks2019;
-- Exercise 1
create table #SalesOrders
(
[SalesOrderID] int
,[OrderDate] date
,[TaxAmt] money
,[Freight] money
,[TotalDue] money
,[TaxFreightPercent] float
,[TaxFreightBucket] varchar(32)
,[OrderAmtBucket] varchar(32)
,[OrderCategory] varchar(32)
,[OrderSubCategory] varchar(32)
);

insert into #SalesOrders
(
SalesOrderID
,OrderDate
,TaxAmt
,Freight
,TotalDue
,OrderCategory
)
select 
SalesOrderID
,OrderDate
,TaxAmt
,Freight
,TotalDue
,OrderCategory = 'Non-Holiday Order'
from Sales.SalesOrderHeader
where year(OrderDate) = 2013;

update #SalesOrders
set TaxFreightPercent = (TaxAmt + Freight)/TotalDue,
OrderAmtBucket = case 
					when TotalDue < 100 then 'Small'
					when TotalDue < 1000 then 'Medium'
					else 'Large'
					end;
update #SalesOrders
set TaxFreightBucket = case	
						when TaxFreightPercent < 0.1 then'Small'
						when TaxFreightPercent < 0.2 then 'Medium'
						else 'Large'
						end;
update #SalesOrders
set OrderCategory = 'Holiday Order'
where DATEPART(quarter,OrderDate) = 4;

update #SalesOrders
set OrderSubCategory = CONCAT(OrderCategory,' - ',OrderAmtBucket);

select * from #SalesOrders;
drop table #SalesOrders;