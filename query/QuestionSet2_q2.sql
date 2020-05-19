SELECT DATE_TRUNC('month', p.payment_date) pay_mon, c.first_name || ' ' || c.last_name AS fullname, COUNT(p.amount) AS pay_countpermon, SUM(p.amount) AS pay_amount
FROM customer c
JOIN payment p
ON p.customer_id = c.customer_id
WHERE c.first_name || ' ' || c.last_name IN
(SELECT t1.full_name
FROM
(SELECT c.first_name || ' ' || c.last_name AS full_name, SUM(p.amount) as amount_total
FROM customer c
JOIN payment p
ON p.customer_id = c.customer_id
GROUP BY 1	
ORDER BY 2 DESC
LIMIT 10) t1) AND (p.payment_date BETWEEN '2007-01-01' AND '2008-01-01')
GROUP BY 2, 1
ORDER BY 2, 1, 3;