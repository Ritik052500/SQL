with DateSeries as
(
select Cast('01-01-2021' as date) as MyDate
union all
select DATEADD(Day,1,MyDate) from DateSeries
where MyDate < Cast('12-31-2021' as date)
)
select MyDate from DateSeries
option(maxrecursion 365);