WITH clinic_rev AS (
    SELECT c.cid,
           c.city,
           SUM(cs.amount) AS revenue
    FROM clinic_sales cs
    JOIN clinics c ON c.cid = cs.cid
    WHERE YEAR(cs.datetime) = 2021
      AND MONTH(cs.datetime) = 9
    GROUP BY c.cid, c.city
),
clinic_exp AS (
    SELECT e.cid,
           SUM(e.amount) AS expense
    FROM expenses e
    WHERE YEAR(e.datetime) = 2021
      AND MONTH(e.datetime) = 9
    GROUP BY e.cid
),
profit AS (
    SELECT r.cid,
           r.city,
           COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
    FROM clinic_rev r
    LEFT JOIN clinic_exp e ON e.cid = r.cid
)
SELECT city, cid, profit
FROM (
    SELECT city,
           cid,
           profit,
           RANK() OVER (
               PARTITION BY city
               ORDER BY profit DESC
           ) AS rnk
    FROM profit
) t
WHERE rnk = 1;
