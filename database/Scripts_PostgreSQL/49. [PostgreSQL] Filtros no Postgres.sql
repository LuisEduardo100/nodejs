-- MÓDULO POSTGRESQL

-- ## WHERE ## --

-- Permite criar filtros nas consultas. Obs.: O Postgres é case-sensitive.

-- 1. Selecione a tabela customers
-- a) Crie um filtro para que sejam mostrados apenas os clientes com contact_title = 'Owner'.

SELECT * FROM customers
WHERE contact_title = 'Owner';


-- b) Crie um filtro para que sejam mostrados apenas os clientes do país France.

SELECT * FROM customers
WHERE country = 'France';


-- 2. Selecione a tabela products
-- a) Crie um filtro para que sejam mostrados os produtos com estoque igual a zero (units_in_stock).
-- b) Crie um filtro para mostrar os produtos com unit_price maior ou igual a 50.

SELECT * FROM products
WHERE units_in_stock = 0;

SELECT * FROM products
WHERE unit_price >= 50
ORDER BY unit_price DESC;


-- 3. Selecione a tabela orders
-- Crie um filtro para mostrar apenas os pedidos feitos depois do dia '01/01/1998'.

SELECT * FROM orders
WHERE order_date >= '1998-01-01';





-- ## WHERE + AND e OR ## --

-- Permite criar filtros com mais de uma coluna.
-- AND: o filtro será realizado se todas as condições forem verdadeiras.
-- OR: o filtro será realizado desde que PELO MENOS 1 condição seja verdadeira.

-- 1. Selecione a tabela customers
-- a) Crie um filtro para que sejam mostrados apenas os clientes com contact_title = 'Owner' E do país France.

SELECT * FROM customers
WHERE contact_title = 'Owner' AND country = 'France';

-- b) Crie um filtro para que sejam mostrados apenas os clientes do Mexico OU France.

SELECT * FROM customers
WHERE country = 'Mexico' OR country = 'France';





-- ## WHERE + LIKE ## --

-- Permite criar filtros especiais de textos.

-- 1. Selecione a tabela products
-- a) Quais são os produtos medidos em boxes?

SELECT * FROM products
WHERE quantity_per_unit LIKE '%boxes%';

-- b) Quais são os produtos medidos em ml?

SELECT * FROM products
WHERE quantity_per_unit LIKE '%ml%';





-- ## WHERE + IN ## --

-- Essa combinação é uma alternativa ao uso de múltiplos OR.

-- 1. Selecione a tabela customers
-- a) Quais clientes são dos países 'Mexico', 'UK', 'Canada' (utilize o método OR para resolver)

SELECT * FROM customers
WHERE country = 'Mexico' OR country = 'UK' OR country = 'Canada';

-- b) Quais clientes são dos países 'Mexico', 'UK', 'Canada' (utilize o método IN para resolver)

SELECT * FROM customers
WHERE country IN ('Mexico', 'UK', 'Canada');





-- ## WHERE + BETWEEN ## --

-- Essa combinação é uma alternativa ao uso do AND para filtrar intervalos de números e datas.

-- 1. Selecione a tabela products
-- a) Quais produtos têm um unit_price entre 50 e 100 (utilize o método AND para resolver)

SELECT * FROM products
WHERE unit_price >= 50 AND unit_price <= 100;

-- b) Quais produtos têm um unit_price entre 50 e 100 (utilize o método BETWEEN para resolver)

SELECT * FROM products
WHERE unit_price BETWEEN 50 AND 100;



-- 2. Selecione a tabela orders
-- a) Quais pedidos foram feitos entre 01/01/1997 e 31/12/1997 (utilize o método AND para resolver)

SELECT * FROM orders
WHERE order_date >= '1997-01-01' AND order_date <= '1997-12-31';

-- b) Quais pedidos foram feitos entre 01/01/1997 e 31/12/1997 (utilize o método BETWEEN para resolver)

SELECT * FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31';
