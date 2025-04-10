/**
* GROUP BY agrupa os valores distintos em um só
* Isso facilita processo de contagem em grupos
* O GROUP BY faz a função do SELECT DISTINCT com um propósito
*/
SELECT * FROM customers;

-- pegando lista de paises 
SELECT DISTINCT country FROM customers;

-- quantidade total de clientes por pais
-- pegando lista de paises distintos e realizando a contagem de pessoas por paises
SELECT
  country,
  COUNT(*)
FROM customers
GROUP BY country
-- se não especificar nada ele ordena do menor para o maior
ORDER BY COUNT(*);

/**
* 
*/
