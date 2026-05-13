with cities as (
    select * from {{ ref('prep_cities') }}
),

regions as (
    select * from {{ ref('prep_regions') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['c.city_id', 'r.region_id']) }} as surrogate_key,
    c.city_id,
    c.city_name,
    c.population,
    c.is_major_city,
    r.region_id,
    r.region_name,
    r.region_code,
    r.price_multiplier
from cities c
left join regions r on c.region_id = r.region_id
