select *
from {{ source('real_estate', 'clients') }}