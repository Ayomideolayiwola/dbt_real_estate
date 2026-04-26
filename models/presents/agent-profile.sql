with dim_agent as (
    select * from {{ ref('dim_agents') }}
),

transactions as (
    select * from {{ ref('fct_transactions') }}
), 

dates as (
    select * from {{ ref('dim_dates') }}
),

properties as (
    select * from {{ ref('dim_properties') }}
),

agent_totals as (
    select 
        da.agent_id,
        d.year,
        da.agent_name,
        da.years_experience,
        count(t.agent_id)            as total_deals_completed,
        round(sum(t.agreed_price), 0) as total_sales,
        sum(t.commission_amount)     as total_commission,
    count_if( transaction_type = 'Sale') as Sales,
    count_if(transaction_type = 'Rental') as Rental,
    count_if(transaction_type = 'Lease') as Lease,
    count_if(condition_status = 'Fair') as Fair,
    count_if(condition_status = 'Good') as Good,
    count_if(condition_status = 'Needs Renovation') as Needs_Renovation,
    count_if(condition_status = 'New') as New,
    count_if(condition_status = 'Under Construction') as Under_Construction
    from dim_agent da
    join transactions t
        on da.agent_id = t.agent_id
    join dates d
        on t.transaction_date = d.date_id
    join properties p
        on t.property_id = p.property_id
    where t.status = 'Completed'
        and d.year = 2025
    group by 1,2,3,4
)

select 
    agent_id,
    year,
    agent_name,
    years_experience,
    total_deals_completed,
    sales,
    rental,
    Lease,
    New,
    Good,
    Fair,
    Needs_Renovation,
    Under_Construction,
    total_sales,
    total_commission,
    rank() over (order by total_commission desc) as commission_rank,
    rank() over (order by total_sales desc) as sales_rank
from agent_totals
order by commission_rank 
