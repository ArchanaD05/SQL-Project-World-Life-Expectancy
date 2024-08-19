############ EDA

select *
	from world_life_expentancy.world_life_expectancy
;

select Country, MIN('Life expectancy'), MAX('Life expectancy'), MAX('Life expectancy') - MIN('Life expectancy')
from world_life_expentancy.world_life_expectancy
group by Country
having min('Life expectancy') <> 0 
and MAX('Life expectancy') <> 0
order by Country DESC
;

select Year,  round(avg('Life expectancy'), 2)
from world_life_expentancy.world_life_expectancy
where 'Life expectancy' <> 0
and 'Life expectancy' <> 0
group by Year
order by Year
;

select Country, round(avg('Life expectancy'),1) as Life_exp, round(avg(GDP),1) as GDP
from world_life_expentancy.world_life_expectancy
group by Country
having Life_exp > 0
and GDP > 0
order by GDP ASC
;

select 
sum(case when GDP >=1500 then 1 else 0 end) High_GDP_Count,
avg(case when GDP >=1500 then 'Life expectancy' else null end) High_GDP_Life_Expectancy,
sum(case when GDP <=1500 then 1 else 0 end) Low_GDP_Count,
avg(case when GDP <=1500 then 'Life expectancy' else null end) Low_GDP_Life_Expectancy
from world_life_expentancy.world_life_expectancy
;

select Status, round(avg('Life expectancy'),1)
from world_life_expentancy.world_life_expectancy
group by Status
;

select Status, count(distinct Country), round(avg('Life expectancy'),1)
from world_life_expentancy.world_life_expectancy
group by Status
;

select Country, round(avg('Life expectancy'),1) as Life_exp, round(avg(BMI),1) as BMI
from world_life_expentancy.world_life_expectancy
group by Country
having Life_exp > 0
and BMI > 0
order by BMI desc
;

select Country, 
Year, 
'Life expectancy',
'Adult Mortality',
sum('Adult Mortality') over(partition by Country order by Year) as Rolling_Total
from world_life_expentancy.world_life_expectancy
where Country like '%United%' 
;




