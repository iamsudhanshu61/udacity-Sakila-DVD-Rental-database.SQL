WITH t1 AS (SELECT (first_name || ' ' || last_name) AS name, 
                   c.customer_id, 
                   p.amount, 
                   p.payment_date
              FROM customer AS c
              JOIN payment AS p
              ON c.customer_id = p.customer_id),

     t2 AS (SELECT t1.customer_id
            FROM t1
            GROUP BY 1
            ORDER BY SUM(t1.amount) DESC
            LIMIT 10),


      t3 AS (SELECT t1.name,
                    DATE_PART('month', t1.payment_date) AS payment_month, 
                    DATE_PART('year', t1.payment_date) AS payment_year,
                    COUNT (*),
                    SUM(t1.amount),
                    SUM(t1.amount) AS total,
                    LEAD(SUM(t1.amount)) OVER(PARTITION BY t1.name ORDER BY DATE_PART('month', t1.payment_date)) AS lead,
                    LEAD(SUM(t1.amount)) OVER(PARTITION BY t1.name ORDER BY DATE_PART('month', t1.payment_date)) - SUM(t1.amount) AS lead_dif
             FROM t1
             JOIN t2
             ON t1.customer_id = t2.customer_id
             WHERE t1.payment_date BETWEEN '20070101' AND '20080101'
             GROUP BY 1, 2, 3
             ORDER BY 1, 3, 2)

SELECT t3.*,
       CASE WHEN t3.lead_dif = (SELECT MAX(t3.lead_dif) FROM t3 ORDER BY 1 DESC LIMIT 1) THEN 'This is the maximum difference'
            ELSE NULL
            END AS is_max					
FROM t3
ORDER BY 1;