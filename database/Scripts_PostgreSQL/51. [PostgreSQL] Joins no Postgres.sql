-- ## Joins ## --

-- I. INTRODUÇÃO
-- Os JOINs no SQL têm como objetivo relacionar as diferentes tabelas dos nossos bancos de dados.
-- Com eles, conseguimos dar um passo além nas nossas análises, permitindo cruzar as informações das diferentes tabelas.

-- Para criar Joins, o primeiro passo é descobrir qual coluna as tabelas que queremos relacionar têm em comum.
-- Será através dessas colunas que o SQL saberá a forma como ele deve cruzar os dados.

-- Exemplo: as tabelas 'products' e 'order_details' possuem uma coluna em comum, chamada 'product_id'.

-- É daí que vêm os conceitos de CHAVE PRIMÁRIA e CHAVE ESTRANGEIRA, já explicado aqui no curso em módulos anteriores.

-- II. SINTAXE

-- A sintaxe mais simples para relacionar 2 tabelas (que tenham a 'Coluna1' em comum) é a seguinte:

SELECT
    *
FROM
    Tabela_A
LEFT JOIN Tabela_B
ON Tabela_A.Coluna1 = Tabela_B.Coluna1;


-- Com a opção acima, estamos trazendo para uma mesma tabela TODAS as colunas das duas tabelas relacionadas, isso porque usamos o *.

-- Caso a gente queira escolher colunas específicas para visualizar na consulta final, seguimos a seguinte estrutura:

SELECT
    Tabela_A.Coluna1,
    Tabela_A.Coluna2,
    Tabela_A.Coluna3,
    Tabela_B.Coluna4
FROM
    Tabela_A
LEFT JOIN Tabela_B
ON Tabela_A.Coluna1 = Tabela_B.Coluna1;


-- Ou (Opção 2):

SELECT
    ta.Coluna1,
    ta.Coluna2,
    ta.Coluna3,
    tb.Coluna4
FROM
    Tabela_A ta
LEFT JOIN Tabela_B tb
ON ta.Coluna1 = tb.Coluna1;





-- LEFT JOIN x INNER JOIN x RIGHT JOIN x FULL JOIN

-- Imagine que temos uma tabela de VENDAS onde foram vendidos os produtos de id 1, 3 e 4
-- Imagine que temos uma tabela de PRODUTOS com produtos de id 1, 2 e 3

SELECT
    *
FROM vendas
XXXX JOIN produtos
ON vendas.id_produto = produtos.id_produto;


-- LEFT JOIN --> Vai trazer as linhas da tabela de VENDAS (tabela da esquerda): vendas dos produtos de id 1, 3 e 4
-- INNER JOIN --> Vai trazer as linhas de interseção entre a tabela de VENDAS e a de PRODUTOS: vendas dos produtos de id 1 e 3

-- RIGHT JOIN --> Vai trazer as linhas da tabela de PRODUTOS (tabela da direita): vendas dos produtos de id 1, 2 e 3
-- FULL JOIN --> Vai trazer todas as linhas das duas tabelas de VENDAS e PRODUTOS: vendas dos produtos de id 1, 2, 3 e 4





-- CRIANDO O PRIMEIRO JOIN

-- Faça um Join entre as tabelas 'products' e 'order_details'. Você deve retornar todas as colunas dessas duas tabelas.

SELECT * FROM products;

SELECT * FROM order_details;


SELECT 
    *
FROM order_details
LEFT JOIN products
ON order_details.product_id = products.product_id;





-- 1. Avalie como as tabelas 'products' e 'categories' podem se relacionar. Qual coluna as duas têm em comum?

SELECT * FROM products;
SELECT * FROM categories;


-- Como poderíamos criar uma consulta que retornasse product_id, product_name, category_id, unit_price (tabela products) e category_name (categories)?

SELECT 
    products.product_id,
    products.product_name,
    products.category_id,
    products.unit_price,
    categories.category_name
FROM products
INNER JOIN categories
ON products.category_id = categories.category_id;
    
    
-- Poderíamos dar nomes (aliases) para as tabelas:

SELECT 
    p.product_id,
    p.product_name,
    p.category_id,
    p.unit_price,
    c.category_name
FROM products p
LEFT JOIN categories c
ON p.category_id = c.category_id;





-- 2. Avalie como as tabelas 'customers' e 'orders' podem se relacionar. Qual coluna as duas têm em comum?
-- Respostas: customer_id

SELECT * FROM customers;

SELECT * FROM orders;


-- Como poderíamos criar uma consulta que retornasse order_id, customer_id, order_date (tabela orders) e contact_name (customers)? Será que existem clientes que não fizeram nenhuma compra?

SELECT 
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    customers.contact_name
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id;
    
    
SELECT DISTINCT customer_id FROM orders; -- 89 ids distintos (clientes que fizeram uma compra)
SELECT DISTINCT customer_id FROM customers; -- 91 ids distintos (clientes cadastrados na base)


-- Faça um Join entre as tabelas. Você seria capaz de descobrir qual o nome dos clientes que não fizeram nenhuma compra?

SELECT 
    orders.order_id,
    customers.customer_id,
    orders.order_date,
    customers.contact_name
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id;





-- ## Join + Group by + Order by ## --

-- Exemplo 1: Utilize os comandos JOIN, GROUP BY, ORDER BY para criar um agrupamento que retorne como resultado a quantidade total (SUM(quantity)) para cada product_name. Ordene o resultado, do maior para o menor, considerando a quantidade_total.

SELECT * FROM products;

SELECT * FROM order_details;

SELECT
    product_name,
    SUM(quantity) AS quantidade_total
FROM order_details
LEFT JOIN products
ON order_details.product_id = products.product_id
GROUP BY product_name
ORDER BY quantidade_total DESC;





-- ## Join + Group by + Where + Having ## 

-- Exemplo 2: Ainda utilizando o código da análise anterior, faça o agrupamento de quantidade_total por product_name, considerando apenas os produtos da classe luxo (produtos com preço acima de R$80)

SELECT
    p.product_name,
    SUM(od.quantity) AS quantidade_total
FROM order_details od
LEFT JOIN products p
ON od.product_id = p.product_id
WHERE p.unit_price >= 80
GROUP BY p.product_name
ORDER BY quantidade_total DESC;


-- Exemplo 3: Ainda utilizando o código da análise do Exemplo 1, faça o agrupamento de quantidade_total por product_name considerando apenas os produtos que tiveram uma quantidade_total maior ou igual a 1000. Obs.: estamos considerando a quantidade_total DEPOIS que o agrupamento foi feito.

SELECT
    product_name,
    SUM(quantity) AS quantidade_total
FROM order_details
LEFT JOIN products
    ON order_details.product_id = products.product_id
GROUP BY product_name
HAVING SUM(quantity) >= 1000
ORDER BY quantidade_total DESC;
