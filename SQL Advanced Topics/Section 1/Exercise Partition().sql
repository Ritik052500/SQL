-- Exercise 1
use AdventureWorks2019;
select a.Name as ProductName, a.ListPrice, b.ProductSubcategoryID, c.ProductCategoryID from Production.Product a
join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
join Production.ProductCategory c on b.ProductCategoryID = c.ProductCategoryID;

-- Exercise 2
select a.Name as ProductName, a.ListPrice, b.ProductSubcategoryID, c.ProductCategoryID
,avg(ListPrice) over(partition by c.ProductCategoryID) as AvgPriceByCategory
from Production.Product a
join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
join Production.ProductCategory c on b.ProductCategoryID = c.ProductCategoryID;

-- Exercise 3
select a.Name as ProductName, a.ListPrice, b.ProductSubcategoryID, c.ProductCategoryID
,avg(ListPrice) over(partition by c.ProductCategoryID) as AvgPriceByCategory
,avg(ListPrice) over(partition by c.ProductCategoryID,b.ProductSubcategoryID) as AvgPriceByCategoryAndSubcategory
from Production.Product a
join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
join Production.ProductCategory c on b.ProductCategoryID = c.ProductCategoryID;

-- Exercise 4
select a.Name as ProductName, a.ListPrice, b.ProductSubcategoryID, c.ProductCategoryID
,avg(ListPrice) over(partition by c.ProductCategoryID) as AvgPriceByCategory
,avg(ListPrice) over(partition by c.ProductCategoryID,b.ProductSubcategoryID) as AvgPriceByCategoryAndSubcategory
,ListPrice - avg(ListPrice) over(partition by c.ProductCategoryID) as ProductVsCategoryDelta
from Production.Product a
join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
join Production.ProductCategory c on b.ProductCategoryID = c.ProductCategoryID;

-- rows between example
--OVER (
--      PARTITION BY city
--      ORDER BY date DESC
--      ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING), 1)