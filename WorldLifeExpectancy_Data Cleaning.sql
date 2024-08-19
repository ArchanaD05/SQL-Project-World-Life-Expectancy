###### DATA CLEANING

SELECT * FROM world_life_expentancy.world_life_expectancy;

select Country, Year, concat(Country, Year), count(concat(Country, Year))
from world_life_expentancy.world_life_expectancy
group by Country, Year, concat(Country, Year)
having count(concat(Country, Year)) > 1
;

select *
from (
	select Row_ID, 
	concat(Country, Year),
	row_number() over(partition by concat(Country, Year) order by concat(Country, Year)) as Row_Num
	from world_life_expentancy.world_life_expectancy
) as Row_table
where Row_Num > 1
;

delete from world_life_expentancy.world_life_expectancy
where 
	Row_ID IN (
    select Row_ID
from (
	select Row_ID, 
	concat(Country, Year),
	row_number() over(partition by concat(Country, Year) order by concat(Country, Year)) as Row_Num
	from world_life_expentancy.world_life_expectancy
	) as Row_table
where Row_Num > 1
)
;

select *
from world_life_expentancy.world_life_expectancy
where Status = ''
;

select distinct(Status)
from world_life_expentancy.world_life_expectancy
where Status <> ''
;

select distinct(Country)
from world_life_expentancy.world_life_expectancy
where Status = 'Developing'
;

update world_life_expentancy.world_life_expectancy
set Status = 'Developing'
where Country IN (select distinct(Country)
				from world_life_expentancy.world_life_expectancy
				where Status = 'Developing')
;

update world_life_expentancy.world_life_expectancy t1
join world_life_expentancy.world_life_expectancy t2 
	on t1.Country = t2.Country
set t1.Status = 'Developing'
where t1.Status = ''
and t2.Status <> ''
and t2.Status = 'Developing'
;

update world_life_expentancy.world_life_expectancy t1
join world_life_expentancy.world_life_expectancy t2 
	on t1.Country = t2.Country
set t1.Status = 'Developed'
where t1.Status = ''
and t2.Status <> ''
and t2.Status = 'Developed'
;

select *
from world_life_expentancy.world_life_expectancy
where 'Life expectancy' = ''
;

select Country, Year, 'Life expectancy'
from world_life_expentancy.world_life_expectancy
where 'Life expectancy' = ''
;

select t1.Country, t1.Year, t1.'Life expectancy', 
	t2.Country, t2.Year, t2.'Life expectancy',
	t3.Country, t3.Year, t3.'Life expectancy'
from world_life_expentancy.world_life_expectancy t1
join world_life_expentancy.world_life_expectancy t2
	on t1.Country = t2.Country
    and t1.Year = t2.Year - 1
join world_life_expentancy.world_life_expectancy t3
	on t1.Country = t3.Country 
    and t1.Year = t3.Year + 1
where t1.'Life expectancy' = ''
;




