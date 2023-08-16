
SELECT COUNT(*) AS unique_customer_id
FROM {{ ref('dim_customer') }}

