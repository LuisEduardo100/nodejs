/*
CURRENT_DATE
AGE
DATE_PART
*/
SELECT
  first_name,
  birth_date,
  current_date, -- 'Y-m-d'
  age(birth_date), -- X yers Y months Z days
  age(hire_date), -- X yers Y months Z days
  date_part('day', birth_date) -- Dia do aniversário
FROM employees;
