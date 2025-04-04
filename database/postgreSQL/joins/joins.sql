/*
* O JOIN no SQL é responsavél por trazer dados
* de uma outra tabela atráves de uma coluna em comum. 
* Abaixo, order_details tem product_id como chave estrangeira, logo
* podemos usar JOIN para criar uma nova tabela com os dados do produto
* em order_details.
*/

-- LEFT JOIN -> Considera todas as linhas da tabela da esquerda (order_details)
-- RIGHT JOIN -> Considera todas as linhas da tabela da direita (products)
-- FULL JOIN -> Considera todas as linhas de ambas as tabelas, se não existir relação, ele preencherá a linha como null  
-- INNER JOIN -> Considera a interseção entre as duas tabelas, é necessário existir o em ambas as tabelas

SELECT * 
FROM order_details
LEFT JOIN products 
ON order_details.product_id = products.product_id;

/*
* Selecionando colunas específicas para criar uma nova tabela com JOIN
*/
SELECT 
	p.product_id,
	p.product_name,
	p.category_id,
	p.unit_price,
	c.category_name
FROM products p -- = FROM products AS p
LEFT JOIN categories c -- = FROM categories AS c
ON c.category_id = p.category_id

/*
* Aqui estamos usando o JOIN para ter acesso a coluna product_name que só está
* disponível em products para poder atrelar aos dados de uma nova tabela agrupada com os
* dados da soma de preços de order_details
*/
SELECT 
	product_name,
	SUM(quantity) AS quantidade_total
FROM order_details o
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY product_name
ORDER BY quantidade_total DESC;

/*
* Aqui temos um exemplo de filtro antes do agrupamento, usando o WHERE, filtrando os dados
* que serão agrupados. O JOIN foi utilizado para ter acesso a coluna product_name de products
*/
SELECT 
	product_name,
	SUM(o.quantity) AS quantidade_total
FROM order_details o
LEFT JOIN products p ON o.product_id = p.product_id
WHERE p.unit_price >= 80
GROUP BY p.product_name
ORDER BY quantidade_total DESC;

/*
* Aqui temos um exemplo de filtro depois do agrupamento, usando o HAVING, filtrando os dados
* já agrupados. 
* 
*/
SELECT 
	product_name,
	SUM(o.quantity) AS quantidade_total
FROM order_details o
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(o.quantity) >= 1000
ORDER BY quantidade_total DESC;