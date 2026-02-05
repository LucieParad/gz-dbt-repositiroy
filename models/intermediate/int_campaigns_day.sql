select 
date_date, 
count (paid_source) as nb_paid_source,
count (campaign_key) as nb_campaign,
sum(ads_cost) as total_ads_cost,
sum (impression) as total_impression,
sum (click) as total_click
from {{ ref('int_campaigns') }}
group by date_date 
order by date_date desc