# Methodology — Thamak Supply Chain Analytics

## 1. Purpose

This document describes the approach used to generate, validate and analyse the simulated data for the Thamak Supply Chain Analytics project.

The project demonstrates how SQL, Python and Power BI can be applied to a seasonal agricultural supply chain.

**Data disclaimer:** All suppliers, customers, transactions and financial figures are fictional and created for analytical demonstration.

## 2. Analytical Approach

The project follows these stages:

1. Define the business questions and performance indicators.
2. Generate a simulated relational dataset.
3. Load the data into PostgreSQL.
4. Validate data quality and relationships.
5. Analyse supplier, procurement and product quality performance.
6. Analyse seasonal supply, inventory and customer fulfilment.
7. Estimate shipment-level revenue, landed cost and profitability.
8. Present the findings and recommendations through a Power BI dashboard.

## 3. Data Generation

The dataset models the main stages of a vanilla export supply chain:

- Supplier procurement
- Seasonal harvests
- Vanilla curing
- Purchase orders
- Customer orders
- Inventory movements
- Shipments and fulfilment

The simulation includes 10 suppliers, 3 products, 30 customers, 40 harvests, 40 curing batches, 120 purchase orders, 31 customer orders and 43 shipments.

These figures describe the current simulated dataset and may change if the model is revised.

## 4. Seasonal Supply Assumptions

The model represents two annual harvest periods:

- **Main harvest:** May–June
- **Secondary harvest:** November–December

Curing is simulated over approximately 60–90 days. Harvested vanilla is therefore not treated as immediately available for customer shipment.

Customer demand continues throughout the year independently of harvest timing.

## 5. Database and Data Processing

PostgreSQL is used to store the simulated data in relational tables.

SQL joins connect supplier, harvest, procurement, curing, inventory, customer-order and shipment records. Aggregations are applied at appropriate levels to calculate performance indicators without unintentionally multiplying quantities or costs.

Python supports dataset generation, validation and exploratory analysis.

## 6. Data Quality and Reconciliation

Validation checks cover:

- Duplicate identifiers.
- Missing or unmatched records.
- Invalid or negative quantities.
- Purchase-order date consistency.
- Agreement between harvested quantities and procurement quantities.
- Inventory receipts and dispatches.
- Reconciliation of calculated inventory balances.

In the current model, total purchased quantity reconciles to total harvested quantity at 2,068.3 kg.

Finished cured quantity is approximately 1,860.4 kg, while shipped quantity is 985.7 kg. The reconciled closing inventory is 874.7 kg.

The inventory reconciliation is:

**1,860.4 kg received − 985.7 kg shipped = 874.7 kg closing inventory.**

## 7. Supplier and Quality Analysis

Supplier analysis compares purchase prices, delivery delays and on-time delivery performance.

Simulated Certificate of Analysis (CoA) results are linked to suppliers through the harvest and curing-batch records.

The quality analysis evaluates moisture against a project specification of 30–35% and vanillin against a provisional threshold of at least 2.00%.

These are project assumptions, not claims about regulatory or customer requirements.

A batch passes only when it meets all specifications included in the model.

## 8. Inventory Analysis

Inventory movements are recorded when curing is completed and when customer shipments leave inventory.

The analysis calculates:

- Monthly inventory receipts.
- Monthly shipped quantities.
- Closing inventory balances.
- Inventory cover based on average demand over the preceding three calendar months.
- Inventory ageing for remaining batch balances.

Inventory cover is interpreted alongside curing lead times and seasonal supply. A negative monthly supply-demand balance does not automatically indicate a stockout because existing inventory may satisfy demand.

## 9. Demand and Fulfilment Analysis

Customer orders are compared with recorded fulfilment quantities.

The analysis measures total demand, fulfilled quantities, unfulfilled quantities and fulfilment rates. Results are also segmented by customer type and country.

The current model records 1,290.9 kg of demand, 985.7 kg fulfilled and 305.2 kg unfulfilled, equivalent to a fulfilment rate of 76.36%.

The unfulfilled quantity is concentrated in the opening period before the first simulated curing batches become market-ready. This is retained as a deliberate scenario rather than offset by assumed opening inventory.

## 10. Profitability Method

Revenue is calculated from shipped quantities and the associated customer-order selling price.

Procurement cost is aggregated at harvest level before being allocated to shipments. This is important because each harvest has multiple purchase orders.

Estimated landed cost comprises allocated procurement cost plus recorded logistics costs.

The current model produces the following results:

- Revenue: £103,750.79
- Estimated landed cost: £66,763.92
- Gross profit: £36,986.86
- Gross margin: 35.65%

These figures are simulated analytical results, not actual company financial performance.

## 11. Limitations

- The dataset is simulated and does not represent actual transactions.
- Findings depend on the assumptions built into the data generator.
- The CoA thresholds are provisional project assumptions.
- Profitability depends on the model's cost allocation and shipment assumptions.
- The results demonstrate analytical methods rather than validated forecasts of real business performance.

## 12. Reproducibility

The GitHub repository is intended to contain the data-generation and validation scripts, SQL analysis, data dictionary, data model, business requirements and Power BI documentation.

These materials allow reviewers to understand how the dataset is structured, how calculations are derived and how the business findings are produced.