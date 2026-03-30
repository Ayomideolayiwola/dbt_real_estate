with cities as (
    select * from {{ ref('stg_cities') }}
)

select
city_id,
region_id,
city_name,
postal_code,
latitude,
longitude,
population,
is_major_city
from cities


