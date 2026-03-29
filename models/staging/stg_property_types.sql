select *
from {{ source('real_estate', 'property_types') }}