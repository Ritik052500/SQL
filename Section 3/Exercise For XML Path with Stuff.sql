use AdventureWorks2019;
-- Exercise 1
select table1.Name as SubcategoryName, 
Products = 
(select
stuff(
(select ';' + table2.Name from Production.Product as table2
where table1.ProductSubcategoryID = table2.ProductSubcategoryID
for xml path('')),
1,
1,
'')
)
from Production.ProductSubcategory as table1;

-- Exercise 2
select table1.Name as SubcategoryName, 
Products = 
(select
stuff(
(select ';' + table2.Name from Production.Product as table2
where table2.ListPrice > 50
and table1.ProductSubcategoryID = table2.ProductSubcategoryID
for xml path('')),
1,
1,
'')
)
from Production.ProductSubcategory as table1; 
