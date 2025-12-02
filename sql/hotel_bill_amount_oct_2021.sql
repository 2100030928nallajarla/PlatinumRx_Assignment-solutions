SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON i.item_id = bc.item_id
WHERE bc.bill_date >= '2021-10-01'
  AND bc.bill_date <  '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;
