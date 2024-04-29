use AdventureWorks2019;
-- 1) create filtered temp table of sales order headers table where year = 2012
create table #Sales2012
(
SalesOrderID int
,OrderDate date
)

insert into #Sales2012
(
SalesOrderID 
,OrderDate 
)
select 
SalesOrderID
,OrderDate
from Sales.SalesOrderHeader
where year(OrderDate) = 2012;

create clustered index Sales2012_idx on #Sales2012(SalesOrderId);

-- 2) create new temp table after joining in SalesOrderDetail table
create table #ProductsSold2012
(
SalesOrderID int
,SalesOrderDetailID int
,OrderDate date
,LineTotal money
,ProductID int
,ProductName varchar(32)
,ProductSubcategoryID int
,ProductSubcategoryName varchar(64)
,ProductCategoryID int
,ProductCategoryName varchar(64)
)

insert into #ProductsSold2012
(
SalesOrderID
,SalesOrderDetailID
,OrderDate
,LineTotal
,ProductID
)
select 
a.SalesOrderID
,b.SalesOrderDetailID
,a.OrderDate
,b.LineTotal
,b.ProductID
from #Sales2012 a
	join Sales.SalesOrderDetail b 
		on a.SalesOrderID = b.SalesOrderID;

-- create clustered or nonclustered indexes on fields you are using to join tables
create clustered index ProductsSold2012_idx on #ProductsSold2012(SalesOrderId,SalesOrderDetailID);
create nonclustered index ProductsSold2012_idx2 on #ProductsSold2012(ProductID);
create nonclustered index ProductsSold2012_idx3 on #ProductsSold2012(ProductSubcategoryID);
create nonclustered index ProductsSold2012_idx4 on #ProductsSold2012(ProductCategoryID);

-- 3) add product data with update
update #ProductsSold2012
set ProductName = b.Name,
ProductSubcategoryID = b.ProductSubcategoryID
from #ProductsSold2012 a 
	join Production.Product b
		on a.ProductID = b.ProductID;

-- 4) add product subcategory data with update
update #ProductsSold2012
set ProductSubcategoryName = b.Name,
ProductCategoryID = b.ProductCategoryID
from #ProductsSold2012 a 
	join Production.ProductSubcategory b
		on a.ProductSubcategoryID = b.ProductSubcategoryID;

-- 5) add product category data with update
update #ProductsSold2012
set ProductCategoryName = b.Name
from #ProductsSold2012 a 
	join Production.ProductCategory b
		on a.ProductCategoryID = b.ProductCategoryID;



select * from #ProductsSold2012;
	

drop table #Sales2012;
drop table #ProductsSold2012;
