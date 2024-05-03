use AdventureWorks2019;
-- Exercise 1
select a.Name as ProductName, a.ListPrice, b.ProductSubcategoryID, c.ProductCategoryID
,ROW_NUMBER() over(order by a.ListPrice desc) as [Price Rank]
,ROW_NUMBER() over(partition by c.ProductCategoryID order by a.ListPrice desc) as [Category Price Rank]
,case
when ROW_NUMBER() over(partition by c.ProductCategoryID order by a.ListPrice desc) <= 5 then 'Yes'
else 'No'
end as [Top 5 Price In Category]
,[Category Price With Rank] = rank() over(partition by c.ProductCategoryID order by a.ListPrice desc)
from Production.Product a
join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
join Production.ProductCategory c on b.ProductCategoryID = c.ProductCategoryID;

-- Exercise 2
select a.Name as ProductName, a.ListPrice, b.ProductSubcategoryID, c.ProductCategoryID
,ROW_NUMBER() over(order by a.ListPrice desc) as [Price Rank]
,ROW_NUMBER() over(partition by c.ProductCategoryID order by a.ListPrice desc) as [Category Price Rank]
,case
when ROW_NUMBER() over(partition by c.ProductCategoryID order by a.ListPrice desc) <= 5 then 'Yes'
else 'No'
end as [Top 5 Price In Category]
,[Category Price With Rank] = rank() over(partition by c.ProductCategoryID order by a.ListPrice desc)
,[Category Price With Dense Rank] = dense_rank() over(partition by c.ProductCategoryID order by a.ListPrice desc)
from Production.Product a
join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
join Production.ProductCategory c on b.ProductCategoryID = c.ProductCategoryID;

-- top 5 disctinct prices are most accurately achieved by dense rank
-- Exercise 3
select a.Name as ProductName, a.ListPrice, b.ProductSubcategoryID, c.ProductCategoryID
,ROW_NUMBER() over(order by a.ListPrice desc) as [Price Rank]
,ROW_NUMBER() over(partition by c.ProductCategoryID order by a.ListPrice desc) as [Category Price Rank]
,[Category Price With Rank] = rank() over(partition by c.ProductCategoryID order by a.ListPrice desc)
,[Category Price With Dense Rank] = dense_rank() over(partition by c.ProductCategoryID order by a.ListPrice desc)
,case
when dense_rank() over(partition by c.ProductCategoryID order by a.ListPrice desc) <= 5 then 'Yes'
else 'No'
end as [Top 5 Price In Category]
from Production.Product a
join Production.ProductSubcategory b on a.ProductSubcategoryID = b.ProductSubcategoryID
join Production.ProductCategory c on b.ProductCategoryID = c.ProductCategoryID;