with agents as (
    select * from {{ ref('base_agents') }}
)

select
agent_id,
agency_id,
concat(first_name, ' ', last_name) as full_name,
email,
phone,
hire_date,
specialization,
years_experience
from agents
