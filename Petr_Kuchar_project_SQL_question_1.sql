-- ENGETO SQL PROJEKT - ODPOVED NA OTAZKU c.1

-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH payroll_comparison AS
(
   WITH auxiliary_previous_value AS
   (
	  SELECT     
	        avg_value AS avg_sal,
	        LAG(avg_value, 1) OVER (ORDER BY ib_code, p_year ) AS pre_val,
	        ib_code,
	        LAG(ib_code,1) OVER (ORDER BY ib_code, p_year ) AS pre_ib_code,
	        p_year,
	        p_name
	  FROM t_Petr_Kuchar_project_SQL_primary_final
	  WHERE ib_code LIKE "_"
   )
   SELECT
         avg_sal,
	     pre_val,
	     pre_ib_code,
	     p_year,
	     p_name,  
	     CASE  WHEN avg_sal > pre_val AND ib_code = pre_ib_code THEN "wages are rising"
	           WHEN avg_sal < pre_val AND ib_code = pre_ib_code THEN "wages are falling"
	           ELSE NULL
	     END AS p_comparison
   FROM auxiliary_previous_value
   GROUP BY p_year, ib_code
)
SELECT 
      p_year,
      pre_ib_code,
      p_name,
      p_comparison
FROM payroll_comparison
WHERE p_comparison =  "wages are falling"
GROUP BY p_year, pre_ib_code
ORDER BY pre_ib_code, p_year
;


-- Ve výsledné tabulce, z období mezi 2006 až 2018, je možné vidět odvětví a roky v kterých mzda klesá.
-- V ostatních případech mzdy rostou.






















