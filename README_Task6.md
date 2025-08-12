# Task 6: Sales Trend Analysis Using Aggregations

## Objective
Analyze monthly revenue and order volume using SQL aggregations in MySQL.

## Tools Used
- MySQL 8.0
- CSV dataset: `online_sales` (columns: `order_id`, `order_date`, `amount`, `product_id`)

## Steps Performed
1. **Data Import**:
   - Imported `online_sales.csv` into MySQL `orders` table.
2. **Data Cleaning**:
   - Checked for missing/invalid `order_date` and `amount`.
   - Removed duplicates using `order_id`.
3. **Monthly Aggregation**:
   - Grouped by `YEAR(order_date)` and `MONTH(order_date)`.
   - Calculated:
     - `SUM(amount)` as total revenue
     - `COUNT(DISTINCT order_id)` as total orders
     - Average Order Value (AOV)
4. **Trend Analysis**:
   - Calculated Month-over-Month % change using MySQL window functions.
5. **Export**:
   - Saved aggregated results into `monthly_sales.csv` for visualization.

## Insights (Sample — replace with yours)
- Peak revenue months: March & April
- Slowest month: February (seasonal dip)
- AOV steady across months (₹460–₹480 range)
- MoM growth positive in 8 out of last 12 months

## Deliverables
- `task6_sales_trend.sql` — SQL scripts used
- `monthly_sales.csv` — Aggregated monthly results
- Dashboard screenshots (Power BI / Tableau / Excel)
