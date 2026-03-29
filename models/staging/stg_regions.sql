select *
from {{ source('real_estate', 'regions') }}