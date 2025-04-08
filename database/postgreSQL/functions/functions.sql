create or replace function analise_estoque(estoque_min int, estoque_max int)
returns int
language plpgsql
as
$$
declare
    contagem_estoque int;

begin
    contagem_estoque = (select count(*) from products where units_in_stock between estoque_min and estoque_max);

    return contagem_estoque;
    
end $$;



select analise_estoque(10, 50); 


select count(*) - analise_estoque(10, 50) from products; 

-- i) Usando a notação por posição:

select analise_estoque(20, 50);


-- ii) Usando a notação por nome do parâmetro:

select analise_estoque(estoque_min := 20, estoque_max := 50);


-- iii) Usando a notação mista:

select analise_estoque(20, estoque_max := 50); 
-- A notação mistra não é recomendável, pois se fizer o contrário, dá erro:
-- select analise_estoque(estoque_min := 20, 50);



-- Excluindo uma Function:

drop function analise_estoque;
drop function if exists analise_estoque;