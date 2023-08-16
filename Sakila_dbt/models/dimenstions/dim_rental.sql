{{config(materialized='ephemeral',unique_key='rental_id') }}

select 
r.rental_id,
r.rental_date,
r.inventory_id as dim_inventory_id,
r.customer_id as dim_customer_id,
r.return_date,
r.staff_id,
i.film_id,
i.store_id,
round(extract(epoch from (return_date-rental_date))/3600) as rental_time,
case 
	when return_date is not null then '[v]'
	else '[x]'
end as is_return,
'{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as rent_dbt_time

from rental r 
left join inventory i on r.inventory_id = i.inventory_id 