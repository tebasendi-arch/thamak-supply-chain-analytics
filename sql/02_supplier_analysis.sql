
-- Project: Thamak Supply Chain Analytics
-- Purpose: Analyse supplier procurement, delivery and quality performance.
-- Data: Simulated data created for analytical demonstration.

-- 1. Procurement cost and delivery performance by supplier
SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(po.po_id) AS purchase_order_count,
    ROUND(SUM(po.quantity_kg)::numeric, 2) AS purchased_kg,
    ROUND(
        SUM(po.purchase_cost)::numeric
        / NULLIF(SUM(po.quantity_kg), 0),
        2
    ) AS weighted_purchase_cost_per_kg,
    ROUND(AVG(po.delivery_delay_days)::numeric, 2)
        AS average_delivery_delay_days,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE po.actual_delivery_date <= po.expected_delivery_date
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS on_time_delivery_rate_pct
FROM suppliers s
JOIN purchase_orders po
    ON s.supplier_id = po.supplier_id
GROUP BY
    s.supplier_id,
    s.supplier_name
ORDER BY weighted_purchase_cost_per_kg;


-- 2. CoA results by supplier
-- Uses the project-defined specification thresholds.
SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(cb.batch_id) AS batches_tested,
    ROUND(AVG(cb.moisture_pct)::numeric, 2) AS average_moisture_pct,
    ROUND(AVG(cb.vanillin_pct)::numeric, 2) AS average_vanillin_pct,
    COUNT(*) FILTER (
        WHERE cb.moisture_pct BETWEEN 30.00 AND 35.00
          AND cb.vanillin_pct >= 2.00
    ) AS batches_passing_specification,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE cb.moisture_pct BETWEEN 30.00 AND 35.00
              AND cb.vanillin_pct >= 2.00
        ) / NULLIF(COUNT(cb.batch_id), 0),
        2
    ) AS coa_pass_rate_pct
FROM suppliers s
JOIN harvests h
    ON s.supplier_id = h.supplier_id
JOIN curing_batches cb
    ON h.harvest_id = cb.harvest_id
GROUP BY
    s.supplier_id,
    s.supplier_name
ORDER BY coa_pass_rate_pct DESC;


-- 3. Identify suppliers requiring performance review
SELECT
    s.supplier_name,
    COUNT(po.po_id) AS purchase_order_count,
    ROUND(AVG(po.delivery_delay_days)::numeric, 2)
        AS average_delay_days,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE po.actual_delivery_date <= po.expected_delivery_date
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS on_time_delivery_rate_pct
FROM suppliers s
JOIN purchase_orders po
    ON s.supplier_id = po.supplier_id
GROUP BY s.supplier_id, s.supplier_name
HAVING
    AVG(po.delivery_delay_days) > 2
    OR 100.0 * COUNT(*) FILTER (
        WHERE po.actual_delivery_date <= po.expected_delivery_date
    ) / NULLIF(COUNT(*), 0) < 80
ORDER BY average_delay_days DESC;
