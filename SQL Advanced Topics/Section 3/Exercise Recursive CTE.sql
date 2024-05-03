use AdventureWorks2019;
-- Exercise 1
with NumberSeries as
(
select 1 as MyNumber
union all
select MyNumber + 2 from NumberSeries where MyNumber < 99
)
select * from NumberSeries;

-- Exercise 2
with DateSeries as
(
select cast('01-01-2021' as date) as MyDate
union all
select DATEADD(Month,1,MyDate) from DateSeries where MyDate < cast('12-01-2029' as date) 
)
select * from DateSeries
option(maxrecursion 120);