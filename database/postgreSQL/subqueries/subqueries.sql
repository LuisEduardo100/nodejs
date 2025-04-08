SELECT avg(unit_price) FROM products; -- 28.83338

SELECT * FROM products
WHERE unit_price >= 28.83338;

SELECT * FROM products
WHERE unit_price >= (SELECT avg(unit_price) FROM products);

SELECT * FROM order_details
WHERE quantity >= (
  SELECT
    avg(quantity)
  FROM order_details
);

SELECT
  avg(total_clientes)
FROM (
  SELECT 
    contact_title,
    count(*) total_clientes
  FROM customers
  GROUP BY contact_title) t;

SELECT
  *,
  (SELECT avg(unit_price) FROM products) media_preco
FROM products;

SELECT 
  order_id,
  sum(quantity)
FROM order_details
GROUP BY order_id
HAVING sum(quantity) >= (
  SELECT 
    avg(total_vendido)
  FROM (
    SELECT 
      order_id,
      sum(quantity) total_vendido
    FROM order_details
    GROUP BY order_id
  ) t);
