use AdventureWorks2019;
create table #Purchases
(
PurchaseOrderId int
,OrderDate date
,TotalDue money
,RejectedQty float
);

insert into #Purchases
(
PurchaseOrderId 
,OrderDate
,TotalDue 
)
select
PurchaseOrderId 
,OrderDate
,TotalDue
from Purchasing.PurchaseOrderHeader;

update #Purchases
set RejectedQty = b.RejectedQty
from #Purchases a
join Purchasing.PurchaseOrderDetail b 
on a.PurchaseOrderId = b.PurchaseOrderID
where b.RejectedQty > 5;

select * from #Purchases where RejectedQty is not null;
drop table #Purchases;