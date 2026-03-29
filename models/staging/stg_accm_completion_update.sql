select *
from {{ source('real_estate', 'accm_completion_update') }}