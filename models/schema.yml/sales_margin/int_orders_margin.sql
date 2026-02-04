WITH purchase_cost_table AS (
    SELECT 
        products_id,
        orders_id,
        date_date,
        SUM(quantity) AS quantity,
        round(SUM(revenue),2) AS revenue,
        -- Calcul du coût d'achat total par produit/commande
        round (SUM(CAST(quantity AS FLOAT64) * CAST(purchase_price AS FLOAT64)),2) AS purchase_cost
    FROM {{ ref('stg_gz_raw_data__sales') }}
    INNER JOIN {{ ref('stg_gz_raw_data__product') }} USING (products_id)
    GROUP BY products_id, orders_id, date_date
),

orders_aggregation AS (
    SELECT 
        orders_id,
        date_date,
        SUM(quantity) AS total_quantity,
        SUM(revenue) AS total_revenue,
        SUM(purchase_cost) AS total_purchase_cost
    FROM purchase_cost_table
    -- Si tu as besoin de colonnes de 'ship', assure-toi qu'elles sont dans le SELECT ou le GROUP BY
    INNER JOIN {{ ref('stg_gz_raw_data__ship') }} USING (orders_id)
    GROUP BY orders_id, date_date
)

SELECT 
    *,
    -- Calcul final de la marge au niveau de la commande
    CAST(total_revenue - total_purchase_cost AS FLOAT64) AS margin 
FROM orders_aggregation