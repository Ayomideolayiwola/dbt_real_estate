select 
city_id,
region_id,
city_name,
postal_code,
latitude,
longitude,
population,
is_major_city

from {{ source('real_estate', 'cities') }}