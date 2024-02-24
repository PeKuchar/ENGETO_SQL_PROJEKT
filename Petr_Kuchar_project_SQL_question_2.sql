-- ENGETO SQL PROJEKT - ODPOVED NA OTAZKU c.2

-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?


WITH average_wages AS
(
   SELECT
         p_year,
	     ROUND(AVG(avg_value),1) AS total_avg_value
   FROM t_Petr_Kuchar_project_SQL_primary_final
   WHERE ib_code LIKE "_" AND p_year IN(2006,2018)
   GROUP BY p_year
)
,
price_bread_milk AS
(
   SELECT 
         p_year AS price_food_year,
         ib_code AS food_code,
         p_name AS food_name,
         avg_value AS price_food
   FROM t_Petr_Kuchar_project_SQL_primary_final 
   WHERE (ib_code = "111301" OR ib_code  = "114201")
         AND
         p_year IN(2006,2018)
   GROUP BY p_year, ib_code
)
SELECT
       p_year,
       total_avg_value,
       food_code,
       food_name,
       price_food,
	   ROUND(total_avg_value / price_food) AS food_amount
FROM average_wages aw
JOIN price_bread_milk pbm ON aw.p_year = pbm.price_food_year
GROUP BY pbm.price_food_year, pbm.food_name
;	

-- V roce 2006 (první srovnatelné období) je možné si koupit, za průměrnou měsíční mzdu přes všechna odvětví, 1315[kg] chleba nebo 1470[l] mléka.
-- V roce 2018 (poslední srovnatelné období) je možné si koupit, za průměrnou měsíční mzdu přes všechna odvětví, 1367[kg] chleba nebo 1671[l] mléka.





