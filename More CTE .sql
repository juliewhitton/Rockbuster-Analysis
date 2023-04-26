WITH avg_amt_cte (customer_id,
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
	LIMIT 5)
SELECT AVG (total_amount_paid)AS avg_amt_pd
FROM avg_amt_cte


