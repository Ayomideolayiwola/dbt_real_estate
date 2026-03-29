select *
from {{ source('real_estate', 'payment_details') }}