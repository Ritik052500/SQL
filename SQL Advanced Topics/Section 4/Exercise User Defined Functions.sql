use AdventureWorks2019;
-- Exercise 1
create function dbo.ufnPercentageOf(@number1 float,@number2 float)
returns varchar(10)
as
begin
return concat(round((@number1/@number2)*100,2),'%')
end;

select dbo.ufnPercentageOf(800,11);

-- Exercise 2
create function dbo.ufnPercentageOfMaxVacationHours(@VacationHours int)
returns varchar(10)
as
begin
declare @MaxVacationHours int = (select max(VacationHours) from [AdventureWorks2019].[HumanResources].[Employee])
return dbo.ufnPercentageOf(@VacationHours,@MaxVacationHours)
end;

select BusinessEntityID,JobTitle,VacationHours
,PercentageOfMaxVacationHours = dbo.ufnPercentageOfMaxVacationHours(VacationHours)
from HumanResources.Employee;