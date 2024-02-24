
-- Tabulka pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky.

CREATE OR REPLACE TABLE t_Petr_Kuchar_project_SQL_primary_final
WITH united_payroll_price AS
(
   WITH czechia_payroll_selection AS
   (
      SELECT 
            cpa.value,
	        cpa.value_type_code,
	        cpa.calculation_code,
	        cpa.industry_branch_code,
	        cpa.payroll_year,
	        cpib.name
     FROM czechia_payroll cpa
     JOIN czechia_payroll_industry_branch cpib ON cpa.industry_branch_code = cpib.code
     WHERE cpa.value_type_code = 5958 AND cpa.industry_branch_code IS NOT NULL AND cpa.calculation_code = 200 AND cpa.payroll_year BETWEEN 2006 AND 2018
   )
   SELECT 
         ROUND(AVG(value),1) AS avg_value,
	     CAST(industry_branch_code AS varchar(10)) AS ib_code, 
	     payroll_year AS p_year,
	     name AS p_name
   FROM czechia_payroll_selection cpas
   WHERE value IS NOT NULL
   GROUP BY p_year, ib_code
 UNION ALL
   SELECT 
         ROUND(CAST(AVG(value) AS decimal(12,1)),1) AS avg_pr_value,
         CAST(category_code AS varchar(10)) AS cat_code,
         YEAR(date_from) AS cpr_year,
         cpc.name
   FROM czechia_price
   JOIN czechia_price_category cpc ON category_code = cpc.code
   WHERE region_code IS NULL
   GROUP BY cpr_year, cat_code
)
,
economies_selection AS
(
    SELECT
          GDP,
	      year
    FROM economies 
    WHERE country = 'Czech Republic' AND GDP IS NOT NULL AND year BETWEEN 2006 AND 2018
)
SELECT avg_value,
       ib_code,
       p_year,
       p_name,
       GDP
FROM united_payroll_price 
JOIN economies_selection es ON p_year = es.year	
ORDER BY p_year, ib_code
;

    
SELECT *
FROM t_Petr_Kuchar_project_SQL_primary_final
;


