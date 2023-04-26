--top 10 cities within top 10 countries for customer numbers

SELECT D. country,
	   C. city,
	   COUNT (customer_id) AS number_of_customers
FROM customer A
INNER JOIN address B ON A. address_id = B. address_id
INNER JOIN city C ON B. city_id = C. city_id
INNER JOIN country D ON C. country_id = D. country_id
WHERE country IN ('India', 'China', 'United States', 'Japan',
				 'Mexico', 'Brazil', 'Russian Federation',
				 'Philippines', 'Turkey', 'Indonesia')
GROUP BY country, city
ORDER BY number_of_customers DESC
LIMIT 10