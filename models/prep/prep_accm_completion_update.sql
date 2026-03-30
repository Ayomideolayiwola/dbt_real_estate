with accm_completion_update as (
    select * from {{ ref('stg_accm_completion_update') }}
)

select
txn_id,
accm_txn_complete_time
from accm_completion_update

