select 
date_date, 
round(operational_margin-total_ads_cost,2) as adds_margin, 
average_basket,
operational_margin,
total_ads_cost,
total_impression,
total_click,
nb_product,
revenue,
purchase_cost,
shipping_fees,
log_cost
from {{ ref('int_campaigns_day') }}
inner join {{ ref('finance_days') }} using (date_date)