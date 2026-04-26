-- top agencies sales
-- question answered what are the top 10 agencies by total sales and total commission earned in completed transactions?
-- and what is the percentage difference in total sales compared to the previous ranked agency and the top ranked agency?

with dim_agents as (
    select * from {{ ref('dim_agents') }}
    ),

transactions as (
    select * from {{ ref('fct_transactions') }}
),

dates as (
    select * from {{ ref('dim_dates') }}
),

agency_total as (
select distinct da.agency_id,
da.agency_name,
d.year,
count (distinct da.agent_id) as total_agents,
sum(t.agreed_price) as total_transactions,
rank() over (order by sum(t.agreed_price) desc) as agency_rank
from dim_agents as da
join transactions as t
on da.agent_id = t.agent_id
join dates as d
on t.transaction_date = d.date_id
where t.status = 'Completed'
     and d.year = 2025
group by da.agency_id, da.agency_name, d.year
order by total_transactions desc
)




select 
year,
agency_id,
agency_name,
total_agents,
total_transactions,
agency_rank,

round( 
        -100 *
       (total_transactions - lag(total_transactions) over (order by agency_rank))/
       nullif(lag(total_transactions) over (order by agency_rank),0)
     , 2) as pct_diff,
round (
        -100 * 
        (total_transactions - first_value(total_transactions) over (order by agency_rank))/
        nullif(first_value(total_transactions) over (order by agency_rank),0)
     , 2) as cummulative_pct_diff
from agency_total
--order by total_transactions desc




