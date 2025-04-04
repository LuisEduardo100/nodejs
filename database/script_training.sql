SELECT * FROM customers;

SELECT
	customers,
	country,
	COUNT(*)
FROM customers
GROUP BY customers
ORDER BY COUNT(*);
