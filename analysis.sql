WITH base_sales AS (
  SELECT
    STRFTIME('%Y-%m', o.OrderDate) AS period,
    p.ProductName,
    (od.UnitPrice * od.Quantity * (1 - od.Discount)) AS line_revenue
  FROM Orders o
  JOIN "Order Details" od ON o.OrderID = od.OrderID
  JOIN Products p ON od.ProductID = p.ProductID
),
revenue_dynamics_over_time AS (
  SELECT
    period,
    SUM(line_revenue) AS total_revenue
  FROM base_sales
  GROUP BY period
),
top_products_by_revenue AS (
  SELECT
    ProductName,
    SUM(line_revenue) AS total_revenue_by_product,
    ROW_NUMBER() OVER (ORDER BY SUM(line_revenue) DESC) AS "rank"
  FROM base_sales
  GROUP BY ProductName
),
top_products_by_month AS (
  SELECT
    period,
    ProductName,
    SUM(line_revenue) AS revenue,
    ROW_NUMBER() OVER (
      PARTITION BY period
      ORDER BY SUM(line_revenue) DESC
    ) AS "rank_in_month"
  FROM base_sales
  GROUP BY period, ProductName
),
revenue_dynamics_of_the_month_leader AS (
  SELECT
    period,
    ProductName,
    revenue,
    LAG(revenue) OVER (ORDER BY period) AS prev_revenue,
    revenue - LAG(revenue) OVER (ORDER BY period) AS delta_revenue,
    (revenue - LAG(revenue) OVER (ORDER BY period)) * 1.0
      / LAG(revenue) OVER (ORDER BY period) AS pct_change
  FROM top_products_by_month
  WHERE rank_in_month = 1
)

