use AdventureWorks2019;
declare @MyVar int
set @MyVar = 11
select @MyVar;
-- or
declare @MyVar2 int = 11
select @MyVar2;

declare @MinPrice money = 1000;
select * from Production.Product
where ListPrice >= @MinPrice;

declare @AvgListPrice money = (select avg(ListPrice) from Production.Product);
select 
ProductID
,Name
,StandardCost
,ListPrice
,AvgListPrice = @AvgListPrice
,AvgListPriceDiff = ListPrice - @AvgListPrice 
from Production.Product
where ListPrice > @AvgListPrice
order by ListPrice asc;


declare @Today date = cast(getDate() as date );
select @Today;

declare @BOM date = DATEFROMPARTS(year(@Today),month(@Today),1);
select @BOM;

declare @PrevBOM date = DATEADD(month,-1,@BOM);
select @PrevBOM;

declare @PrevEOM date = DATEADD(day,-1,@BOM);
select @PrevEOM;

select * from AdventureWorks2019.dbo.Calender
where DateValue between @PrevBOM and @PrevEOM;