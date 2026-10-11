
-- Project: Thamak Supply Chain Analytics
-- Purpose: Analyse customer demand, fulfilment and unmet orders.
-- Data: Simulated data created for analytical demonstration.

-- 1. Overall demand and fulfilment performance
SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(ordered_kg)::numeric, 2) AS total_demand_kg,
    ROUND(SUM(fulfilled_kg)::numeric, 2) AS fulfilled_kg,
    ROUND(SUM(unfulfilled_kg)::numeric, 2) AS unfulfilled_kg,
    ROUND(
        100.0 * SUM(fulfilled_kg)
        / NULLIF(SUM(ordered_kg), 0),
        2
    ) AS fulfilment_rate_pct
FROM fulfilment;


-- 2. Monthly demand and fulfilment
SELECT
    DATE_TRUNC('month', co.order_date)::date AS order_month,
    ROUND(SUM(f.ordered_kg)::numeric, 2) AS demand_kg,
    ROUND(SUM(f.fulfilled_kg)::numeric, 2) AS fulfilled_kg,
    ROUND(SUM(f.unfulfilled_kg)::numeric, 2) AS unfulfilled_kg,
    ROUND(
        100.0 * SUM(f.fulfilled_kg)
        / NULLIF(SUM(f.ordered_kg), 0),
        2
    ) AS fulfilment_rate_pct
FROM customer_orders co
JOIN fulfilment f
    ON co.order_id = f.order_id
GROUP BY 1
ORDER BY 1;


-- 3. Fulfilment performance by customer segment
SELECT
    c.customer_type,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(DISTINCT co.order_id) AS order_count,
    ROUND(SUM(f.ordered_kg)::numeric, 2) AS demand_kg,
    ROUND(SUM(f.fulfilled_kg)::numeric, 2) AS fulfilled_kg,
    ROUND(SUM(f.unfulfilled_kg)::numeric, 2) AS unfulfilled_kg,
    ROUND(
        100.0 * SUM(f.fulfilled_kg)
        / NULLIF(SUM(f.ordered_kg), 0),
        2
    ) AS fulfilment_rate_pct
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
JOIN fulfilment f
    ON co.order_id = f.order_id
GROUP BY c.customer_type
ORDER BY demand_kg DESC;


-- 4. Fulfilment performance by destination country
SELECT
    c.country,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(DISTINCT co.order_id) AS order_count,
    ROUND(SUM(f.ordered_kg)::numeric, 2) AS demand_kg,
    ROUND(SUM(f.fulfilled_kg)::numeric, 2) AS fulfilled_kg,
    ROUND(SUM(f.unfulfilled_kg)::numeric, 2) AS unfulfilled_kg,
    ROUND(
        100.0 * SUM(f.fulfilled_kg)
        / NULLIF(SUM(f.ordered_kg), 0),
        2
    ) AS fulfilment_rate_pct
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
JOIN fulfilment f
    ON co.order_id = f.order_id
GROUP BY c.country
ORDER BY demand_kg DESC;


-- 5. Orders with outstanding quantities
SELECT
    co.order_id,
    c.customer_name,
    c.customer_type,
    co.order_date,
    co.required_delivery_date,
    ROUND(f.ordered_kg::numeric, 2) AS ordered_kg,
    ROUND(f.fulfilled_kg::numeric, 2) AS fulfilled_kg,
    ROUND(f.unfulfilled_kg::numeric, 2) AS unfulfilled_kg,
    f.fulfilment_status
FROM customer_orders co
JOIN customers c
    ON co.customer_id = c.customer_id
JOIN fulfilment f
    ON co.order_id = f.order_id
WHERE f.unfulfilled_kg > 0
ORDER BY f.unfulfilled_kg DESC;


-- 6. Monthly supply versus demand
-- A negative monthly balance does not necessarily mean a stockout:
-- inventory carried forward may still satisfy customer demand.
WITH monthly_supply AS (
    SELECT
        DATE_TRUNC('month', transaction_date)::date AS month,
        SUM(quantity_in_kg) AS supply_kg
    FROM inventory_transactions
    GROUP BY 1
),
monthly_demand AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(quantity_kg) AS demand_kg
    FROM customer_orders
    GROUP BY 1
),
months AS (
    SELECT month FROM monthly_supply
    UNION
    SELECT month FROM monthly_demand
)
SELECT
    m.month,
    ROUND(COALESCE(ms.supply_kg, 0)::numeric, 2) AS supply_kg,
    ROUND(COALESCE(md.demand_kg, 0)::numeric, 2) AS demand_kg,
    ROUND(
        (COALESCE(ms.supply_kg, 0)
        - COALESCE(md.demand_kg, 0))::numeric,
        2
    ) AS monthly_supply_demand_balance_kg
FROM months m
LEFT JOIN monthly_supply ms
    ON m.month = ms.month
LEFT JOIN monthly_demand md
    ON m.month = md.month
ORDER BY m.month;
