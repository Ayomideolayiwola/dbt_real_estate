with agencies as (
    select * from {{ ref('stg_agencies') }}
)

select
agency_id,
agency_name,
license_number,
city_id,
address,
phone,
email,
website,
established_year,
is_active
from agencies



