select *
from {{ source('real_estate', 'agencies') }}