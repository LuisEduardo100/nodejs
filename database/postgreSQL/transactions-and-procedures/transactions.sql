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


                         
                         

