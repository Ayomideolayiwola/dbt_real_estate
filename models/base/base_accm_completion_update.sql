select 
txn_id,
accm_txn_complete_time

from {{ source('real_estate', 'accm_completion_update') }}


