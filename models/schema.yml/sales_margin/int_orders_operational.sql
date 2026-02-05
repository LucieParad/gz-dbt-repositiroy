SELECT 
    *,
    -- Calcul final de la marge opérationnel
    round(CAST(margin - ship_cost - log_cost as FLOAT64),2) AS operational_margin 
FROM {{ ref('int_orders_margin') }}