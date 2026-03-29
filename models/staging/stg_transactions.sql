select *
from {{ source('real_estate', 'transactions') }}