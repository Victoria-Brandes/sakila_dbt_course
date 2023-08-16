{{config(materialized='incremental',post_hook="insert into {{this}}(film_id) VALUES (-1)",unique_key='film_id') }}

select*
from {{ ref('dim_film') }}