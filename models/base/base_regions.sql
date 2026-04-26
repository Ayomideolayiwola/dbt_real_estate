select 
region_id,
region_code,
region_name,
price_multiplier,
capital_city,
population,
area_sqkm

from {{ source('real_estate', 'regions') }}