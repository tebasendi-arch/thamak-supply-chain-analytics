
-- Project: Thamak Supply Chain Analytics
-- Purpose: Validate key data quality and reconciliation rules.
-- Data: Simulated data created for analytical demonstration.

-- 1. Check supplier records
SELECT
    COUNT(*) AS supplier_count,
    COUNT(DISTINCT supplier_id) AS unique_supplier_ids
FROM suppliers;

-- 2. Check purchase-order identifiers
SELECT
    COUNT(*) AS purchase_order_count,
    COUNT(DISTINCT po_id) AS unique_purchase_order_ids
FROM purchase_orders;

-- 3. Check for negative procurement quantities
SELECT *
FROM purchase_orders
WHERE quantity_kg < 0;

-- 4. Check for purchase orders delivered before they were ordered
SELECT *
FROM purchase_orders
WHERE actual_delivery_date < order_date;

-- 5. Compare total harvested and procured quantities
SELECT
    (SELECT ROUND(SUM(quantity_harvested_kg)::numeric, 2)
     FROM harvests) AS total_harvested_kg,
    (SELECT ROUND(SUM(quantity_kg)::numeric, 2)
     FROM purchase_orders) AS total_purchased_kg;

-- 6. Reconcile inventory receipts and shipments
SELECT
    ROUND(SUM(quantity_in_kg)::numeric, 2) AS total_received_kg,
    ROUND(SUM(quantity_out_kg)::numeric, 2) AS total_shipped_kg,
    ROUND(
        (SUM(quantity_in_kg) - SUM(quantity_out_kg))::numeric,
        2
    ) AS calculated_closing_inventory_kg
FROM inventory_transactions;

-- 7. Check for negative inventory transaction quantities
SELECT *
FROM inventory_transactions
WHERE quantity_in_kg < 0
   OR quantity_out_kg < 0;
