select 
  avg(unit_price)
  ceiling(avg(unit_price)) -- 2.3338 = 3
  floor(avg(unit_price)) -- 2.3338 = 2

  -- o uso do cast se da devido ao tipo de dado de retorno da função avg()
  round(cast(avg(unit_price)) as numeric, 3) -- arredonda até 3 casas decimais 2.3338 = 2334
  trunc(cast(avg(unit_price)) as numeric, 3) -- limita até 3 casas decimais 2.3338 = 2.333
FROM products;

/* 
  ROUND(numero, numero_de_casas_decimais)
  arredonda normalmente dentro do limite determinado. Se o último digitado dentro do limite
  for >=5, ele arredonda pra cima, caso contrário ele arredonda pra baixo.

  TRUNC(numero, numero_de_casas_decimais)
  remove as casas decimais de um número até um determinado ponto,
  sem realizar nenhum tipo de arredondamento.
*/