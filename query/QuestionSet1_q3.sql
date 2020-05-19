SELECT t.name,
       t.standard_quartile,
       COUNT(*)
  FROM (SELECT c.name,
               f.rental_duration,
               NTILE(4) OVER(ORDER BY f.rental_duration) AS standard_quartile
          FROM category AS c
               JOIN film_category AS fc
                ON c.category_id = fc.category_id 
                AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
               JOIN film AS f
                ON f.film_id = fc.film_id) AS t
 GROUP BY 1, 2
 ORDER BY 1, 2;