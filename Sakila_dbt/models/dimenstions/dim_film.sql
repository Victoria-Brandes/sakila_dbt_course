{{config(materialized='ephemeral',unique_key='film_id') }}

select 
f.film_id ,
f.title ,
f.description ,
f.release_year ,
f.length,
case 
	when length <=75 then 'short'
	when length between 75 and 120 then 'medium'
	when length >120 then 'long'
end as range_len,
coalesce(f.language_id,0)as origina_language_null,
l.name as lan_name,
f.rental_rate,
c.name as category_name,
f.rental_duration ,
f.last_update ,
f.special_features ,
'{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as rent_dbt_time
from film f 
left join language as l on f.language_id = l.language_id 
left join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
