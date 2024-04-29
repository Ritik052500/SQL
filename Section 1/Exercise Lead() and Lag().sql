use AdventureWorks2019;
-- Exercise 1
select p.PurchaseOrderID,p.OrderDate,p.TotalDue,v.Name from Purchasing.PurchaseOrderHeader p
join Purchasing.Vendor v on p.VendorID = v.BusinessEntityID
where year(p.OrderDate) >= 2013 
and p.TotalDue > 500;

-- Exercise 2
select p.PurchaseOrderID,p.OrderDate,p.TotalDue,v.Name
,lag(p.TotalDue,1) over(partition by p.VendorID order by p.OrderDate) as PrevOrderFromVendorAmt
from Purchasing.PurchaseOrderHeader p
join Purchasing.Vendor v on p.VendorID = v.BusinessEntityID
where year(p.OrderDate) >= 2013 
and p.TotalDue > 500;

-- Exercise 3
select p.PurchaseOrderID,p.OrderDate,p.TotalDue,v.Name,p.EmployeeID
,lag(p.TotalDue,1) over(partition by p.VendorID order by p.OrderDate) as PrevOrderFromVendorAmt
,lead(v.Name,1) over(partition by p.EmployeeID order by p.OrderDate) as NextOrderByEmployeeVendor
from Purchasing.PurchaseOrderHeader p
join Purchasing.Vendor v on p.VendorID = v.BusinessEntityID
where year(p.OrderDate) >= 2013 
and p.TotalDue > 500
order by p.EmployeeID,p.OrderDate;

-- Exercise 4
select p.PurchaseOrderID,p.OrderDate,p.TotalDue,v.Name,p.EmployeeID
,lag(p.TotalDue,1) over(partition by p.VendorID order by p.OrderDate) as PrevOrderFromVendorAmt
,lead(v.Name,1) over(partition by p.EmployeeID order by p.OrderDate) as NextOrderByEmployeeVendor
,lead(v.Name,2) over(partition by p.EmployeeID order by p.OrderDate) as Next2OrderByEmployeeVendor
from Purchasing.PurchaseOrderHeader p
join Purchasing.Vendor v on p.VendorID = v.BusinessEntityID
where year(p.OrderDate) >= 2013 
and p.TotalDue > 500
order by p.EmployeeID,p.OrderDate;