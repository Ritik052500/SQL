use AdventureWorks2019;
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

--insert into AdventureWorks2019.dbo.Calender
--(
--DateValue 
--,DayofWeekNumber 
--,DayofWeekName 
--,DayofMonthNumber 
--,MonthNumber 
--,YearNumber 
--,WeekendFlag 
--,HolidayFlag 
--)
--values

--(Cast('01-01-2011' as date),7,'Saturday',1,1,2011,1,1);

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
				when DateValue in (cast('01-01-2011' as date)) then 1
				else 0
				end;

select * from AdventureWorks2019.dbo.Calender; 

select a.* from AdventureWorks2019.Sales.SalesOrderHeader a
join AdventureWorks2019.dbo.Calender b on a.OrderDate = b.DateValue
where b.WeekendFlag = 0;

truncate table AdventureWorks2019.dbo.Calender; 
drop table AdventureWorks2019.dbo.Calender; 
