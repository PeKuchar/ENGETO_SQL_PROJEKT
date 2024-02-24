-- ENGETO SQL PROJEKT - ODPOVED NA OTAZKU c.4

-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?



WITH food_price_and_payroll AS
(
	WITH food_price AS
	(
		SELECT 
	  	      year ,
	     	  avg_food_price,
	     	  LAG(avg_food_price) OVER (ORDER BY year) AS prev_avg_food_pr
		FROM 
		    (
			SELECT 
	  	     	  p_year AS year,
	     	      ROUND(AVG(avg_value),1) AS avg_food_price
	     	FROM t_Petr_Kuchar_project_SQL_primary_final
		    WHERE ib_code LIKE "______" 
		    GROUP BY year
		    ) AS afpt	
	)
	,
	payroll AS 
	(
   	   SELECT 
	   	     p_year,
	      	 avg_payroll,
	      	 LAG(avg_payroll) OVER (ORDER BY p_year) AS prev_avg_payroll
		FROM 
		    (
			SELECT 
	   	          p_year,
	      	      ROUND(AVG(avg_value),1) AS avg_payroll
	        FROM t_Petr_Kuchar_project_SQL_primary_final
	        WHERE ib_code LIKE "_"
	        GROUP BY p_year
		    ) AS apt	
	) 
   SELECT 
	   fp.year,
	   fp.avg_food_price,
	   fp.prev_avg_food_pr,
	   ROUND(((fp.avg_food_price -  fp.prev_avg_food_pr) / fp.prev_avg_food_pr) * 100 ,2)  AS avg_food_pr_diff,
	   pa.avg_payroll,
	   pa.prev_avg_payroll,
	   ROUND(((pa.avg_payroll - pa.prev_avg_payroll) / pa.prev_avg_payroll) * 100 ,2) AS avg_pay_diff
   FROM food_price fp
   JOIN payroll pa ON fp.year = pa.p_year
)
SELECT 
      year,
      avg_food_price,
      prev_avg_food_pr,
      avg_food_pr_diff,
      avg_payroll,
      prev_avg_payroll,
      avg_pay_diff,
      percentage_difference
FROM
    (
     SELECT * ,
            avg_food_pr_diff - avg_pay_diff AS percentage_difference
     FROM food_price_and_payroll fpap
    ) AS pediff
WHERE percentage_difference > 10
;	
	
-- Neexistuje rok, ve kterém by byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %).	















