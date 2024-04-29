use AdventureWorks2019;
-- Exercise 1
select 'Average Vacation Hours' as [Job Title], [Sales Representative],[Buyer],[Janitor] from
(select JobTitle,VacationHours from HumanResources.Employee) as table1
pivot(
avg(table1.VacationHours)
for JobTitle in ([Sales Representative],[Buyer],[Janitor])
) as table2;

-- Exercise 2
select * from
(select JobTitle,VacationHours,Gender from HumanResources.Employee) as table1
pivot(
avg(table1.VacationHours)
for JobTitle in ([Sales Representative],[Buyer],[Janitor])
) as table2;