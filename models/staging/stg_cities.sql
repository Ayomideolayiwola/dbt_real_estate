select *
from {{ source('real_estate', 'cities') }}