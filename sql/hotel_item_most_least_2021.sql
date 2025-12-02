WITH monthly_item_qty AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, bc.item_id
),
ranked AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS rnk_max,
        RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS rnk_min
    FROM monthly_item_qty
)
SELECT month, item_id, total_qty,
       CASE 
         WHEN rnk_max = 1 THEN 'Most Ordered'
         WHEN rnk_min = 1 THEN 'Least Ordered'
       END AS category
FROM ranked
WHERE rnk_max = 1 OR rnk_min = 1;
