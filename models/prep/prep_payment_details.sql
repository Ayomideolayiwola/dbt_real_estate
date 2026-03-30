with payment_details as (
    select * from {{ ref('stg_payment_details') }}
)


select
payment_id,
payment_method,
bank_name,
iban,
mortgage_rate,
mortgage_term_years,
down_payment_pct
from payment_details
