-- Business question: What is the current state of the property portfolio?
with properties as (
    select * from {{ ref('dim_properties') }}
),

last_txn as (
    select
        
        property_id,
        max(transaction_date)   as last_transaction_date,
        count(transaction_id)   as times_transacted
    from {{ ref('fct_transactions') }}
    group by property_id
)

select
    p.property_id,
    p.property_type_name,
    p.city_name,
    p.region_name,
    p.is_residential,
    p.size_sqm,
    p.num_bedrooms,
    p.num_bathrooms,
    p.has_parking,
    p.has_garden,
    p.has_balcony,
    p.condition_status,
    p.energy_class,
    p.listing_price,
    p.is_available,
    p.listed_at,
    l.last_transaction_date,
    l.times_transacted,
    datediff('day', p.listed_at, current_date())   as days_on_market

from properties p
left join last_txn l on p.property_id = l.property_id
