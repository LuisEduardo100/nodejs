-- criação de tabelas
CREATE TABLE IF NOT EXISTS public.purchases (
  id SERIAL PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  purchase_date DATE NOT NULL,
  customer_id INT NOT NULL,
  CONSTRAINT 
    FOREIGN KEY(customer_id) 
    REFERENCES customers(id)
);

CREATE TABLE IF NOT EXISTS public.customers (
  id SERIAL PRIMARY KEY ,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(15) UNIQUE NOT NULL
  address VARCHAR(255) NOT NULL
  registration_date DATE NOT NULL
);

BEGIN TRANSACTION;

ALTER TABLE purchases 
ALTER COLUMN purchase_date 
TYPE TIMESTAMP;

-- COMIT;

UPDATE purchases
SET purchase_date = '2004-10-19 10:23:54'
WHERE id=1;