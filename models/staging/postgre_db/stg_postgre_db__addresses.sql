{{ config(
materialized='incremental',
incremental_strategy='append'
) }}

with 

source as (

    select * from {{ source('postgre_db', 'addresses') }}

),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed

{% if is_incremental() %}
WHERE ADDRESS_ID > (SELECT MAX(ADDRESS_ID) FROM {{ this }})
{% endif %}


