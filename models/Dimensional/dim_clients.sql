with clients as (
    select * from {{ ref('prep_clients') }}
),

cities as (
    select * from {{ ref('prep_cities') }}
),

regions as (
    select * from {{ ref('prep_regions') }}
),

client_details as (
select
client_id,
ci.city_id,
r.region_id,
c.client_type,
case when c.client_type = 'Individual' then concat(c.first_name, ' ', c.last_name) 
else c.company_name end as client_name,
c.date_of_birth,
c.email as client_email,
c.phone as client_phone,
c.address,
ci.city_name,
r.region_name,
c.nationality,
c.is_verified,
c.registered_at,
ci.population
from clients c
join cities ci
on c.city_id = ci.city_id
join regions r
on ci.region_id = r.region_id
)

select 
client_id,
city_id,
region_id,
client_type,
client_name,
client_email,
case when client_type = 'Individual' 
then DATEDIFF(year, date_of_birth, CURRENT_DATE)
else null end as age,
client_phone,
address,
city_name,
region_name,
nationality,
is_verified,
registered_at,
population
from client_details
order by client_id

