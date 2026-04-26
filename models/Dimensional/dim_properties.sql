with properties as (
    select * from {{ ref('prep_properties') }}
    
),

property_types as (
    select * from {{ ref('prep_property_types') }}
)


select
property_id,
pt.property_type_name,
city_id,
agent_id,
amenities,
condition_status,
listing_price,
listed_at,
is_residential
from properties p
left join property_types pt 
on p.property_type_id = pt.property_type_id
