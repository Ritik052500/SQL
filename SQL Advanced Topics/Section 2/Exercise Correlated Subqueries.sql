use AdventureWorks2019;
-- Exercise 1
select PurchaseOrderID,VendorID,OrderDate,TotalDue
,NonRejectedItems = 
(
select count(*) from Purchasing.PurchaseOrderDetail table2
where table1.PurchaseOrderID = table2.PurchaseOrderID
and table2.RejectedQty = 0
)
from Purchasing.PurchaseOrderHeader table1;

-- Exercise 2
select PurchaseOrderID,VendorID,OrderDate,TotalDue
,NonRejectedItems = 
(
select count(*) from Purchasing.PurchaseOrderDetail table2
where table1.PurchaseOrderID = table2.PurchaseOrderID
and table2.RejectedQty = 0
)
,MostExpensiveItem = 
(
select max(table2.UnitPrice) from Purchasing.PurchaseOrderDetail table2
where table1.PurchaseOrderID = table2.PurchaseOrderID
)
from Purchasing.PurchaseOrderHeader table1;

select * from Purchasing.PurchaseOrderDetail
where PurchaseOrderID = 9;
