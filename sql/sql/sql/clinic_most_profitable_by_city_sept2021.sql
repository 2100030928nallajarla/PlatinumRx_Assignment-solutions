WITH profits AS (
    SELECT
        c.city,
        cs.cid,
        DATE_FORMAT(cs.datetime, '%Y-%m') AS month,
        SUM(cs.amount) -
          COALESCE((SELECT SUM(e.amount)
                    FROM expenses e
                    WHERE e.cid = cs.cid
                    AND DATE_FORMAT(e.datetime, '%Y-%m') = DATE_FORMAT(cs.datetime, '%Y-%m')
                   ), 0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    WHERE DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'
    GROUP BY city, cs.cid, month
),
ranked AS (
  SELECT *,
         RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
  FROM profits
)
SELECT city, cid, month, profit
FROM ranked WHERE rnk = 1;
