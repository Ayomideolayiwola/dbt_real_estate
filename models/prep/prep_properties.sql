with properties as (
    select * from {{ ref('stg_properties') }}
)

select
property_id,
type_id as property_type_id,
city_id,
agent_id,
address,
postal_code,
floor_number,
total_floors,
size_sqm,
num_rooms,
num_bedrooms,
num_bathrooms,
has_parking,
has_garden,
has_balcony,
amenities,
condition_status,
build_year,
energy_class,
listing_price,
is_available,
listed_at,
latitude,
longitude
from properties

