use AdventureWorks2019;
-- Lecture 1 functions
create function dbo.ufnCurrentDate() 

-- establish return type
returns date

as

-- code goes between begin and end statements
begin

-- return value
return cast(getDate() as date)

end;

-- code example
select SalesOrderID,OrderDate,DueDate,ShipDate,TotalDue,Today = dbo.ufnCurrentDate() from Sales.SalesOrderHeader where year(OrderDate) = 2013;


-- Lecture 2 functions with parameters
create function dbo.ufnElapsedBusinessDays(@StartDate date,@EndDate date) 

returns int

as

begin

return 

(
select count(*) from AdventureWorks2019.dbo.Calender b
where b.DateValue between @StartDate and @EndDate
and b.WeekendFlag = 0
and b.HolidayFlag = 0
)

end;

-- code example
select SalesOrderID,OrderDate,DueDate,ShipDate,TotalDue,
ElapsedBusinessDays = dbo.ufnElapsedBusinessDays(a.OrderDate,a.ShipDate)
from Sales.SalesOrderHeader a
where year(a.OrderDate) = 2011;
