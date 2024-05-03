use AdventureWorks2019;
-- Exercise 1
select BusinessEntityID,JobTitle,VacationHours
,MaxVacationHours = (select max(VacationHours) from HumanResources.Employee)
from HumanResources.Employee;

-- Exercise 2
select BusinessEntityID,JobTitle,VacationHours
,MaxVacationHours = (select max(VacationHours) from HumanResources.Employee)
,[% of MaxVacationHours] = round((cast(VacationHours as float) / (select max(VacationHours) from HumanResources.Employee))*100 ,2)
from HumanResources.Employee;

-- Exercise 3
select * from (
select BusinessEntityID,JobTitle,VacationHours
,MaxVacationHours = (select max(VacationHours) from HumanResources.Employee)
,[% of MaxVacationHours] = round((cast(VacationHours as float) / (select max(VacationHours) from HumanResources.Employee))*100 ,2)
from HumanResources.Employee) table1
where[% of MaxVacationHours] >= 80;