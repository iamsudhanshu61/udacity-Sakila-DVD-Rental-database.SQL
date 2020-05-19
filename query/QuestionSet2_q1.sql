SELECT DATE_PART('month', r1.rental_date) AS rental_month, 
       DATE_PART('year', r1.rental_date) AS rental_year,
       s1.store_id AS store_ID,
       COUNT(*) AS Count_rentals
  FROM store AS s1
       JOIN staff AS s2
        ON s1.store_id = s2.store_id
		JOIN rental r1
        ON s2.staff_id = r1.staff_id
 GROUP BY 1, 2, 3
 ORDER BY 1,2,4 DESC;