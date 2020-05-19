SELECT f.title AS film_title,
       c.name AS category_name,
       COUNT(r.rental_id) AS rental_count
FROM category AS c

       JOIN film_category AS fc
        ON c.category_id = fc.category_id
        AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
        JOIN film AS f
        ON f.film_id = fc.film_id
		JOIN inventory AS i
        ON f.film_id = i.film_id
        JOIN rental AS r
        ON i.inventory_id = r.inventory_id
		
 GROUP BY 1, 2
 ORDER BY 2, 1;