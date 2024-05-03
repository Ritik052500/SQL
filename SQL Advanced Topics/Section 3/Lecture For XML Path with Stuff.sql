use AdventureWorks2019;
select table1.SalesOrderID,table1.OrderDate,table1.TotalDue,
Totals = (select 
	stuff(
		(select ',' + cast(cast(LineTotal as money) as varchar) from Sales.SalesOrderDetail table2
		where table1.SalesOrderID = table2.SalesOrderID
		for xml path('')
		),
		1,
		1,
		''
		)
		)from Sales.SalesOrderHeader table1;

select 
	stuff(
		(select ',' +  cast(cast(LineTotal as money) as varchar) from Sales.SalesOrderDetail table2
		where SalesOrderID = 43659
		for xml path('')
		),
		1,
		1,
		''
		);
