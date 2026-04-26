with agents as (
    select * from {{ ref('prep_agents') }}
),

agencies as (
    select * from {{ ref('prep_agencies') }}
),

region as (
    select * from {{ ref('prep_regions') }}
),

city as (
    select * from {{ ref('prep_cities') }}
)

select
{{ dbt_utils.generate_surrogate_key(['ag.agent_id', 'agy.agency_id']) }} as surrogate_key,
agent_id,
agy.agency_id,
full_name as agent_name,
agy.agency_name,
specialization,
years_experience,
c.city_id,
r.region_name,
r.population
from agents ag
join agencies agy
on ag.agency_id = agy.agency_id
join city c
on agy.city_id = c.city_id
join region r
on c.region_id = r.region_id
order by agent_id