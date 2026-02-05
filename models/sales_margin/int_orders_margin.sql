WITH purchase_cost_table AS (
    SELECT 
        count (products_id) as nb_product,
        orders_id,
        date_date,
        SUM(quantity) AS quantity,
        round(SUM(revenue),2) AS revenue,
        -- Calcul du coût d'achat total par produit/commande
        round (SUM(CAST(quantity AS FLOAT64) * CAST(purchase_price AS FLOAT64)),2) AS purchase_cost
    FROM {{ ref('stg_gz_raw_data__sales') }}
    INNER JOIN {{ ref('stg_gz_raw_data__product') }} USING (products_id)
    GROUP BY orders_id, date_date
),

orders_aggregation AS (
    SELECT 
        orders_id,
        date_date,
        SUM(quantity) AS total_quantity,
        round(SUM(revenue) + sum(CAST(shipping_fee AS FLOAT64)), 2) AS revenue, 
        round(SUM(purchase_cost),2) AS purchase_cost,
        round(sum(cast(ship_cost as FLOAT64)),2) as ship_cost, 
        round(sum(CAST(logcost as FLOAT64)), 2) as log_cost 
    FROM purchase_cost_table
    INNER JOIN {{ ref('stg_gz_raw_data__ship') }} USING (orders_id)
    GROUP BY orders_id, date_date
)

SELECT 
    *,
    -- Calcul final de la marge au niveau de la commande
    round(CAST(revenue - purchase_cost AS FLOAT64),2) AS margin 
FROM orders_aggregation