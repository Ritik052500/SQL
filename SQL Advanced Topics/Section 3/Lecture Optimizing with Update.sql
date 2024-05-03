use AdventureWorks2019;
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

create table #ProductsSold2012
(
SalesOrderID int
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
,OrderDate
,LineTotal
,ProductID
)
select 
a.SalesOrderID
,a.OrderDate
,b.LineTotal
,b.ProductID
from #Sales2012 a
	join Sales.SalesOrderDetail b 
		on a.SalesOrderID = b.SalesOrderID;



update #ProductsSold2012
set ProductName = b.Name,
ProductSubcategoryID = b.ProductSubcategoryID
from #ProductsSold2012 a 
	join Production.Product b
		on a.ProductID = b.ProductID;

update #ProductsSold2012
set ProductSubcategoryName = b.Name,
ProductCategoryID = b.ProductCategoryID
from #ProductsSold2012 a 
	join Production.ProductSubcategory b
		on a.ProductSubcategoryID = b.ProductSubcategoryID;

update #ProductsSold2012
set ProductCategoryName = b.Name
from #ProductsSold2012 a 
	join Production.ProductCategory b
		on a.ProductCategoryID = b.ProductCategoryID;



select * from #ProductsSold2012;
	

drop table #Sales2012;
drop table #ProductsSold2012;
