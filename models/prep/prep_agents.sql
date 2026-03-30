with agents as (
    select * from {{ ref('stg_agents') }}
)

select
agent_id,
agency_id,
first_name,
last_name,
license_number,
email,
phone,
hire_date,
specialization,
years_experience,
is_active
from agents
