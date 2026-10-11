
-- Project: Thamak Supply Chain Analytics
-- Purpose: Analyse revenue, landed cost and gross profitability.
-- Data: Simulated data created for analytical demonstration.

-- Method:
-- Aggregate procurement costs at harvest level first because
-- each harvest has multiple purchase orders.
-- Allocate the weighted procurement cost to shipped quantities.
-- Add recorded shipment logistics costs to estimate landed cost.

WITH procurement_by_harvest AS (
    SELECT
        po.harvest_id,
        SUM(po.quantity_kg) AS purchased_kg,
        SUM(po.purchase_cost) AS procurement_cost,
        SUM(po.purchase_cost)
            / NULLIF(SUM(po.quantity_kg), 0)
            AS weighted_purchase_cost_per_kg
    FROM purchase_orders po
    GROUP BY po.harvest_id
),
shipment_profitability AS (
    SELECT
        sh.shipment_id,
        sh.order_id,
        sh.batch_id,
        sh.quantity_kg,
        co.selling_price_per_kg,
        sh.quantity_kg * co.selling_price_per_kg AS revenue,
        sh.quantity_kg * pbh.weighted_purchase_cost_per_kg
            AS allocated_procurement_cost,
        COALESCE(sh.logistics_cost, 0) AS logistics_cost
    FROM shipments sh
    JOIN customer_orders co
        ON sh.order_id = co.order_id
    JOIN curing_batches cb
        ON sh.batch_id = cb.batch_id
    JOIN procurement_by_harvest pbh
        ON cb.harvest_id = pbh.harvest_id
),
final_profitability AS (
    SELECT
        *,
        allocated_procurement_cost + logistics_cost AS landed_cost,
        revenue - allocated_procurement_cost - logistics_cost
            AS gross_profit
    FROM shipment_profitability
)

-- 1. Overall profitability
SELECT
    ROUND(SUM(quantity_kg)::numeric, 2) AS shipped_kg,
    ROUND(SUM(revenue)::numeric, 2) AS revenue_gbp,
    ROUND(SUM(allocated_procurement_cost)::numeric, 2)
        AS procurement_cost_gbp,
    ROUND(SUM(logistics_cost)::numeric, 2) AS logistics_cost_gbp,
    ROUND(SUM(landed_cost)::numeric, 2) AS landed_cost_gbp,
    ROUND(
        (SUM(landed_cost) / NULLIF(SUM(quantity_kg), 0))::numeric,
        2
    ) AS landed_cost_per_kg_gbp,
    ROUND(SUM(gross_profit)::numeric, 2) AS gross_profit_gbp,
    ROUND(
        (100.0 * SUM(gross_profit) / NULLIF(SUM(revenue), 0))::numeric,
        2
    ) AS gross_margin_pct,
    ROUND(
        (SUM(revenue) / NULLIF(SUM(quantity_kg), 0))::numeric,
        2
    ) AS average_selling_price_per_kg_gbp
FROM final_profitability;


-- 2. Profitability by customer segment
WITH procurement_by_harvest AS (
    SELECT
        harvest_id,
        SUM(purchase_cost)
            / NULLIF(SUM(quantity_kg), 0)
            AS weighted_purchase_cost_per_kg
    FROM purchase_orders
    GROUP BY harvest_id
),
shipment_profitability AS (
    SELECT
        c.customer_type,
        sh.quantity_kg,
        sh.quantity_kg * co.selling_price_per_kg AS revenue,
        sh.quantity_kg * pbh.weighted_purchase_cost_per_kg
            AS procurement_cost,
        COALESCE(sh.logistics_cost, 0) AS logistics_cost
    FROM shipments sh
    JOIN customer_orders co
        ON sh.order_id = co.order_id
    JOIN customers c
        ON co.customer_id = c.customer_id
    JOIN curing_batches cb
        ON sh.batch_id = cb.batch_id
    JOIN procurement_by_harvest pbh
        ON cb.harvest_id = pbh.harvest_id
)
SELECT
    customer_type,
    ROUND(SUM(quantity_kg)::numeric, 2) AS shipped_kg,
    ROUND(SUM(revenue)::numeric, 2) AS revenue_gbp,
    ROUND(SUM(procurement_cost)::numeric, 2) AS procurement_cost_gbp,
    ROUND(SUM(logistics_cost)::numeric, 2) AS logistics_cost_gbp,
    ROUND(
        SUM(procurement_cost + logistics_cost)::numeric, 2
    ) AS landed_cost_gbp,
    ROUND(
        SUM(revenue - procurement_cost - logistics_cost)::numeric, 2
    ) AS gross_profit_gbp,
    ROUND(
        (
            100.0 * SUM(revenue - procurement_cost - logistics_cost)
            / NULLIF(SUM(revenue), 0)
        )::numeric,
        2
    ) AS gross_margin_pct
FROM shipment_profitability
GROUP BY customer_type
ORDER BY gross_profit_gbp DESC;


-- 3. Profitability by product grade
WITH procurement_by_harvest AS (
    SELECT
        harvest_id,
        SUM(purchase_cost)
            / NULLIF(SUM(quantity_kg), 0)
            AS weighted_purchase_cost_per_kg
    FROM purchase_orders
    GROUP BY harvest_id
),
shipment_profitability AS (
    SELECT
        cb.quality_grade,
        sh.quantity_kg,
        sh.quantity_kg * co.selling_price_per_kg AS revenue,
        sh.quantity_kg * pbh.weighted_purchase_cost_per_kg
            AS procurement_cost,
        COALESCE(sh.logistics_cost, 0) AS logistics_cost
    FROM shipments sh
    JOIN customer_orders co
        ON sh.order_id = co.order_id
    JOIN curing_batches cb
        ON sh.batch_id = cb.batch_id
    JOIN procurement_by_harvest pbh
        ON cb.harvest_id = pbh.harvest_id
)
SELECT
    quality_grade,
    ROUND(SUM(quantity_kg)::numeric, 2) AS shipped_kg,
    ROUND(SUM(revenue)::numeric, 2) AS revenue_gbp,
    ROUND(
        SUM(procurement_cost + logistics_cost)::numeric, 2
    ) AS landed_cost_gbp,
    ROUND(
        SUM(revenue - procurement_cost - logistics_cost)::numeric, 2
    ) AS gross_profit_gbp,
    ROUND(
        (
            100.0 * SUM(revenue - procurement_cost - logistics_cost)
            / NULLIF(SUM(revenue), 0)
        )::numeric,
        2
    ) AS gross_margin_pct
FROM shipment_profitability
GROUP BY quality_grade
ORDER BY gross_profit_gbp DESC;
