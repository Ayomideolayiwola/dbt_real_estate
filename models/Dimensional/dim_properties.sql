with properties as (
    select * from {{ ref('prep_properties') }}
    
),

property_types as (
    select * from {{ ref('prep_property_types') }}
),

cities as (
    select * from {{ ref('prep_cities') }}
),

regions as (
    select * from {{ ref('prep_regions') }}
)

select
property_id,
pt.property_type_name,
c.city_id,
city_name,
r.region_id,
region_name,
--agent_id,
address,
floor_number,
total_floors,
size_sqm,
num_bedrooms,
num_rooms,
num_bathrooms,
has_parking,
has_garden,
has_balcony,
amenities,
condition_status,
build_year,
energy_class,
listing_price,
listed_at,
is_available,
is_residential
from properties p
left join property_types pt 
on p.property_type_id = pt.property_type_id
join cities c
on p.city_id = c.city_id
join regions r
on c.region_id = r.region_id
