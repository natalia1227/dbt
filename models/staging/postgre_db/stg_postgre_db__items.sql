{{ config(
materialized='incremental',
unique_key='_FIVETRAN_SYNCED',
incremental_strategy='delete+insert'
) }}

with 

source as (

    select * from {{ source('postgre_db', 'order_items') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed

{% if is_incremental() %}
WHERE _FIVETRAN_SYNCED >= DATEADD(day, -3, CURRENT_DATE())
{% endif %}