with transactions as (
    select * from {{ ref('prep_transactions') }}
),

properties as (
    select
        property_id,
        property_type_name,
        size_sqm,
        is_residential
    from {{ ref('dim_properties') }}
),

clients as (
    select
        *
    from {{ ref('dim_clients') }}
),

agents as (
    select
        agent_id,
        agent_name,
        agency_id,
        agency_name,
        specialization
    from {{ ref('dim_agents') }}
),

clients as (
    select
        *
    from {{ ref('dim_clients') }}
)

select
    -- keys
    t.transaction_id,
    t.transaction_ref,
    t.property_id,
    t.client_id,
    t.agent_id,
    t.payment_id,

    -- transaction details
    t.transaction_type,
    t.transaction_date,
    t.status,
    t.contract_start,
    t.contract_end,

    t.agreed_price,
    t.listing_price,
    t.discount_amount,
    t.commission_rate,
    t.commission_amount,
    round(t.agreed_price - t.listing_price, 2)           as price_vs_listing,
    round((t.discount_amount / nullif(t.listing_price,0)) * 100, 2) as discount_pct,

    -- property context
    p.property_type_name,
    c.city_id,
    c.city_name,
    --c.region_id,
    --c.region_name,
    p.size_sqm,
    p.is_residential,

    -- agent context
    a.agent_name,
    a.agency_id,
    a.agency_name,
    a.specialization         as agent_specialization,

    -- client context
    c.client_name,
    c.client_type,

    -- date parts for easy slicing
    year(t.transaction_date)       as transaction_year,
    month(t.transaction_date)     as transaction_month,
    quarter(t.transaction_date)      as transaction_quarter

from transactions t
left join properties p on t.property_id = p.property_id
left join agents     a on t.agent_id    = a.agent_id
left join clients    c on t.client_id   = c.client_id
