WITH purchase_cost_table AS (
 SELECT 
        products_id,
        SUM(quantity) AS total_quantity,
        SUM(revenue) AS total_revenue,
        -- Calcul du coût d'achat total
        SUM(CAST(quantity AS FLOAT64) * CAST(purchase_price AS FLOAT64)) AS purchase_cost
    FROM {{ ref('stg_gz_raw_data__sales') }}
    INNER JOIN {{ ref('stg_gz_raw_data__product') }} USING (products_id)
    GROUP BY products_id
)

SELECT 
    *,
    -- Calcul de la marge brute
    CAST(total_revenue - purchase_cost AS FLOAT64) AS margin,
    -- Appel de ta macro pour le pourcentage de marge
    {{ margin_percent('total_revenue', 'purchase_cost') }} AS margin_percent
FROM purchase_cost_table