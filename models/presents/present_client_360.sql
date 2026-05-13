

with transactions as (
    select * from {{ ref('fct_transactions') }}
),

payments as (
    select * from {{ ref('prep_payment_details') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['t.transaction_id', 't.client_id']) }} as client_txn_key,

    -- client info
    t.client_id,
    --t.client_name,
    t.client_type,

    -- transaction info
    t.transaction_id,
    t.transaction_ref,
    t.transaction_type,
    t.transaction_date,
    t.status,
    t.agreed_price,
    t.listing_price,
    t.discount_amount,
    t.commission_amount,
    t.price_vs_listing,
    t.discount_pct,

    -- property info
    t.property_id,
    t.property_type_name,
    t.city_name,
    --t.region_name,
    t.size_sqm,
    t.is_residential,

    -- agent info
    t.agent_name,
    t.agency_name,

    -- payment info
    p.payment_method,
    p.bank_name,
    p.mortgage_rate,
    p.mortgage_term_years,
    p.down_payment_pct

from transactions t
left join payments p on t.payment_id = p.payment_id
