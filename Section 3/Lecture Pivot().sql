use AdventureWorks2019;
-- Lecture 1 pivot by summing line totals on differing categories
select 'SumLineTotals' as ProductCategories, Accessories,Bikes,Clothing,Components from
(select D.Name as ProductCategoryName,A.LineTotal from Sales.SalesOrderDetail A
join Production.Product B on A.ProductID = B.ProductID
join Production.ProductSubcategory C on B.ProductSubcategoryID = C.ProductSubcategoryID
join Production.ProductCategory D on C.ProductCategoryID = D.ProductCategoryID ) table1
pivot(
sum(LineTotal)
for ProductCategoryName in (Accessories,Bikes,Clothing,Components)
) table2;

-- getting all categories using stuff
(select
stuff(
(select ',' + Name from Production.ProductCategory
for xml path(''))
,1,1,''));

-- Lecture 2 pivot by summing line totals on differing categories and order quantities
select 'SumLineTotals' as ProductCategories, * from
(select D.Name as ProductCategoryName,A.LineTotal,A.OrderQty as [Order Quantity] from Sales.SalesOrderDetail A
join Production.Product B on A.ProductID = B.ProductID
join Production.ProductSubcategory C on B.ProductSubcategoryID = C.ProductSubcategoryID
join Production.ProductCategory D on C.ProductCategoryID = D.ProductCategoryID ) table1
pivot(
sum(LineTotal)
for ProductCategoryName in (Accessories,Bikes)
) table2
order by [Order Quantity];
