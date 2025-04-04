-- INÍCIO MÓDULO
-- Funções de Número, Texto e Data
-- Aula 1 - Funções de Número

-- Ceiling, Floor, Round, Trunc

select * from products;

select 
    avg(unit_price),
    ceiling(avg(unit_price)), 
    floor(avg(unit_price)), 
    round(cast(avg(unit_price) as numeric), 3), 
    trunc(cast(avg(unit_price) as numeric), 3) 
from products;





-- Aula 2 - Funções de Texto

-- Upper, Lower, Length, Initcap

select * from employees;

select 
    first_name,
    upper(first_name),
    lower(first_name),
    length(first_name),
    initcap('sql impressionador')
from employees;





-- Replace

select * from customers;

select
    contact_name,
    contact_title,
    replace(contact_title, 'Owner', 'CEO')
from customers;


-- Substring e Strpos

select
    'ABC-9999',
    left('ABC-9999', 3),
    right('ABC-9999', 4);
    
    
select
    'ABC-9999',
    substring('ABC-9999', 1, strpos('ABC-9999', '-') -1),
    substring('ABC-9999', strpos('ABC-9999', '-') +1, 100),
    strpos('ABC-9999', '-');
    


  

-- Aula 3 - Funções de Data 

-- Current_Date, Age, Date_Part

select * from employees;

select 
    first_name,
    birth_date,
    current_date,
    age(birth_date),
    date_part('day', birth_date),
    date_part('month', birth_date),
    date_part('year', birth_date)
from employees;
