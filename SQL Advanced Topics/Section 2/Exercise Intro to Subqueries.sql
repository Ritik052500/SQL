use AdventureWorks2019;
-- Exercise 1
select * from
(select PurchaseOrderID,VendorID,OrderDate,TaxAmt,Freight,TotalDue
,row_number() over(partition by VendorID order by TotalDue desc) as Ranking
from Purchasing.PurchaseOrderHeader) table1
where Ranking <= 3;

-- Exercise 2
select * from
(select PurchaseOrderID,VendorID,OrderDate,TaxAmt,Freight,TotalDue
,dense_rank() over(partition by VendorID order by TotalDue desc) as Ranking
from Purchasing.PurchaseOrderHeader) table1
where Ranking <= 3;


