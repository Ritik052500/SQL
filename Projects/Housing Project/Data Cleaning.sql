-- View the data
select * from [Nashville Housing Data for Data Cleaning];


-- Get data types of each column
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Nashville Housing Data for Data Cleaning';


-- Update the table to fill in the null property addresses if the address is already given in another row with the same parcel ID
update a
set PropertyAddress = b.PropertyAddress
from dbo.[Nashville Housing Data for Data Cleaning] a
join dbo.[Nashville Housing Data for Data Cleaning] b 
on a.ParcelID = b.ParcelID
where b.PropertyAddress is not null
and a.PropertyAddress is null;


-- Split up the property address into separates columns of street address, city, and state
SELECT 
    substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) as address,
	TRIM(substring(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))) as city
from dbo.[Nashville Housing Data for Data Cleaning];

alter table dbo.[Nashville Housing Data for Data Cleaning]
ADD PropertySplitAddress VARCHAR(255);
update [Nashville Housing Data for Data Cleaning]
set PropertySplitAddress = substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);

alter table dbo.[Nashville Housing Data for Data Cleaning]
ADD PropertySplitCity VARCHAR(255);
update [Nashville Housing Data for Data Cleaning]
set PropertySplitCity = TRIM(substring(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)));


-- Split up the owner address into separates columns of street address, city, and state
SELECT 
    parsename(replace(OwnerAddress,',','.'), 3),
	parsename(replace(OwnerAddress,',','.'), 2),
	parsename(replace(OwnerAddress,',','.'), 1)
from dbo.[Nashville Housing Data for Data Cleaning];

alter table dbo.[Nashville Housing Data for Data Cleaning]
ADD OwnerSplitAddress VARCHAR(255);
update [Nashville Housing Data for Data Cleaning]
set OwnerSplitAddress = parsename(replace(OwnerAddress,',','.'), 3);

alter table dbo.[Nashville Housing Data for Data Cleaning]
ADD OwnerSplitCity VARCHAR(255);
update [Nashville Housing Data for Data Cleaning]
set OwnerSplitCity = parsename(replace(OwnerAddress,',','.'), 2);

alter table dbo.[Nashville Housing Data for Data Cleaning]
ADD OwnerSplitState VARCHAR(255);
update [Nashville Housing Data for Data Cleaning]
set OwnerSplitState = parsename(replace(OwnerAddress,',','.'), 1);


-- Change the 1 and 0 in the soldasvacant column to Yes and No
select distinct SoldAsVacant, count(*) from [Nashville Housing Data for Data Cleaning] group by SoldAsVacant;

alter table [Nashville Housing Data for Data Cleaning] 
alter column SoldAsVacant varchar(255);

update [Nashville Housing Data for Data Cleaning]
set SoldAsVacant = 'YES' where SoldAsVacant = '1'

update [Nashville Housing Data for Data Cleaning]
set SoldAsVacant = 'NO' where SoldAsVacant = '0'


-- Removing Duplicates

-- Retrieving all columns names
SELECT STUFF(
    (
        SELECT ',' + COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
		where TABLE_NAME = 'Nashville Housing Data for Data Cleaning'
        FOR XML PATH('')
    ), 
    1, 1, ''
) AS concatenated_values;

with t1 as (
select *, 
[Appearnaces] = ROW_NUMBER() over (partition by ParcelID,LandUse,PropertyAddress,
												SaleDate,SalePrice,LegalReference,
												SoldAsVacant,OwnerName,OwnerAddress,
												Acreage,TaxDistrict,LandValue,BuildingValue,
												TotalValue,YearBuilt,Bedrooms,FullBath,HalfBath,
												PropertySplitAddress,PropertySplitCity,OwnerSplitAddress,
												OwnerSplitCity,OwnerSplitState 
												order by UniqueID)
from [Nashville Housing Data for Data Cleaning]
)
delete from t1 where Appearnaces > 1;


-- Removing Unused Columns
alter table [Nashville Housing Data for Data Cleaning]
drop column OwnerAddress, TaxDistrict, PropertyAddress;

select * from [Nashville Housing Data for Data Cleaning];