with prop as (
    select *
    from {{ ref('prep_properties') }}

),

transactions as (   
    select *
    from {{ ref('prep_transactions') }}
)



select distinct year(transaction_date) as year,
count_if(status = 'Completed') as completed_transactions,
count_if(status = 'Pending') as pending_transactions,
count_if(status = 'Cancelled') as cancelled_transactions,
count_if(status = 'Under Contract') as under_contract_transactions 
from prop
join transactions t
on prop.property_id = t.property_id
group by 1 
order by year