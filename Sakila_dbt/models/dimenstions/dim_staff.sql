{{config(materialized='incremental',unique_key='staff_id')}}

select*
from staff
