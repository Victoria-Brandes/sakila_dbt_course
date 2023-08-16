{{config(materialized='incremental',unique_key='rental_id') }}

select*

from {{ ref('dim_rental')}} as rent
left join {{ ref('dim_customer')}} as cus
    on rent.dim_customer_id = cus.customer_id