create table AdventureWorks2019.dbo.Calender
(
DateValue date
,DayofWeekNumber int
,DayofWeekName varchar(32)
,DayofMonthNumber int
,MonthNumber int
,YearNumber int
,WeekendFlag tinyint
,HolidayFlag tinyint
);

with Dates as
(
select
cast('01-01-2011' as date) as MyDate
union all
select
DATEADD(day,1,MyDate)
from Dates
where MyDate < cast('12-31-2011' as date)
)

insert into AdventureWorks2019.dbo.Calender
(
DateValue
)
select 
MyDate 
from Dates
option (maxrecursion 10000);

-- Exercise 1
update AdventureWorks2019.dbo.Calender
set DayofWeekNumber = DATEPART(weekday,DateValue)
,DayofWeekName = FORMAT(DateValue,'dddd')
,DayofMonthNumber = DAY(DateValue)
,MonthNumber = MONTH(DateValue)
,YearNumber = YEAR(DateValue)
,WeekendFlag = case 
				when DayOfWeekNumber in (1,7) then 1
				else 0
				end
,HolidayFlag = case		
				when DateValue in (cast('01-01-2011' as date),cast('07-04-2011' as date),cast('12-25-2011' as date),cast('11-11-2011' as date)) then 1
				else 0
				end;

select * from AdventureWorks2019.dbo.Calender; 

-- Exercise 2
select a.* from AdventureWorks2019.Purchasing.PurchaseOrderHeader a
join AdventureWorks2019.dbo.Calender b on a.OrderDate = b.DateValue
where b.HolidayFlag = 0;

-- Exercise 3
select a.* from AdventureWorks2019.Purchasing.PurchaseOrderHeader a
join AdventureWorks2019.dbo.Calender b on a.OrderDate = b.DateValue
where b.HolidayFlag = 1
and b.WeekendFlag = 1 ;

