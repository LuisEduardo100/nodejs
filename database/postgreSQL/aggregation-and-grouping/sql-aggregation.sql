/**
* COUNT conta a quantidade de valores NÃO NULOS
* Ele ignora valores nulos em uma coluna
*/
SELECT COUNT(*) FROM customers; -- valor total de linhas de uma tabela
SELECT COUNT(*) FROM products; 

/**
* SUM soma os valores das linhas de uma coluna
*/
SELECT 
  SUM(units_in_stock) 
FROM products;
SELECT 
  SUM(units_in_stock) AS total_estoque -- renomeia coluna como "total_estoque"
FROM products;

/**
* AVG vai retornar o valor medio da coluna selecionada
* MIN vai retornar o menor preço e MAX o maior preco da coluna seleciona
*/
SELECT * FROM products;
SELECT
  AVG(unit_price) AS preco_medio,
  MIN(unit_price) AS menor_preco,
  MAX(unit_price) AS maior_preco
FROM products;
