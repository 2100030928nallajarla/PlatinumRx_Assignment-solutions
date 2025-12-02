WITH monthly_bills AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        b.user_id,
        bc.bill_id,
        SUM(i.item_rate * bc.item_quantity) AS bill_amount
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, b.user_id, bc.bill_id
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_amount DESC) AS bill_rank
    FROM monthly_bills
)
SELECT month, user_id, bill_id, bill_amount
FROM ranked
WHERE bill_rank = 2;
