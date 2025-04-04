-- Aula 1:
-- SELECT FROM - Selecionando dados das tabelas

SELECT * FROM categories;

SELECT * FROM customers;

SELECT * FROM employees;

SELECT first_name FROM employees;

SELECT product_name FROM products;

SELECT product_id, product_name, unit_price FROM products;

SELECT 
    product_id, 
    product_name, 
    unit_price 
FROM products;






-- Aula 2:
-- Comentários no PostgreSQL

-- Este é um comentário de 1 linha
SELECT * FROM orders;

/*

Este

é um comentário

...

de múltiplas linhas

SELECT * FROM products

*/






-- Aula 3:
-- ALIAS: Renomeando colunas e tabelas com o AS

SELECT 
    p.product_id AS ID_Produto, 
    p.product_name AS Nome_Produto, 
    p.unit_price AS Preco_Unitario
FROM products AS p;






-- Aula 4:
-- LIMIT:Limitando a quantidade de linhas da query

-- 1. Selecione a tabela orders

-- 2. Selecione apenas as 100 primeiras linhas da tabela orders

SELECT * FROM orders LIMIT 10;






-- Aula 5: 
-- DISTINCT: Selecionar os valores distintos de uma coluna

-- 1. Selecione a tabela customers

-- 2. Faça uma consulta que retorne as profissões (contact_title) distintas da tabela customers

 SELECT DISTINCT
    contact_title
 FROM customers;
