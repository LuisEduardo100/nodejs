/**
* AS permitei renomear colunas de uma tabela e a própria tabela para o nome que desejar
* Após renomear você pode usar o nome definido para referenciar a tabela original
*/
SELECT 
  product_id AS id_produto,
  product_name AS nome_produto,
  quantity_per_unit AS unidade_quantidade
FROM products AS p;

/**
* LIMIT limita a quantidade de linhas retornadas pela tabela consultada
* Isso faz com que obtenha a resposta mais rápido
*/
SELECT * FROM orders LIMIT 10;

/**
* DISTINCT vai retornar apenas os valores DISTINTOS da coluna contact_title da tabela customers
* 
*/
SELECT DISTINCT contact_title FROM customers; 