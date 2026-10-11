# Business Requirements — Thamak Supply Chain Analytics

## 1. Business Background

This project uses a simulated Ugandan vanilla sourcing and export business to demonstrate how data analytics can improve supply chain planning and operational performance.

Vanilla supply is seasonal, while customer demand continues throughout the year. Harvested vanilla also requires approximately 60–90 days of curing before it becomes market-ready.

**Data disclaimer:** All suppliers, customers, transactions and financial figures are simulated and created for analytical demonstration.

## 2. Business Problem

The business needs a consolidated view of supply chain performance to understand whether seasonal supply can support customer demand while maintaining product quality, controlling landed costs and protecting profitability.

## 3. Project Objectives

The project aims to:

1. Evaluate supplier costs, delivery reliability and quality.
2. Analyse harvest volumes, curing duration and finished-product yield.
3. Monitor inventory movements, closing balances and inventory cover.
4. Measure customer demand, fulfilment and unmet orders.
5. Calculate revenue, landed costs, gross profit and gross margin.
6. Assess batch quality against defined moisture and vanillin specifications.

## 4. Key Business Questions

### Supplier Performance
- Which suppliers offer competitive purchase prices?
- Which suppliers deliver reliably?
- Which suppliers achieve the strongest quality results?

### Seasonal Supply Planning
- How much vanilla is harvested during each season?
- How much finished product becomes available after curing?
- How does curing affect the timing of supply?

### Inventory Management
- How does inventory change over time?
- How much stock remains available?
- How many months of demand can current inventory cover?
- Which batches have remained in stock the longest?

### Customer Fulfilment
- What percentage of ordered quantities is fulfilled?
- How much demand remains unfulfilled?
- Which customer segments contribute most to unmet demand?

### Profitability
- What revenue is generated from shipped orders?
- What are the procurement and logistics costs?
- How do gross profit and margins vary by customer segment and product grade?

### Product Quality
- What percentage of batches passes the defined specifications?
- Which quality parameters account for failures?
- How do quality results vary between suppliers?

## 5. Intended Users

| Stakeholder | Information Required |
|---|---|
| Business Management | Overall performance, profitability and operational risks |
| Procurement | Supplier costs, delivery reliability and sourcing decisions |
| Operations | Harvest, curing, inventory and stock availability |
| Quality Assurance | Batch test results and specification compliance |
| Sales and Commercial | Customer demand, fulfilment and margins |

## 6. Key Performance Indicators

| KPI | Definition |
|---|---|
| On-time Delivery Rate | Percentage of purchase orders delivered on or before the expected date |
| Average Purchase Cost per kg | Procurement expenditure divided by purchased quantity |
| Curing Yield | Finished cured quantity divided by harvested input quantity |
| Average Curing Duration | Average number of days required for curing |
| Fulfilment Rate | Fulfilled quantity divided by total ordered quantity |
| Unfulfilled Quantity | Ordered quantity minus fulfilled quantity |
| Closing Inventory | Stock remaining after recorded inventory movements |
| Inventory Cover | Closing inventory divided by average monthly demand over the preceding three calendar months |
| CoA Pass Rate | Percentage of tested batches meeting all defined project specifications |
| Gross Profit | Revenue from shipped quantities minus estimated landed cost |
| Gross Margin | Gross profit divided by revenue, expressed as a percentage |

## 7. Project Scope

### Included
- Supplier and procurement analysis.
- Harvest and curing analysis.
- Inventory movement and inventory-cover analysis.
- Customer demand and fulfilment analysis.
- Shipment and logistics cost analysis.
- Profitability analysis.
- Simulated Certificate of Analysis (CoA) results.
- SQL, Python and Power BI analytics.

### Excluded
- Live supplier or customer integrations.
- Actual commercial transactions.
- Independent verification of product quality.
- Automated procurement or replenishment.
- Forecasts validated against real historical business data.

## 8. Assumptions and Constraints

- The main harvest occurs in May–June.
- The smaller secondary harvest occurs in November–December.
- Curing is simulated over 60–90 days.
- Customer demand continues throughout the year.
- The initial supply cycle begins with zero available cured inventory, creating an opening demand backlog.
- The moisture specification is 30–35%.
- The vanillin threshold of at least 2.00% is a provisional project assumption, not a confirmed regulatory or customer requirement.
- Financial results depend on simulated prices, costs and transactions.

## 9. Expected Deliverables

1. PostgreSQL relational database.
2. SQL scripts for data quality and business analysis.
3. Python scripts for dataset generation and validation.
4. Data dictionary and data model documentation.
5. Methodology documentation.
6. Interactive Power BI dashboard.
7. Key findings and business recommendations.
8. GitHub portfolio case study.

## 10. Definition of Success

The project is complete when the analytical results are reconciled against the underlying data, the SQL and Python scripts are documented, the Power BI dashboard communicates key performance indicators clearly, and the GitHub repository presents a professional and reproducible case study.

