-- ENGETO SQL PROJEKT - ODPOVED NA OTAZKU c.3

-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
	
		
WITH starting_and_final_price AS
(
   WITH allocation_starting_price AS
   (
      SELECT 
	        avg_value AS avg_price_2006,
	        ib_code,
	        p_name,
	        p_year
	  FROM t_Petr_Kuchar_project_SQL_primary_final
	  WHERE ib_code LIKE "______" AND (p_year = 2006)
   )
   ,
   allocation_final_price AS
   (
      SELECT 
	        avg_value AS avg_price_2018,
	        ib_code,
	        p_name,
	        p_year
	  FROM t_Petr_Kuchar_project_SQL_primary_final
	  WHERE ib_code LIKE "______" AND (p_year = 2018)
   )
   SELECT 
         avg_price_2006 AS starting_price,
	     avg_price_2018 AS final_price,
	     asp.p_name AS food_name,
	     asp.ib_code AS food_code
   FROM allocation_starting_price asp
   JOIN allocation_final_price afp ON asp.ib_code = afp.ib_code
   GROUP BY asp.ib_code
)
SELECT
      starting_price,
      final_price,
      food_name,
      food_code,
      ROUND(((final_price - starting_price)/starting_price) * 100, 1) AS percentage_increase
FROM starting_and_final_price
ORDER BY percentage_increase
LIMIT 1
;

-- Nejpomaleji zdražuje Cukr krystalový. Ve sledovaném období, (2006 až 2018), byla cena v roce 2018 oproti roku 2006 o 27,2% nižší.




	
	