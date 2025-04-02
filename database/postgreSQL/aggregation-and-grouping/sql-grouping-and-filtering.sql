/**
* WHERE é usado para filtrar dados antes do agrupamento, para filtrar dados
* depois de um agrupamento, devemos utilizar o HAVING.
* Com isso agrupamos apenas os dados que nos interessam
*/
SELECT * FROM customers;

SELECT
	country,
	COUNT(customers)
FROM customers
WHERE contact_title = 'Owner'
GROUP BY country

/**
* HAVING é usado para filtrar dados de um agrupamento, deve ser usado DEPOIS do GROUP BY
*/
SELECT * FROM customers;

SELECT 
	country,
	COUNT(*) 
FROM customers
GROUP BY country
HAVING COUNT(*) > 10
