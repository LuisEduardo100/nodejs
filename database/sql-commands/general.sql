-- contar
SELECT COUNT(*) as total_users
FROM users;

-- ordernar
SELECT * 
FROM users
ORDER BY name ASC;

SELECT * 
FROM users
ORDER BY name DESC;

-- group by
SELECT name, COUNT(*) as total_users
FROM users
GROUP BY name;

-- joins

-- left join
SELECT users.id, users.name, users.surname, addresses.street, addresses.city
FROM users
    LEFT JOIN addresses ON users.id = addresses.user_id;
-- inner join 
SELECT users.id, users.name, users.surname, addresses.street, addresses.city
FROM users
    INNER JOIN addresses ON users.id = addresses.user_id;

-- subquery
SELECT *
FROM users
WHERE id IN (
    SELECT user_id
    FROM addresses
    WHERE city = 'London'
    GROUP BY user_id
    HAVING COUNT(*) > 1
);

-- create table
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    street VARCHAR(255),
);

-- add foreign key
ALTER TABLE addresses
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES users(id)
ON DELETE CASCADE;

-- update column
ALTER TABLE users
ADD COLUMN age INT;

-- rename column
ALTER TABLE users
RENAME COLUMN age TO age_years;

-- alter table
ALTER TABLE addresses
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

-- drop table
DROP TABLE addresses;

-- truncate table
TRUNCATE TABLE addresses;
