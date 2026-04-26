select 
type_id as property_type_id,
type_code as property_type_code,
type_name as property_type_name,
base_price_sqm,
typical_size_min,
typical_size_max,
is_residential

from {{ source('real_estate', 'property_types') }}