# Data Dictionary — Thamak Supply Chain Analytics

## 1. Overview

This document defines the tables, columns and business meanings used in the Thamak Supply Chain Analytics project.

The database contains simulated data representing a vanilla sourcing and export business. All suppliers, customers, transactions and financial figures are fictional.

## 2. Suppliers

**Table:** `suppliers`

| Column | Description |
|---|---|
| supplier_id | Unique identifier for each supplier |
| supplier_name | Supplier's simulated business name |
| region | Supplier's operating region |
| supplier_type | Supplier category |
| avg_lead_time_days | Average expected procurement lead time in days |
| on_time_rate | Simulated supplier on-time delivery performance |
| quality_rating | Simulated supplier quality rating |
| base_purchase_price_per_kg | Base purchase price per kilogram |

## 3. Products

**Table:** `products`

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| product_name | Product name |
| grade | Product quality or commercial grade |
| unit | Unit of measurement |
| base_selling_price_per_kg | Base selling price per kilogram |

## 4. Customers

**Table:** `customers`

| Column | Description |
|---|---|
| customer_id | Unique customer identifier |
| customer_name | Simulated customer name |
| country | Customer's country |
| customer_type | Customer segment |
| typical_order_kg | Typical customer order quantity in kilograms |

## 5. Harvests

**Table:** `harvests`

| Column | Description |
|---|---|
| harvest_id | Unique harvest identifier |
| supplier_id | Supplier associated with the harvest |
| harvest_date | Date of harvest |
| season | Main or secondary harvest season |
| quantity_harvested_kg | Quantity harvested in kilograms |

## 6. Curing Batches

**Table:** `curing_batches`

| Column | Description |
|---|---|
| batch_id | Unique curing batch identifier |
| harvest_id | Harvest associated with the batch |
| curing_start_date | Date curing begins |
| expected_market_date | Expected date the batch becomes market-ready |
| curing_days | Curing duration in days |
| input_kg | Quantity entering curing |
| finished_kg | Quantity after curing |
| quality_grade | Simulated finished-product quality grade |
| moisture_pct | Measured or simulated moisture percentage |
| vanillin_pct | Measured or simulated vanillin percentage |

## 7. Purchase Orders

**Table:** `purchase_orders`

| Column | Description |
|---|---|
| po_id | Unique purchase order identifier |
| harvest_id | Harvest associated with the procurement order |
| supplier_id | Supplier receiving the purchase order |
| order_date | Purchase order date |
| expected_delivery_date | Expected delivery date |
| actual_delivery_date | Actual delivery date |
| quantity_kg | Quantity purchased in kilograms |
| purchase_price_per_kg | Purchase price per kilogram |
| purchase_cost | Total cost recorded for the purchase order |
| delivery_delay_days | Difference between actual and expected delivery dates |
| procurement_tranche | Procurement stage or tranche associated with the order |

## 8. Customer Orders

**Table:** `customer_orders`

| Column | Description |
|---|---|
| order_id | Unique customer order identifier |
| customer_id | Customer placing the order |
| order_date | Date the order was placed |
| required_delivery_date | Customer's required delivery date |
| product_id | Product ordered |
| quantity_kg | Quantity ordered in kilograms |
| selling_price_per_kg | Selling price per kilogram |
| order_value | Total value of the customer order |

## 9. Shipments

**Table:** `shipments`

| Column | Description |
|---|---|
| shipment_id | Unique shipment identifier |
| order_id | Customer order associated with the shipment |
| batch_id | Curing batch associated with the shipment |
| shipment_date | Date the shipment was dispatched |
| expected_arrival_date | Expected arrival date |
| actual_arrival_date | Actual arrival date |
| shipment_delay_days | Difference between actual and expected arrival dates |
| quantity_kg | Quantity shipped in kilograms |
| freight_cost | Recorded freight cost |
| other_costs | Other recorded shipment costs |
| logistics_cost | Total recorded logistics cost |

## 10. Fulfilment

**Table:** `fulfilment`

| Column | Description |
|---|---|
| order_id | Customer order identifier |
| ordered_kg | Total quantity ordered |
| fulfilled_kg | Quantity fulfilled |
| unfulfilled_kg | Quantity not fulfilled |
| fulfilment_status | Order fulfilment classification |

## 11. Inventory Transactions

**Table:** `inventory_transactions`

| Column | Description |
|---|---|
| transaction_id | Unique inventory transaction identifier |
| transaction_date | Date of the inventory movement |
| batch_id | Curing batch associated with the movement |
| transaction_type | Type of inventory movement |
| quantity_in_kg | Quantity entering inventory |
| quantity_out_kg | Quantity leaving inventory |
| balance_kg | Recorded inventory balance |

## 12. Date Dimension

**Table:** `date_dimension`

| Column | Description |
|---|---|
| date | Calendar date |
| year | Calendar year |
| month | Numeric calendar month |
| monthname | Calendar month name |
| quarter | Calendar quarter |
| yearmonth | Year and month reporting label |

## 13. Important Analytical Definitions

### Curing yield

Finished quantity divided by curing input quantity, expressed as a percentage.

### Fulfilment rate

Total fulfilled quantity divided by total ordered quantity, expressed as a percentage.

### Inventory cover

Closing inventory divided by average monthly demand over the preceding three calendar months.

### CoA pass rate

Percentage of tested curing batches meeting all defined project specifications.

### Gross profit

Revenue from shipped quantities minus estimated landed cost.

### Gross margin

Gross profit divided by revenue, expressed as a percentage.

## 14. Data Limitations

The dataset is simulated. The definitions describe the analytical model and should not be interpreted as verified company records or regulatory standards.

The vanillin specification is a provisional project assumption. Actual customer or regulatory requirements would need independent confirmation.