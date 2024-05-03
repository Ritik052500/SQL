-- Date Cleaning
use world_layoffs;
select * from layoffs;

-- Create duplicate table to apply changes
create table layoffs_staging like layoffs; 
insert into layoffs_staging select * from layoffs;


-- 1. Remove Duplicates

-- Easy way to join all column names of a specific table
select group_concat(COLUMN_NAME)
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='layoffs';

-- Create new table to modify original data and use row number to see if the row has been duplicated
drop table if exists layoffs_staging_2;
create table layoffs_staging_2 like layoffs_staging;
alter table layoffs_staging_2 add duplicated int;
insert into layoffs_staging_2
select *,
row_number() over (partition by company,country,`date`,funds_raised_millions,industry,location,percentage_laid_off,stage,total_laid_off
) as duplicated
from layoffs_staging;

-- Delete the duplicates
select * from layoffs_staging_2 where duplicated > 1;
set sql_safe_updates = 0;
delete from layoffs_staging_2 where duplicated > 1;


-- 2. Standardize the Data

-- Trim the company column
select distinct company, trim(company) from layoffs_staging_2;
update layoffs_staging_2 set company = trim(company);

-- Assign columns with similar names industries to the same industry
select distinct industry from layoffs_staging_2 order by 1; 
select * from layoffs_staging_2 where lower(industry) like '%crypto%';
update layoffs_staging_2 set industry = 'Crypto' where lower(industry) like '%crypto%';

-- Delete trailing period on the country column
select distinct country, trim(trailing '.' from country) from layoffs_staging_2 order by 1; 
update layoffs_staging_2 set country = trim(trailing '.' from country);

-- Convert the date column from a string to a date object
select str_to_date(`date`, '%m/%d/%Y') from layoffs_staging_2;
update layoffs_staging_2 set `date` = str_to_date(`date`, '%m/%d/%Y');
alter table layoffs_staging_2 modify column `date` date;


-- 3. Null / Blank Values

-- Find  null values in the industry column
select distinct industry from layoffs_staging_2 order by 1;
select * from layoffs_staging_2 where industry is null or industry = '';

-- For the rows with null industries, see if their exists an industry for the same company and location in another row
select a.company, a.industry, b.industry 
from layoffs_staging_2 a 
join layoffs_staging_2 b on a.company = b.company and a.location = b.location
where (a.industry is null or a.industry = '') 
and (b.industry is not null or b.industry != '');

-- Update all nulls to empty spaces
update layoffs_staging_2 set industry = '' where industry is null; 

-- Update all null industries for companies that have their industry assigned in another row
UPDATE layoffs_staging_2 a
JOIN layoffs_staging_2 b ON a.company = b.company and a.location = b.location
SET a.industry = b.industry
WHERE (a.industry is null or a.industry = '') and b.industry != '';


-- 4. Remove Any Unnecessary Columns

-- Rows with nulls for the total laid off and percentage laid off may be irrelvant and can be deleted
select * from layoffs_staging_2 where total_laid_off is null and percentage_laid_off is null;
delete from layoffs_staging_2 where total_laid_off is null and percentage_laid_off is null;

-- Drop duplicated indicator column
alter table layoffs_staging_2 drop column duplicated;
