with property_types as (
    select * from {{ ref('base_property_types') }}
)

select
property_type_id,
property_type_code,
property_type_name,
base_price_sqm,
typical_size_min,
typical_size_max,
is_residential
from property_types

