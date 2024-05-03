use AdventureWorks2019;
-- Exercise 1
create table #People
(
BusinessEntityID int
,Title varchar(64)
,FirstName varchar(64)
,MiddleName varchar(64)
,LastName varchar(64)
,PhoneNumber varchar(64)
,PhoneNumberTypeID int
,PhoneNumberType varchar(64)
,EmailAddress varchar(64)
)

insert into #People
(
BusinessEntityID
,Title
,FirstName
,MiddleName
,LastName
)
select 
BusinessEntityID
,Title
,FirstName
,MiddleName
,LastName
from Person.Person;

-- create clustered or nonclustered indexes on fields you are using to join tables
create clustered index People_idx on #People(BusinessEntityID);
create nonclustered index People_idx2 on #People(PhoneNumberTypeID);

update #People
set PhoneNumber = b.PhoneNumber,
PhoneNumberTypeID = b.PhoneNumberTypeID
from #People a
join Person.PersonPhone b
on a.BusinessEntityID = b.BusinessEntityID;

update #People
set PhoneNumberType = b.Name
from #People a
join Person.PhoneNumberType b
on a.PhoneNumberTypeID = b.PhoneNumberTypeID;

update #People
set EmailAddress = b.EmailAddress
from #People a
join Person.EmailAddress b
on a.BusinessEntityID = b.BusinessEntityID;

select * from #People;
drop table #People;


