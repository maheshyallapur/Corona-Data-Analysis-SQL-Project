-- Total Cases Vs Total Deaths --

select location,date1,total_cases,total_deaths,
round((total_deaths/total_cases)*100,2) as Death_Percentage
from covid_deaths
order by Death_Percentage desc

select location,date1,total_cases,total_deaths,
round((total_deaths/total_cases)*100,2)  as Death_Percentage 
from covid_deaths 
where location='India'
order by Death_Percentage desc

-- Total Cases Vs Population --

select location,date1,population,total_cases,
round((total_cases/population)*100,2) as Infected_Percentage from
covid_deaths 
where location='India'
order by Infected_Percentage desc

select location,date1,population,total_cases,
round((total_cases/population)*100,2) as Infected_Percentage from
covid_deaths 
where location='china'
order by Infected_Percentage desc

select location,date1,population,total_cases,
round((total_cases/population)*100,2) as Infected_Percentage from
covid_deaths 
where location='United states'
order by Infected_Percentage desc

select location,date1,population,total_cases,
round((total_cases/population)*100,2) as Infected_Percentage from
covid_deaths 
order by Infected_Percentage desc

-- Countries with Highest Infected/Infection Rate Compared to Population --

select location,population,max(total_cases) as Highest_Infected_Count,
round(max((total_cases/population)*100),2) as Infection_Percentage
from covid_deaths
group by location,population
order by Infection_Percentage desc  

-- Countries with Highest Death Count Per Population --

Select location,max(total_deaths) as Total_Death_Count
from covid_deaths
where continent is not null
group by location
order by Total_Death_Count Desc   

select continent ,max(total_deaths) as Total_Death_Count 
from covid_deaths 
where continent ='Asia'
group by continent
order by Total_Death_Count

select location,max(total_deaths) as Total_Death_Count
from covid_deaths
where continent is not null
group by location
order by Total_Death_Count desc

-- Global Numbers --

select date1,sum(new_cases) as Total_New_Cases
from covid_deaths
where continent is not null
group by date1
order by Total_New_Cases desc

select date1,sum(new_cases) as Total_New_Cases,sum(new_deaths) as Total_Death_Count,
round((sum(new_deaths)/sum(new_cases))*100,2) as Death_Percentage 
from covid_deaths
where continent is not null
group by date1
order by Total_New_Cases desc

select date1,sum(new_cases) as Total_New_Cases,
sum(new_deaths) as Total_New_Deaths,
round((sum(new_deaths)/sum(new_cases)*100),2)  as Death_Percentage from 
covid_deaths
where continent is not null
group by date1
order by Total_New_Cases desc

select sum(new_cases) as Total_New_Cases,
sum(total_deaths) as Total_Deaths,
round((sum(new_deaths)/sum(new_cases))*100,2)  as Death_Percentage
from covid_deaths
where continent is not null
order by 1,2

select *
from covid_deaths d
join covid_vaccination v
on d.location=v.location and d.date1=v.date1

-- Total Population Vs Vaccinations --

select d.continent,d.location,d.date1,d.population,
v.new_vaccinations from covid_deaths d
join covid_vaccination v
on d.location=v.location and d.date1=v.date1
where d.continent='Asia'
order by v.new_vaccinations desc

select d.continent,d.location,d.date1,d.population,v.new_vaccinations,
sum(new_vaccinations) over(partition by d.location order by d.location,d.date1) as Vaccination_Count
from covid_deaths d join covid_vaccination v
on d.location=v.location and d.date1=v.date1
where d.continent is not null
order by Vaccination_Count desc

with PopvsVac(continent,location,date1,population,new_vaccination,RollingPeopleVaccinated) 
as
(select d.continent,d.location,d.date1,d.population,v.new_vaccinations,
sum(new_vaccinations) over(partition by d.location order by d.location,d.date1) as RollingPeopleVaccinated
from covid_deaths d join covid_vaccination v
on d.location=v.location and d.date1=v.date1
where d.continent is not null
order by Vaccination_Count desc)

create view Percent_Population_Vaccinated as 
select d.continent,d.location,d.date1,d.population,v.new_vaccinations,
sum(new_vaccinations) over(partition by d.location order by d.location,d.date1) as RollingPeopleVaccinated
from covid_deaths d join covid_vaccination v
on d.location=v.location and d.date1=v.date1
where d.continent='Asia'
order by RollingPeopleVaccinated desc
drop view Percent_Population_Vaccinated

select * from Percent_Population_Vaccinated











