--top_customer_count_CTE
WITH top_customer_count_cte (customer_id,
				first_name,
				last_name,
				city,
				country,
				total_amount_paid) 
AS
	(SELECT A. customer_id,
		    A. first_name,
	   	    A. last_name,
	        C. city,
	   	D. country,
	   	SUM (E. amount) AS total_amount_paid
	FROM customer A
	INNER JOIN address B ON A. address_id = B. address_id
	INNER JOIN city C ON B. city_id = C. city_id
	INNER JOIN country D ON C. country_id = D. country_id
	INNER JOIN payment E ON A. customer_id = E. customer_id
	WHERE city IN ('Aurora', 'Acua', 'Citrus Heights',
			  		'Iwaki', 'Ambattur', 'Shanwei', 'So Leopoldo',
			  		'Teboksary', 'Tianjin', 'Cianjur')
	GROUP BY A. customer_id,
		 	 A. first_name,
		 	 A. last_name,
		 	 C. city,
		 	 D. country
	ORDER BY total_amount_paid DESC
	LIMIT 5),

--all_customer_count_CTE
all_customer_count_cte (country,
			all_customer_count,
			top_customer_count)
AS
	(SELECT D. country,
		    COUNT (DISTINCT A. customer_id) AS all_customer_count,
		    COUNT (DISTINCT D. country) AS top_customer_count
	FROM customer A
	INNER JOIN address B ON A. address_id = B. address_id
	INNER JOIN city C ON B. city_id = C. city_id
	INNER JOIN country D ON C. country_id = D. country_id
	GROUP BY D. country)

--Main query
SELECT D. country,
	   COUNT (DISTINCT A. customer_id)
	   AS all_customer_count,
	   COUNT (DISTINCT top_customer_count_cte.customer_id)
	   AS top_customer_count
FROM country D
INNER JOIN city C ON D.country_id = C.country_id
INNER JOIN address B ON C.city_id = B.city_id
INNER JOIN customer A ON B.address_id = A.address_id
INNER JOIN top_customer_count_cte ON
		   D. country = top_customer_count_cte.country 
GROUP BY D. country
ORDER BY top_customer_count DESC
LIMIT 5
					   




