
{% macro delete_from_table(table) %}

{% set query %}
delete from sakila_wh.{{ table }};
{% endset %}

{% do run_query(query) %}

{% endmacro %}