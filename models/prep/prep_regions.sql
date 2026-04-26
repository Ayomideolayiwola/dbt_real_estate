with regions as (
    select * from {{ ref('base_regions') }}
)

select
region_id,
region_code,
region_name,
price_multiplier,
population
from regions


