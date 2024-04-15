# COVID-19 Data Analysis


### Project Overview
This project aims to provide insight into the impacts of COVID-19 on various countries, to identify the most affected country, and to assess how it will impact that country in the future. By analyzing various aspects of data, we seek to identify trends and gain a deeper understanding of the situation.

### Data Sources
The dataset used for this analysis contains data from January 2020 to April 2021, which includes:
- CovidDeaths.Xlsx
- CovidVaccinations.xlsx

### Tools
- Excel - Data Cleaning
- SQL Server - Data anlysis
- Tableau - Data Visualization


### Data Cleaning
In the initial data preparation phase, the following steps are performed:
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
select date, location , population , (Rolling_vaccination_Rate/population)*100 as vaccinated_people_percentage from cte_Vac;
```

### Findings


![Graph 1](https://github.com/alinah1214/COVID-19-Data-Analysis/assets/149886043/44aca03b-40d0-49a9-a8fe-1c60fcd6f7d9)





![Graph 3](https://github.com/alinah1214/COVID-19-Data-Analysis/assets/149886043/9208f88d-b211-46a0-8206-4961fe6222d4)




![Graph 2](https://github.com/alinah1214/COVID-19-Data-Analysis/assets/149886043/a053f98a-636c-43c4-bd18-20e3e9ecff3f)





- Europe has the highest death rate compared to other continents, and within Europe, the United States is the most infected country with COVID-19.
- The graph shows that if deaths continue at this rate, the death toll in the US could increase from 8.93% to 19.11% by the end of September 2021



