with properties as (
    select * from {{ ref('base_properties') }}
)

select
property_id,
property_type_id,
city_id,
agent_id,
address,
amenities,
condition_status,
build_year,
energy_class,
listing_price,
is_available,
listed_at
from properties

