-- Aula 1 - O que é uma Subquery
-- Subqueries no SQL são queries dentro de queries. É a possibilidade de reaproveitar o resultado de uma query (select) dentro de outra.

-- Exemplo: Quais produtos têm um preço acima da média?

select * from products;


select avg(unit_price) from products; -- 28.833896...


select * from products
where unit_price >= (select avg(unit_price) from products);





-- Aula 2 - Subquery: Cláusula WHERE
-- Exemplo: Quais pedidos têm uma quantidade vendida acima da quantidade vendida média? 

select * from order_details;


select avg(quantity) from order_details; -- 23.81299...


select * from order_details
where quantity >= (
                    select 
                        avg(quantity) 
                    from order_details
                  );





-- Aula 3 - Subquery: Cláusula FROM
-- Exemplo: Qual é a média de clientes de acordo com o cargo?

select * from customers;


select
    avg(total_clientes)
from (
    select 
        contact_title,
        count(*) total_clientes
    from customers 
    group by contact_title) t;
    




-- Aula 4 - Subquery: Cláusula SELECT
-- Exemplo: Faça uma consulta à tabela products e adicione uma coluna que contenha a média geral de preço dos produtos.

select * from products;


select 
    *,
    (select avg(unit_price) from products) media_preco
from products;





-- Aula 5 - Subquery: Corrigindo a análise de pedidos acima da média
-- Exemplo: Quais pedidos têm uma quantidade vendida acima da quantidade vendida média? 

select * from order_details;


select 
    order_id,
    sum(quantity)
from order_details
group by order_id
having sum(quantity) >= (
                select
                    avg(total_vendido)
                from (
                    select 
                        order_id,
                        sum(quantity) total_vendido
                    from order_details
                    group by order_id) t);
