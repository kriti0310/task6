-- TASK 6: Sales Trend Analysis Using Aggregations (MySQL)

-- 1. Check table structure
DESC orders;

-- 2. Quick data quality checks
SELECT COUNT(*) AS total_rows FROM orders;
SELECT COUNT(*) AS missing_dates FROM orders WHERE order_date IS NULL;
SELECT COUNT(*) AS missing_amounts FROM orders WHERE amount IS NULL OR amount = 0;
SELECT order_id, COUNT(*) AS duplicates
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 3. Monthly revenue & order count (last 12 months)
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS year_month,
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(amount), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(amount) / NULLIF(COUNT(DISTINCT order_id),0), 2) AS avg_order_value
FROM orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 11 MONTH)
GROUP BY year_month, year, month
ORDER BY year, month;

-- 4. Month-over-Month (MoM) percentage change
WITH monthly AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS year_month,
        STR_TO_DATE(DATE_FORMAT(order_date, '%Y-%m-01'), '%Y-%m-%d') AS month_start,
        ROUND(SUM(amount), 2) AS total_revenue,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY year_month, month_start
)
SELECT
    year_month,
    total_revenue,
    order_count,
    LAG(total_revenue) OVER (ORDER BY month_start) AS prev_revenue,
    ROUND((total_revenue - LAG(total_revenue) OVER (ORDER BY month_start)) / 
          NULLIF(LAG(total_revenue) OVER (ORDER BY month_start),0) * 100, 2) AS mom_pct_change
FROM monthly
ORDER BY month_start;
