{{config(materialized='incremental',post_hook="insert into {{this}}(dim_store_id) VALUES (-1)",unique_key='dim_store_id')}}

with dim_staff_data as
    (select
        staff_id as dim_staff_id,
        first_name as dim_first_name,
        last_name as dim_last_name,
        address_id as dim_address_id,
        email as dim_email,
        store_id as dim_store_id,
        active as dim_active,
        username as dim_username,
        last_update as dim_last_update
    from {{ ref('dim_staff') }}  
 )
select
    ds.dim_staff_id,
    {{ concat_it('ds.dim_first_name', 'ds.dim_last_name') }} as the_full_name,
    ds.dim_store_id,
    ds.dim_email,
    ds.dim_active,
    ds.dim_username,
    ds.dim_address_id,
    address,
    city,
    country,
    ds.dim_last_update,
    '{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as dbt_time
       from dim_staff_data as ds
        join store as s on ds.dim_staff_id = s.manager_staff_id
        join address as a on s.address_id = a.address_id
        join city as c on a.city_id = c.city_id
        join country as co on c.country_id = co.country_id