use AdventureWorks2019;
-- Exercise 1
select t1.[FirstName], t1.[LastName], t2.JobTitle, t3.Rate
,[Average Rate] = avg(t3.Rate) over()
from [AdventureWorks2019].[Person].[Person] t1
join [AdventureWorks2019].[HumanResources].[Employee] t2 on t1.BusinessEntityID = t2.BusinessEntityID
join [AdventureWorks2019].HumanResources.EmployeePayHistory t3 on t1.BusinessEntityID = t3.BusinessEntityID;

-- Exercise 2
select t1.[FirstName], t1.[LastName], t2.JobTitle, t3.Rate
,[Average Rate] = avg(t3.Rate) over()
,[Maximum Rate] = max(t3.Rate) over()
from [AdventureWorks2019].[Person].[Person] t1
join [AdventureWorks2019].[HumanResources].[Employee] t2 on t1.BusinessEntityID = t2.BusinessEntityID
join [AdventureWorks2019].HumanResources.EmployeePayHistory t3 on t1.BusinessEntityID = t3.BusinessEntityID;

-- Exercise 3
select t1.[FirstName], t1.[LastName], t2.JobTitle, t3.Rate
,[Average Rate] = avg(t3.Rate) over()
,[Maximum Rate] = max(t3.Rate) over()
,[Diff From Average Rate] = t3.Rate - avg(t3.Rate) over()
from [AdventureWorks2019].[Person].[Person] t1
join [AdventureWorks2019].[HumanResources].[Employee] t2 on t1.BusinessEntityID = t2.BusinessEntityID
join [AdventureWorks2019].HumanResources.EmployeePayHistory t3 on t1.BusinessEntityID = t3.BusinessEntityID;

-- Exercise 4
select t1.[FirstName], t1.[LastName], t2.JobTitle, t3.Rate
,[Average Rate] = avg(t3.Rate) over()
,[Maximum Rate] = max(t3.Rate) over()
,[Diff From Average Rate] = t3.Rate - avg(t3.Rate) over()
,[% of Max Rate] = (t3.Rate / max(t3.Rate) over())*100
from [AdventureWorks2019].[Person].[Person] t1
join [AdventureWorks2019].[HumanResources].[Employee] t2 on t1.BusinessEntityID = t2.BusinessEntityID
join [AdventureWorks2019].HumanResources.EmployeePayHistory t3 on t1.BusinessEntityID = t3.BusinessEntityID;


