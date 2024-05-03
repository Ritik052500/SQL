use AdventureWorks2019;
select ProductID,Name,StandardCost,ListPrice
,AvgListPrice = (select avg(ListPrice) from Production.Product)
,AvgListPriceDiff = ListPrice - (select avg(ListPrice) from Production.Product)
from Production.Product
where ListPrice > (select avg(ListPrice) from Production.Product);