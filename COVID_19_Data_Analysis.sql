
-- Total cases vs Total deaths

Select location,date, total_cases, total_deaths, (total_cases/total_deaths)* 100 as death_cases_percentage from COVID_19_DATA_ANALYSIS..CovidDeaths

where continent is not null

order by location,date



--Infected people percentage date wise
Select location, population,date, total_cases,(total_cases/population)* 100 as Affected_people_percentage from COVID_19_DATA_ANALYSIS..CovidDeaths

where continent is not null


--Percentage of people infected in each country

Select location, population,max(total_cases) as Highest_Affected_Cases, max((total_cases/population))* 100 as Affected_people_percentage from COVID_19_DATA_ANALYSIS..CovidDeaths

where continent is not null

group by location, population



-- worldwide covid effect

Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, (sum(cast(new_deaths as int))/sum(new_cases)) * 100 DeathPercentage from COVID_19_DATA_ANALYSIS..CovidDeaths

where continent is not null


--Continent wise total deaths

select location, sum(cast (new_deaths as int)) as Total_death_count from COVID_19_DATA_ANALYSIS..CovidDeaths
where continent is null and location not in ('world', 'European union', 'International')
group by location
order by Total_death_count  desc



-- percentage of people vaccinated in each country

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



--creating view to store data for later visualization


Create View percent_paople_Vaccinated as
Select cov. date, cov.location,population,   sum(cast(vac.new_vaccinations as int))over(partition by cov.location) as Rolling_vaccination_Rate from COVID_19_DATA_ANALYSIS..CovidDeaths as cov
join COVID_19_DATA_ANALYSIS..CovidVaccinations as vac
on cov.location = vac.location
and cov.date = vac.date
where cov.continent is not null





