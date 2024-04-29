use AdventureWorks2019;
-- Exercise 1
declare @MaxVacationHours float = (select max(VacationHours) from HumanResources.Employee)
select 
BusinessEntityID
,JobTitle
,VacationHours
,MaxVacationHours = @MaxVacationHours
,PercentOfMaxVacationHours = (cast(VacationHours as float)/@MaxVacationHours) * 100
from HumanResources.Employee
where (cast(VacationHours as float)/@MaxVacationHours) > 0.8;

-- Exercise 2
declare @Today date = cast(getDate() as date);
select @Today;

declare @PrevPayB date = case 
						when day(@Today) >= 15  then DATEFROMPARTS(year(Dateadd(month,-1,@Today)),month(Dateadd(month,-1,@Today)),15)
						when day(@Today) < 15  then DATEFROMPARTS(year(Dateadd(month,-2,@Today)),month(Dateadd(month,-2,@Today)),15)
						end;
declare @PrevPayE date = DATEFROMPARTS(year(Dateadd(month,1,@PrevPayB)),month(Dateadd(month,1,@PrevPayB)),14);

select(@PrevPayB);
select(@PrevPayE);