{{ config(materialized='incremental',post_hook="insert into {{this}}(customer_id) VALUES (-1)",unique_key='customer_id') }}


select
	customer.customer_id::int,
	concat(customer.first_name,' ',customer.last_name) as full_name,
	substring(email from POSITION('@' in email)+1 for char_length(email)-POSITION('@' in email)) as domain,
	address.address,
	city.city,
	(case when customer.active = 0 then 'no' else 'yes' end)::varchar(100) as "active_desc",
	customer.create_date::timestamp,
	customer.last_update::timestamp,
    '{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_time
from
	customer as customer

	left join address on 1=1
	and customer.address_id =address.address_id

	left join city on 1=1
	and address.city_id = city.city_id
	order by customer_id
	