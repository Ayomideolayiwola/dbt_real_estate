select *
from {{ source('real_estate', 'properties') }}