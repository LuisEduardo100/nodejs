/**
* Uso do IN para simplificar casos de filtro com múltiplos OR
*
*/
SELECT * FROM customers; 
WHERE country = 'Mexico' OR  country = 'UK' OR country = 'Canada';

SELECT * FROM customers; 
WHERE country IN ('Mexico', 'UK', 'Canada');

/**
* Uma alternativa ao filtro AND para quando precisar filtrar por mais de uma condição
* O between inclui os extremos e simplifica a escrita do código
*/
SELECT * FROM products; 
WHERE unit_price >= 50 AND unit_price <= 100;
SELECT * from products 
WHERE unit_price BETWEEN 50 AND 100;

SELECT * FROM orders
WHERE order_date >= '1997-01-01' AND order_date <= '1997-12-31';
SELECT * FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31';

/**
* O LIKE vai buscar o que está escrito dentro da célula da coluna escolhida
* O % é necessário para indicar que quer ler o valor de dentro da célula
*/
SELECT * FROM products
WHERE quantity_per_unit LIKE '%boxes%';