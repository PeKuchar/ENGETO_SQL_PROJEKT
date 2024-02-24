
-- Tabulka s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.


CREATE OR REPLACE TABLE t_Petr_Kuchar_project_SQL_secondary_final
SELECT e.country,
	   e.GDP,
	   e.gini,
	   e.population,
	   e.year
FROM economies AS e 
JOIN countries AS c ON e.country = c.country
WHERE c.continent = 'Europe' AND e.country != 'Czech Republic' AND e.GDP IS NOT NULL AND e.year BETWEEN 2006 AND 2018
ORDER BY e.country, e.year
;


SELECT *
FROM t_Petr_Kuchar_project_SQL_secondary_final
;




