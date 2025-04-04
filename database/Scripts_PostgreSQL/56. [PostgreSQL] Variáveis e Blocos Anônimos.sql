-- INÍCIO MÓDULO
-- Variáveis e Blocos Anônimos 

-- Aula 1 - Variáveis, Datatypes e Blocos Anônimos

-- Variáveis são pedaços de memória onde armazenamos alguma informação. Uma variável está sempre associada a um tipo de dado em particular.

-- Os tipos mais comuns de dados são:

-- 1. Numéricos: int e decimal
-- 2. Textos: varchar(n)
-- 3. Datas: date


-- Bloco Anônimo (Introdução)

-- No PostgreSQL, é possível criar os chamados Blocos Anônimos, blocos de códigos que são a base para Functions e Procedures.
-- Abaixo, temos a estrutura de um bloco anônimo.

/*

<<label>>
declare
    declaracao;
begin
    corpo do código;
    
end label;
*/

-- Cada bloco possui duas sessões: declaração e corpo.
-- A sessão de declaração é opcional e é onde declaramos todas as variáveis usadas no corpo do código.
-- A sessão do corpo é obrigatória e é onde criamos os nossos códigos.
-- Em ambas as sessões é obrigatório o uso do ponto e vírgula ao final de cada instrução.

-- Abaixo, temos um exemplo de um bloco anônimo:

do $$
declare
    nome varchar(100);
    salario decimal;
    data_contratacao date;
begin
    nome := 'André';
    salario := 3500;
    data_contratacao := '25-10-2018';
    raise notice 'O funcionário % foi contratado em % e recebe um salário de R$ %.', nome, data_contratacao, salario;

end $$;





-- Aula 2 - Blocos Anônimos - Exemplos

-- Exemplo 1: Criando uma calculadora simples de valor vendido. Utilize as variáveis 'quantidade', 'preco', 'valor_vendido' e 'vendedor' para isso.

do $$
declare
    quantidade int := 50;
    preco decimal := 100;
    valor_vendido int; 
    vendedor varchar(100) := 'Bruna';
    
begin
    valor_vendido := quantidade * preco;
    
    raise notice 'O vendedor % vendeu o total de R$ %.', vendedor, valor_vendido;

end $$;


-- Exemplo 2: Quantos produtos têm o preço acima da média de preços?

do $$
declare
    media_preco decimal;
    qtd_produtos_acima_media int;

begin
    media_preco = (select avg(unit_price) from products);
    qtd_produtos_acima_media = (select count(*) from products where unit_price >= media_preco);
    
    raise notice 'A quantidade de produtos com preço acima da média é de: % produtos.', qtd_produtos_acima_media;
    
end $$;
