-- Exercise 1,2
USE [AdventureWorks2019]
GO

/****** Object:  StoredProcedure [dbo].[DynamicNameSearch]    Script Date: 10/21/2022 5:38:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[DynamicNameSearch] (@NameSearch varchar(32), @SearchPattern varchar(32),@MatchType int)
as
begin
declare @DynamicSQL varchar(max)
declare @NameColumn varchar(max)

if LOWER(@NameSearch) = 'first'
	begin
		set @NameColumn = 'FirstName'
	end
if LOWER(@NameSearch) = 'last'
	begin
		set @NameColumn = 'LastName'
	end
if LOWER(@NameSearch) = 'middle'
	begin
		set @NameColumn = 'MiddleName'
	end

set @DynamicSQL = 'select * from person.Person
where '
set @DynamicSQL = @DynamicSQL + @NameColumn
set @DynamicSQL = @DynamicSQL + ' like '
if @MatchType = 1
begin
set @DynamicSQL = @DynamicSQL + '''' + @SearchPattern + ''''
end
if @MatchType = 2
begin
set @DynamicSQL = @DynamicSQL + '''' + @SearchPattern + '%'''
end
if @MatchType = 3
begin
set @DynamicSQL = @DynamicSQL + '''%' + @SearchPattern + ''''
end
if @MatchType = 4
begin
set @DynamicSQL = @DynamicSQL+ '''%' + @SearchPattern + '%'''
end

exec(@DynamicSQL)
end
GO




exec dbo.DynamicNameSearch 'First','Ken',4