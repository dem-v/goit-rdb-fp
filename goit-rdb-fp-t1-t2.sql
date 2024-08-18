-- Task 1
CREATE SCHEMA pandemia;

USE pandemia;

-- Task 2
DROP TABLE IF EXISTS entities;
CREATE TABLE entities
(
	Entity_id INT auto_increment PRIMARY KEY,
	Entity VARCHAR(255),
    Code VARCHAR(15)
);

DROP TABLE IF EXISTS infectious_cases;
CREATE TABLE infectious_cases
(
	ID INT auto_increment PRIMARY KEY,
    Entity_id INT,
    Year YEAR,
  Number_yaws          INTEGER 
  ,polio_cases          INTEGER 
  ,cases_guinea_worm    INTEGER 
  ,Number_rabies        DOUBLE
  ,Number_malaria       DOUBLE
  ,Number_hiv           DOUBLE
  ,Number_tuberculosis  DOUBLE
  ,Number_smallpox      INTEGER 
  ,Number_cholera_cases INTEGER 
);

INSERT INTO entities (Entity, Code)
SELECT DISTINCT Entity, Code
FROM pandemia.infectious_cases_temp;

INSERT INTO infectious_cases(Entity_id, Year, Number_yaws, polio_cases, cases_guinea_worm, Number_rabies, Number_malaria, Number_hiv, Number_tuberculosis, Number_smallpox, Number_cholera_cases)
SELECT e.Entity_id, 
		Year,Number_yaws,polio_cases,cases_guinea_worm,CAST(Number_rabies AS DOUBLE), CAST(Number_malaria AS DOUBLE),CAST(Number_hiv AS DOUBLE),CAST(Number_tuberculosis AS DOUBLE),Number_smallpox,Number_cholera_cases
FROM pandemia.infectious_cases_temp t
LEFT JOIN entities e ON e.Entity = t.Entity and e.Code = t.Code;
