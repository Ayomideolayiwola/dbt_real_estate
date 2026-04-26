with transactions as (
    select * from {{ ref('prep_transactions') }}
)

select
transaction_id,
transaction_ref,
property_id,
client_id,
agent_id,
payment_id,
transaction_type,
transaction_date,
agreed_price,
listing_price,
discount_amount,
commission_rate,
commission_amount,
status,
contract_start,
contract_end,
notes,
created_at

from transactions
