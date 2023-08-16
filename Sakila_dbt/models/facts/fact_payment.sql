{{config(materialized='incremental',unique_key='payment_id') }}

select*,
'{{run_started_at.strftime("%y-%m-%d %H:%M:%S")}}' as rent_dbt_time
from payment