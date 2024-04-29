use AdventureWorks2019;
--1.) All rows
select 
*
from [AdventureWorks2019].[Sales].[SalesOrderHeader];

--2.) Count all rows
select 
count(*)
from [AdventureWorks2019].[Sales].[SalesOrderHeader];

--3.) Sum sales by ID
select 
SalesPersonID, sum(TotalDue)
from [AdventureWorks2019].[Sales].[SalesOrderHeader]
group by SalesPersonID;

--4.) Sales person ytd sales
SELECT [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      --,[SalesLastYear]
      --,[rowguid]
      --,[ModifiedDate]
	  ,[Total YTD Sales] = sum([SalesYTD]) over()
	  ,max([SalesYTD]) over() as [Total YTD Sales]
	  ,[SalesYTD]/max([SalesYTD]) over() as [% of Best Performer]
  FROM [AdventureWorks2019].[Sales].[SalesPerson];