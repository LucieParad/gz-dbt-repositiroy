WITH sum_table AS (

    SELECT 

        date_date,

        count(orders_id) as nb_order,

        round(sum (revenue),2) as revenue, 

        round(sum(operational_margin),2) as operational_margin,

        round(sum(purchase_cost),2) as purchase_cost,

        round(sum (shipping_fee),2) as shipping_fees,

        round(sum(log_cost),2) as log_cost,

        round(sum(total_quantity),2) as nb_product,        

    FROM {{ ref('int_orders_operational') }}

    Inner join {{ ref('stg_gz_raw_data__ship') }} using(orders_id)

    GROUP BY date_date)



select *,

round(safe_divide (revenue,nb_order),2) as average_basket

from sum_table