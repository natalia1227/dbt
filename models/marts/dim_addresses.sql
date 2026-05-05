select *
from {{ ref('stg_postgre_db__addresses') }}
