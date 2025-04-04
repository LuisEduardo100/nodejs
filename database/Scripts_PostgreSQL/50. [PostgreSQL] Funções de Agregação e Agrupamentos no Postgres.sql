-- MÓDULO POSTGRESQL
-- ## Funções de Agregação ## --
-- COUNT, SUM, AVG, MIN, MAX

-- 1. COUNT

-- a) Descubra a quantidade de clientes:

SELECT * FROM customers;

SELECT COUNT(*) FROM customers;


-- b) Descubra a quantidade de produtos:

SELECT COUNT(*) FROM products;





-- 2. SUM

-- a) Qual é a soma total de estoque de produtos?

SELECT * FROM products;

SELECT 
    SUM(units_in_stock) AS "TotalEstoque"
FROM products;


-- b) Qual é a soma total de vendas de produtos? (lembre-se que existem 2 tabelas de orders)

SELECT * FROM orders;

SELECT * FROM order_details;

SELECT 
    SUM(quantity)
FROM order_details;





-- 3. AVG, MIN, MAX

-- a) Descubra a média, mínimo e máximo de unit_price da tabela products

SELECT * FROM products;

SELECT 
    AVG(unit_price) AS preco_medio,
    MIN(unit_price) AS menor_preco,
    MAX(unit_price) AS maior_preco
FROM products;





-- ## Criando agrupamento ## --
-- GROUP BY

-- 1. Faça um agrupamento para descobrir a quantidade total de clientes por country.

SELECT * FROM customers;

SELECT DISTINCT country FROM customers;

SELECT
    country,
    COUNT(*)
FROM customers
GROUP BY country
ORDER BY COUNT(*) DESC;


-- 2. Faça um agrupamento para descobrir a quantidade total de clientes por title.

SELECT
    contact_title,
    COUNT(*)
FROM customers
GROUP BY contact_title
ORDER BY COUNT(*) DESC;


-- 3. Faça um agrupamento para descobrir a soma total de estoque por supplier_id.

SELECT * FROM products;

SELECT * FROM suppliers;

SELECT
    supplier_id,
    SUM(units_in_stock)
FROM products
GROUP BY supplier_id;


-- 4. Faça um agrupamento para descobrir a média de unit_price por supplier_id.

SELECT
    supplier_id,
    AVG(unit_price)
FROM products
GROUP BY supplier_id;





-- GROUP BY + WHERE vs GROUP BY + HAVING

-- 1. Faça um agrupamento para descobrir a quantidade total de clientes por country. O seu agrupamento deve considerar apenas os clientes de contact_title = 'Owner'.

SELECT * FROM customers;

SELECT
    country,
    COUNT(*)
FROM customers
WHERE contact_title = 'Owner'
GROUP BY country;


-- 2. Faça um agrupamento para descobrir a quantidade total de clientes por country. A query resultante deve conter apenas os países que têm mais de 10 clientes.

SELECT
    country,
    COUNT(*)
FROM customers
GROUP BY country
HAVING COUNT(*) >= 10;
