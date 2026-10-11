# Data Model — Thamak Supply Chain Analytics

## 1. Overview

The project uses a relational PostgreSQL database to represent the main stages of a simulated vanilla export supply chain.

The model connects suppliers, harvests, curing batches, procurement, inventory, customer orders and shipments. It supports analysis of supplier performance, seasonal supply, product quality, fulfilment and profitability.

The database contains 11 tables.

## 2. Database Tables

| Table | Purpose |
|---|---|
| suppliers | Supplier details, regions, lead times and performance attributes |
| products | Product names, grades, units and base selling prices |
| customers | Customer details, countries and customer segments |
| harvests | Harvest dates, seasons, suppliers and harvested quantities |
| curing_batches | Curing duration, expected market-ready dates, finished quantities and quality measurements |
| purchase_orders | Procurement quantities, prices, costs and delivery performance |
| customer_orders | Customer demand, requested delivery dates, quantities and selling prices |
| shipments | Shipment quantities, logistics costs and delivery timing |
| fulfilment | Ordered, fulfilled and unfulfilled quantities by customer order |
| inventory_transactions | Inventory receipts, shipments and running stock balances |
| date_dimension | Calendar attributes used for time-based analysis |

## 3. Main Relationships

The principal relationships are:

- One supplier can provide multiple harvests.
- One harvest can have multiple purchase orders.
- One harvest can be associated with a curing batch.
- One customer can place multiple customer orders.
- One customer order can have multiple shipments.
- Shipments reference curing batches.
- Inventory transactions record movements associated with curing batches.
- Customer orders reference products.
- The date dimension supports calendar-based analysis.

## 4. Supply Chain Data Flow

The model represents the following operational flow:

**Supplier → Harvest → Procurement → Curing → Market-ready Inventory → Customer Order → Shipment → Fulfilment**

### Supplier and procurement

Supplier records connect to harvests and purchase orders. This allows analysis of purchase prices, quantities, delivery delays and supplier reliability.

### Harvest and curing

Harvest records capture the quantity and season of harvested vanilla. Curing batches track processing duration, finished quantity and simulated quality measurements.

### Inventory

Inventory transactions record quantities entering inventory when curing is completed and quantities leaving inventory when customer shipments occur.

### Customer orders and shipments

Customer orders represent demand. Shipments record quantities dispatched, logistics costs and arrival dates. The fulfilment table summarises ordered, fulfilled and unfulfilled quantities.

## 5. Analytical Uses

The data model supports:

- Supplier cost and delivery scorecards.
- Seasonal harvest and curing analysis.
- Finished-product yield analysis.
- Inventory reconciliation and stock-cover calculations.
- Customer demand and fulfilment analysis.
- Shipment and logistics cost analysis.
- Profitability by customer segment and product grade.
- Simulated Certificate of Analysis (CoA) analysis.

## 6. Data Integrity

Data quality checks are used to identify:

- Duplicate identifiers.
- Missing or unmatched relationships.
- Invalid or negative quantities.
- Purchase orders with inconsistent dates.
- Differences between harvested and procured quantities.
- Inventory reconciliation discrepancies.

Procurement cost must be linked to shipments through the harvest and curing-batch relationships. Because a harvest can have multiple purchase orders, procurement costs must be aggregated at harvest level before being allocated to shipped quantities. This avoids double-counting costs.

## 7. Limitations

The database represents a simulated supply chain. Its structure demonstrates relational modelling and analytical methods, but its results are not evidence of actual commercial performance.

All business names, suppliers, transactions and financial figures are fictional and created for analytical demonstration.