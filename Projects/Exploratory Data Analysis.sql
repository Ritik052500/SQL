-- Exploratory Data Analysis

use world_layoffs;

-- Find the maximium total laid off and maxmimum percentage laid off
select max(total_laid_off), max(percentage_laid_off) from layoffs_staging_2;

-- Date range
Select min(date), max(date) from layoffs_staging_2;

-- Find companies that have went out of business and order them by the funds raises
select * from layoffs_staging_2 
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- Find the total laid off for each company
select company, sum(total_laid_off) as total_laid_off from layoffs_staging_2 group by company order by 2 desc;

-- Find the total laid off for each industry
select industry, sum(total_laid_off) as total_laid_off from layoffs_staging_2 group by industry order by 2 desc;

-- Find the total laid off for each country
select country, sum(total_laid_off) as total_laid_off from layoffs_staging_2 group by country order by 2 desc;

-- Find the total laid off for each year
select year(`date`) as year, sum(total_laid_off) as total_laid_off from layoffs_staging_2 group by year(`date`) order by 1;

-- Find the total laid off for each stage
select stage, sum(total_laid_off) as total_laid_off from layoffs_staging_2 group by stage order by 2 desc;

-- Rolling sum of layoffs by month
with rolling_total as (
select DATE_FORMAT(date, '%Y-%m') as month, 
sum(total_laid_off) as total_laid_off 
from layoffs_staging_2 
where DATE_FORMAT(date, '%Y-%m') is not null
group by DATE_FORMAT(date, '%Y-%m') 
order by 1
)
SELECT 
    `month`,
    total_laid_off,
    SUM(total_laid_off) OVER (ORDER BY `month` ROWS BETWEEN Unbounded PRECEDING AND CURRENT ROW) AS rolling_sum
FROM 
    rolling_total;
    
-- Find the total laid off for each company for each year and rank the total laid off by each year
with company_year as (
select company,
year(`date`) as year, 
sum(total_laid_off) as total_laid_off
from layoffs_staging_2 
group by company, year(`date`)  
order by company
) ,
company_year_rank as (
select *,
Dense_Rank() over (partition by year order by total_laid_off desc) as ranking 
from company_year
where year is not null
order by year asc , ranking asc
)
select * from company_year_rank where ranking <= 5;