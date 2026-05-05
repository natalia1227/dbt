select *
from {{ ref('stg_postgre_db__orders') }}