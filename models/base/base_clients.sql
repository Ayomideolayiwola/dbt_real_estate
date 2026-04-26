select 
client_id,
client_type,
first_name,
last_name,
company_name,
date_of_birth,
nationality,
email,
phone,
address,
city_id,
iban,
tax_id,
is_verified,
registered_at

from {{ source('real_estate', 'clients') }}