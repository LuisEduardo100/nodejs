-- INÍCIO MÓDULO
-- Transactions e Procedures
-- Aula 1 - O que é uma Transação?

-- Uma transação em um banco de dados é uma unidade de trabalho que consiste em uma ou mais operações.
-- Um exemplo clássico de uma transação é uma transferência bancária de uma conta para outra. Se o remetente transfere um valor de X reais a um destinatário, este destinatário deverá receber exatamente esta quantia de X reais, nem mais, nem menos.



create table contas(
    id int,
    nome varchar(100),
    saldo decimal);                                           
                                           
select * from contas;

insert into contas(id, nome, saldo)
values(1, 'Ana', 5000);
               
                
                
           
begin transaction;                                           
insert into contas(id, nome, saldo)
values(2, 'Bruno', 10000);                                           
                                           
commit;

rollback;


-- Para fazer com que as mudanças fiquem visíveis em outras sessões, é necessário utilizar o comando COMMIT.

-- Já para desfazer uma transação, usamos o comando ROLLBACK.







-- Aula 2 - O que é e como criar uma Procedure

-- Até aqui aprendemos como criar blocos anônimos e functions. Porém, functions e blocos anônimos não são capazes de executar transações.
-- Ou seja, dentro de uma function, não podemos iniciar uma transação, ou dar commit/rollback nela.

-- A sintaxe para criação de uma Procedure é a seguinte:

/*
create or replace procedure nome_procedure(parametros)
language plpgsql
as $$
declare
    declaracao de variaveis
begin
    corpo de código
end $$;


Para excluir, a sintaxe é:

drop procedure nome_procedure;
*/


-- Exemplo: Crie uma procedure que cadastre um novo cliente na tabela Contas.
                                           
create or replace procedure cadastra_cliente(novo_id int, novo_cliente varchar(100), saldo_inicial decimal)
language plpgsql                                           
as $$                                       
begin                                           
    insert into contas(id, nome, saldo) values
    (novo_id, novo_cliente, saldo_inicial);                                            
                                           
    commit;                                                                                
                                           
end $$;                                           
   
   
call cadastra_cliente(3, 'Caio', 300);                                           
   
   
select * from contas;
   
   
drop procedure cadastra_cliente;                                           

                      
                      
-- Exemplo: Crie uma Procedure que controle transferências bancárias entre duas contas.
                  
                  
select * from contas;
                         
                         
create or replace procedure transferencia(remetente int, destinatario int, valor decimal)                            
language plpgsql
as $$                                           
begin 

    -- subtrair o montante transferido pelo remetente                                       
    update contas
    set saldo = saldo - valor                                       
    where id = remetente;                                       
    
    -- adicionar o montante transferido para o destinatário                                      
    update contas
    set saldo = saldo + valor                                       
    where id = destinatario;                                           
                                           
    commit;
                                           
end $$;                                          
     
                          
call transferencia(1, 2, 500);                                          
                                           
select * from contas;                                           
                               