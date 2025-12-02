SELECT bc.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM booking_commercials bc
JOIN bookings b  ON b.booking_id = bc.booking_id
JOIN items i     ON i.item_id = bc.item_id
WHERE b.booking_date >= '2021-11-01'
  AND b.booking_date <  '2021-12-01'
GROUP BY bc.booking_id;
