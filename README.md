# COVID-19 Data Analysis

## Table of Contents
- [Project Overview](#Project-Overview)
- [Data Sources](#Data-Sources)
- [Tools Used](#Tools)
- [Data Cleaning](#Data-Cleaning)

### Project Overview
This project aims to provide insight into the impacts of COVID-19 on various countries. By analyzing various aspects of data, we seek to identify trends and gain a deeper understanding of the situation.

### Data Soruces
The dataset used for this analysis are:
- CovidDeaths.Xlsx
- CovidVaccinations.xlsx

### Tools
- Excel - Data Cleaning
- SQL Server - Data anlysis
- Power BI - Data Visualization


### Data Cleaning
In initial data preparation phase, the following steps are performed
1. Data inspection
2. Data formatting

### Exploratory Data Analysis
The data is explored to answer the following questions.


How many people are infected country-wise?
 
```sql
Select location, population,max(total_cases) as Highest_Affected_Cases, max((total_cases/population))* 100 as Affected_people_percentage from COVID_19_DATA_ANALYSIS..CovidDeaths
where continent is not null
group by location, population 
```

What is the death rate continent-wise?

```sql
select location, sum(cast (new_deaths as int)) as Total_death_count from COVID_19_DATA_ANALYSIS..CovidDeaths
where continent is null and location not in ('world', 'European union', 'International')
group by location
order by Total_death_count  desc
```

How many people are vaccinated in each country?

```sql
with cte_Vac (date, location,population,Rolling_vaccination_Rate)
as
(
Select cov. date, cov.location,population,   sum(cast(vac.new_vaccinations as int))over(partition by cov.location) as Rolling_vaccination_Rate from COVID_19_DATA_ANALYSIS..CovidDeaths as cov
join COVID_19_DATA_ANALYSIS..CovidVaccinations as vac
on cov.location = vac.location
and cov.date = vac.date
where cov.continent is not null
)
```
select date, location , population , (Rolling_vaccination_Rate/population)*100 as vaccinated_people_percentage from cte_Vac;


### Findings






