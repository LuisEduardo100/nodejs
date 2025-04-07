/*
UPPER
LOWER
LENGTH
INTCAP
*/
SELECT 
  first_name,
  upper(first_name), -- tudo maiúsculo
  lower(first_name), -- deixa tudo minúsculo
  length(first_name), -- retorna a quantidade de caracteres do nome
  initcap('sql impressionador') -- primeira letra maiúscula 
FROM employees;

/*
REPLACE
*/
SELECT * FROM customers;
SELECT 
  contact_name,
  contact_title,
  REPLACE(contact_title, 'Owner', 'CEO') 
FROM customers;

/*
SUBSTRING
STRPOS
*/
SELECT
  'ABC-9999',
  left('ABC-9999', 3), -- 'ABC'
  right('ABC-9999', 4); -- '9999'

SELECT
  'ABC-9999',
  substring('ABC-9999', 1, strpos('ABC-9999', '-') - 1), -- 'ABC'
  substring('ABC-9999', strpos('ABC-9999', '-') + 1, 4), -- '9999'
  substring('ABC-9999', 1, 3), -- 'ABC'
  substring('ABC-9999', 5, 4), -- '9999'
  strpos('ABC-9999', '-') -- '4'


