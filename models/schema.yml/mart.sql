WITH sum_table AS (
    SELECT 
        date_date,
        count(orders_id) as nb_order,
        sum (revenue) as revenue, 
        sum(operational_margin) as operational_margin,
        sum(purchase_cost) as purshase_cost,
        sum (shipping_fees) as shipping_fees,
        sum(log_cost) as log_cost,
        sum(total_quantity),        
    FROM {{ ref('int_orders_operational') }}
    Inner join {{ ref('stg_gz_raw_data__ship') }}
    GROUP BY data_date

select *,
safe_divide (revenue,nb_order)
from sum_table