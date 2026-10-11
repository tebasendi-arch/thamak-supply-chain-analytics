# Thamak Naturals | Supply Chain Analytics

**A data analytics case study using PostgreSQL, Python and Power BI**

## Project Overview

This project explores how a vanilla sourcing and export business in Uganda can use data analytics to improve procurement planning, supplier performance, inventory management, customer fulfilment and profitability.

Vanilla supply is seasonal, with a main harvest in May–June and a smaller secondary harvest in November–December. After harvesting, vanilla requires approximately 60–90 days of curing before it becomes market-ready. Customer demand, however, continues throughout the year.

The project models this supply chain to investigate how seasonal supply, curing lead times, supplier reliability and customer demand interact, and how data-driven decisions can improve operational performance.

> **Data disclaimer:** This project uses simulated data based on a realistic vanilla export supply-chain model. Business names, suppliers, transactions and financial figures are fictional and created for analytical demonstration.

## Business Problem

How can a vanilla exporter balance seasonal procurement and curing capacity with year-round customer demand while controlling costs and maintaining product quality?

The analysis focuses on five business questions:

1. **Supplier performance:** Which suppliers offer the best balance of purchase price, delivery reliability and product quality?
2. **Seasonal supply planning:** How do harvest and curing cycles affect the availability of market-ready vanilla?
3. **Inventory management:** How much stock is available, how quickly is it consumed, and how much inventory cover remains?
4. **Customer fulfilment:** Which customer segments account for the most demand and unmet orders?
5. **Profitability:** What are the revenue, landed costs and gross margins across customer segments and product grades?

## Tools and Technologies

- **PostgreSQL / SQL** — relational data modelling, data quality checks, joins, aggregations and business analysis.
- **Python** — simulated dataset generation, validation and exploratory analysis.
- **Power BI** — interactive dashboard development and business performance reporting.
- **Excel / CSV** — data inspection, review and reconciliation.

## Data Model

The project uses a relational model comprising 11 tables:

- Suppliers
- Products
- Customers
- Harvests
- Curing batches
- Purchase orders
- Customer orders
- Shipments
- Fulfilment
- Inventory transactions
- Date dimension

The model connects supplier procurement and harvest records to curing batches, inventory movements, customer orders and shipments. This supports traceable analysis across the supply chain.

## Key Findings

The following results are from the current simulated dataset and analytical model.

| KPI | Result |
|---|---:|
| Total customer demand | 1,290.9 kg |
| Fulfilled quantity | 985.7 kg |
| Unfulfilled quantity | 305.2 kg |
| Fulfilment rate | 76.36% |
| Shipped sales revenue | £103,750.79 |
| Estimated landed cost | £66,763.92 |
| Gross profit | £36,986.86 |
| Gross margin | 35.65% |
| Closing inventory | 874.7 kg |
| Overall CoA specification pass rate | 60% |

### 1. Customer fulfilment

The model records a fulfilment rate of 76.36%, with 305.2 kg of unmet demand. This unmet demand is concentrated in the opening period, before the first simulated curing batches become market-ready.

### 2. Seasonal inventory

Inventory increases following the main harvest and curing cycle, then declines as customer orders are shipped. Closing inventory reaches 904.8 kg in September 2026 before falling to 589.2 kg in December 2026.

This highlights the importance of planning procurement and curing around seasonal supply while maintaining sufficient stock for year-round demand.

### 3. Supplier performance and quality

Supplier performance varies across purchase cost, delivery reliability and quality indicators. The Certificate of Analysis (CoA) analysis evaluates simulated batch moisture and vanillin results against the project's defined specifications.

The current CoA pass rate is 60%. These thresholds are project assumptions for analytical demonstration, not a claim of regulatory or customer certification requirements.

### 4. Profitability

The model estimates £103,750.79 in revenue and £36,986.86 in gross profit on shipped orders, giving a gross margin of 35.65%. Landed cost includes allocated procurement cost and recorded logistics costs.

These figures are simulated results, not actual Thamak Naturals financial performance.

## Business Recommendations

Based on the current analysis, the model supports the following recommendations:

- **Plan procurement around seasonal supply:** forecast demand and schedule supplier purchases early enough to allow for curing lead times.
- **Use a balanced supplier scorecard:** evaluate price alongside on-time delivery, lead time, quality results and CoA compliance.
- **Monitor inventory cover:** track stock against recent demand and establish replenishment thresholds that account for curing lead times.
- **Prioritise fulfilment risk:** investigate unmet demand and identify customer segments that contribute most to outstanding quantities.
- **Review margins by segment and grade:** use landed cost and gross margin to support pricing, customer mix and product allocation decisions.
- **Strengthen quality controls:** investigate moisture and vanillin specification failures before accepting or releasing batches.

## Project Structure

```text
thamak-supply-chain-analytics/
├── README.md
├── data/
│   ├── raw/
│   └── processed/
├── sql/
├── python/
├── powerbi/
├── documentation/
└── portfolio/
```

## Project Status

**In progress.**

The relational database, simulated data, initial data-quality checks, supplier and CoA analysis, inventory analysis, demand and fulfilment analysis, and initial profitability analysis have been developed.

Remaining work includes finalising the inventory-ageing analysis, consolidating the final SQL scripts and documentation, and completing the Power BI dashboard and portfolio screenshots.

## Limitations

- The dataset is simulated and does not represent actual company transactions.
- The CoA thresholds are project-defined assumptions and should not be interpreted as regulatory or customer requirements.
- Financial results depend on the model's pricing, cost-allocation and shipment assumptions.
- Findings demonstrate analytical methods and should not be treated as forecasts of real business performance.

## Author

**Supply Chain Analytics | Business Intelligence | Operations Analytics**

This project demonstrates the application of data modelling, SQL, Python and business intelligence to a realistic supply-chain planning problem.