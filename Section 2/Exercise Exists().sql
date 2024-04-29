use AdventureWorks2019;
-- Exercise 1
select PurchaseOrderID,OrderDate,SubTotal,TaxAmt
from Purchasing.PurchaseOrderHeader table1
where exists (
select 1 from Purchasing.PurchaseOrderDetail table2
where OrderQty > 500
and table1.PurchaseOrderID = table2.PurchaseOrderID)
order by PurchaseOrderID;

-- Exercise 2
select *
from Purchasing.PurchaseOrderHeader table1
where exists (
select 1 from Purchasing.PurchaseOrderDetail table2
where OrderQty > 500
and UnitPrice > 50
and table1.PurchaseOrderID = table2.PurchaseOrderID)
order by PurchaseOrderID;

-- Exercise 3
select *
from Purchasing.PurchaseOrderHeader table1
where not exists (
select 1 from Purchasing.PurchaseOrderDetail table2
where RejectedQty > 0
and table1.PurchaseOrderID = table2.PurchaseOrderID)
order by PurchaseOrderID;

