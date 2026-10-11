
-- Project: Thamak Supply Chain Analytics
-- Purpose: Analyse inventory movements, balances and stock cover.
-- Data: Simulated data created for analytical demonstration.

-- 1. Reconcile inventory receipts and shipments
SELECT
    ROUND(SUM(quantity_in_kg)::numeric, 2) AS total_received_kg,
    ROUND(SUM(quantity_out_kg)::numeric, 2) AS total_shipped_kg,
    ROUND(
        (SUM(quantity_in_kg) - SUM(quantity_out_kg))::numeric,
        2
    ) AS calculated_closing_inventory_kg
FROM inventory_transactions;


-- 2. Monthly inventory movements and closing balance
WITH monthly_movements AS (
    SELECT
        DATE_TRUNC('month', transaction_date)::date AS month,
        SUM(quantity_in_kg) AS received_kg,
        SUM(quantity_out_kg) AS shipped_kg
    FROM inventory_transactions
    GROUP BY 1
)
SELECT
    month,
    ROUND(received_kg::numeric, 2) AS received_kg,
    ROUND(shipped_kg::numeric, 2) AS shipped_kg,
    ROUND(
        SUM(received_kg - shipped_kg)
        OVER (ORDER BY month)::numeric,
        2
    ) AS closing_inventory_kg
FROM monthly_movements
ORDER BY month;


-- 3. Monthly inventory cover using a continuous calendar
-- Includes months with zero demand so the three-month average
-- always represents three calendar months.
WITH month_calendar AS (
    SELECT DISTINCT
        DATE_TRUNC('month', date)::date AS month
    FROM date_dimension
),
monthly_inventory AS (
    SELECT
        DATE_TRUNC('month', transaction_date)::date AS month,
        SUM(quantity_in_kg - quantity_out_kg) AS net_movement_kg
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
monthly_series AS (
    SELECT
        mc.month,
        COALESCE(mi.net_movement_kg, 0) AS net_movement_kg,
        COALESCE(md.demand_kg, 0) AS demand_kg
    FROM month_calendar mc
    LEFT JOIN monthly_inventory mi
        ON mc.month = mi.month
    LEFT JOIN monthly_demand md
        ON mc.month = md.month
),
inventory_and_demand AS (
    SELECT
        month,
        demand_kg,
        SUM(net_movement_kg)
            OVER (ORDER BY month) AS closing_inventory_kg,
        AVG(demand_kg) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS average_demand_3_months_kg,
        COUNT(*) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS months_in_average
    FROM monthly_series
)
SELECT
    month,
    ROUND(closing_inventory_kg::numeric, 2)
        AS closing_inventory_kg,
    ROUND(demand_kg::numeric, 2) AS monthly_demand_kg,
    ROUND(average_demand_3_months_kg::numeric, 2)
        AS average_demand_3_months_kg,
    CASE
        WHEN months_in_average = 3
         AND average_demand_3_months_kg > 0
        THEN ROUND(
            (closing_inventory_kg / average_demand_3_months_kg)::numeric,
            2
        )
        ELSE NULL
    END AS inventory_cover_months
FROM inventory_and_demand
WHERE month >= DATE '2025-07-01'
ORDER BY month;


-- 4. Remaining stock by batch, aged from the latest simulated
-- inventory transaction rather than the real-world current date.
WITH latest_date AS (
    SELECT MAX(transaction_date) AS analysis_date
    FROM inventory_transactions
),
batch_movements AS (
    SELECT
        batch_id,
        MIN(transaction_date) FILTER (
            WHERE transaction_type = 'Curing Completed'
        ) AS received_date,
        SUM(quantity_in_kg) AS received_kg,
        SUM(quantity_out_kg) AS shipped_kg
    FROM inventory_transactions
    GROUP BY batch_id
)
SELECT
    bm.batch_id,
    bm.received_date,
    ld.analysis_date,
    ld.analysis_date - bm.received_date AS inventory_age_days,
    ROUND(bm.received_kg::numeric, 2) AS received_kg,
    ROUND(bm.shipped_kg::numeric, 2) AS shipped_kg,
    ROUND((bm.received_kg - bm.shipped_kg)::numeric, 2)
        AS closing_balance_kg
FROM batch_movements bm
CROSS JOIN latest_date ld
WHERE bm.received_date IS NOT NULL
  AND bm.received_kg - bm.shipped_kg > 0
ORDER BY inventory_age_days DESC;
