USE [AdventureWorks2019]
GO

/****** Object:  StoredProcedure [dbo].[DynamicNameSearch]    Script Date: 10/21/2022 5:38:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO 

alter procedure dbo.DynamicTopN (@TopN int, @AggFunction varchar(50))
as
begin
	declare @DynamicSQL varchar(max);

	set @DynamicSQL = 'select * from 
				(
					select 
						b.Name
						,SalesLineTotalSum = '
	set @DynamicSQL = @DynamicSQL+@AggFunction;
	set @DynamicSQL = @DynamicSQL + '(LineTotal)
						,SalesLineTotalSumRank = DENSE_RANK() over (order by '
	set @DynamicSQL = @DynamicSQL+@AggFunction;					
	set @DynamicSQL = @DynamicSQL + '(LineTotal) desc)
							from AdventureWorks2019.Sales.SalesOrderDetail a
								join AdventureWorks2019.Production.Product b
								on a.ProductID = b.ProductID
									group by b.name
				) table1
					where SalesLineTotalSumRank <= '		
	set @DynamicSQL = @DynamicSQL+cast(@TopN as varchar(32));				
	exec(@DynamicSQL);
end
GO
exec dbo.DynamicTopN 10,avg;