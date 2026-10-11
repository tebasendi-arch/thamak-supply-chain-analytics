# Power BI Dashboard — Thamak Supply Chain Analytics

## Purpose

This dashboard is designed to analyse the performance of a simulated Ugandan vanilla export supply chain. It translates SQL analysis into actionable insights for procurement, inventory management, supplier quality and profitability.

## Planned Dashboard Pages

| Page | Focus | Key Measures |
|---|---|---|
| Executive Overview | Overall supply-chain performance | Demand, fulfilment rate, revenue, gross profit, gross margin |
| Supply & Inventory | Harvest seasonality, curing and stock | Harvested kg, finished kg, closing inventory, inventory cover |
| Supplier Performance | Supplier cost, delivery and quality | Purchase cost/kg, on-time delivery, CoA pass rate |

## Data Source

- Database: PostgreSQL
- Database name: `thamak_supply_chain`
- Data: Simulated supply-chain records
- Analysis period: 2025–2027

## Key Business Questions

1. How effectively is customer demand being fulfilled?
2. How do seasonal harvests and curing lead times affect inventory availability?
3. Which suppliers offer the strongest combination of cost, delivery reliability and quality?
4. Which customer segments and product grades generate the strongest gross margins?
5. How much inventory is available relative to expected demand?

## Design Principles

- Present key performance indicators clearly.
- Use consistent units and currency formatting.
- Distinguish actual model outputs from planning assumptions.
- Include filters for date, supplier, customer segment and product grade where appropriate.
- Avoid presenting simulated results as verified commercial performance.

## Dashboard Status

The dashboard layout is planned. Power BI development, validation and screenshots remain to be completed.

## Data Disclaimer

All suppliers, customers, transactions and financial figures are fictional and created for analytical demonstration. CoA thresholds are project assumptions and are not confirmed regulatory or customer specifications.