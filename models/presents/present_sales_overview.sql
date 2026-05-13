--Business question: How are sales performing by city, region, and property type over time?


with transactions as (
    select * from {{ ref('fct_transactions') }}
    where status = 'Completed'
      and transaction_type = 'Sale'
),

date as (
    select * from {{ ref('dim_dates') }}
)

select
    year,
    month_name,
    quarter_name,
    --region_name,
    city_name,
    property_type_name,
    is_residential,

    -- volume
    count(transaction_id)     as total_sales,
    sum(agreed_price)    as total_revenue,
    avg(agreed_price)   as avg_sale_price,
    min(agreed_price)  as min_sale_price,
    max(agreed_price)   as max_sale_price,

    -- discount analysis
    avg(discount_pct)   as avg_discount_pct,
    sum(discount_amount)  as total_discounts_given,

    -- commission
    sum(commission_amount)   as total_commissions,
    avg(commission_rate) as avg_commission_rate

from transactions
join date
    on transactions.transaction_date = date.date_id
group by 1, 2, 3, 4, 5, 6
