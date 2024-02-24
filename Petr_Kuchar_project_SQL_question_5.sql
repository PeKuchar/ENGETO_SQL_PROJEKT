-- ENGETO SQL PROJEKT - ODPOVED NA OTAZKU c.5

-- Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin 
-- či mzdách ve stejném nebo násdujícím roce výraznějším růstem?


WITH price_payroll_hdp_comparison AS 
(
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
	      ROUND(((fp.avg_food_price -  fp.prev_avg_food_pr) / fp.prev_avg_food_pr) * 100 ,1)  AS avg_food_pr_diff,
	      pa.avg_payroll,
	      pa.prev_avg_payroll,
	      ROUND(((pa.avg_payroll - pa.prev_avg_payroll) / pa.prev_avg_payroll) * 100 ,1) AS avg_pay_diff
      FROM food_price fp
      JOIN payroll pa ON fp.year = pa.p_year
   )
   ,
   hdp_difference AS
   (
      WITH previous_hdp AS
      (
	      SELECT 
                p_year,   
                ROUND(GDP) AS hdp,
                LAG(ROUND(GDP)) OVER (ORDER BY p_year) AS prev_hdp
	      FROM t_Petr_Kuchar_project_SQL_primary_final
	      GROUP BY p_year
      )
      SELECT 
            p_year AS hdp_p_year,
            hdp,
            prev_hdp,
            ROUND(((hdp - prev_hdp) / prev_hdp) * 100 ,1) AS hdp_diff
      FROM previous_hdp
   )
   SELECT *,
          LAG(hdp_diff) OVER (ORDER BY hdp_p_year) AS prev_hdp_diff
   FROM food_price_and_payroll fpap
   JOIN hdp_difference hd ON fpap.year = hd.hdp_p_year
)
SELECT
      year,
      avg_food_pr_diff,
      avg_pay_diff,
      hdp_diff
FROM price_payroll_hdp_comparison
WHERE hdp_diff > 5 OR prev_hdp_diff > 5
;	

-- Za výraznější roční růst HDP jsem určil hodnoty větší než 5%.
-- Nelze jednoznačně říci, že by výraznější růst HDP se projevil růstem cen potravin nebo mezd ve stejném nebo následujícím roce.
















