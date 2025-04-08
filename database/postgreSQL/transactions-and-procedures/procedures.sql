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

select * from contas;