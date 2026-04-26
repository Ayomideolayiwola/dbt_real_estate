with cities as (
    select * from {{ ref('base_cities') }}
)

select
city_id,
region_id,
city_name,
population,
is_major_city
from cities


