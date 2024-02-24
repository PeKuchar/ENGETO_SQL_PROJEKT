# ENGETO_SQL_PROJEKT
Datová akademie ENGETO - Projekt z SQL - Data o mzdách a cenách potravin a jejich zpracování pomocí SQL.

# ZADÁNÍ
Úvod do projektu
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

Výzkumné otázky
1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách    potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

Výstup projektu
Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte t_{jmeno}_{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

# ANALÝZA
V projektu jsem využíval následující tabulky:
Primární tabulky
1) czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
2) czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
3) czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
4) czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
5) czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
6) czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
7) czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.


Dodatečné tabulky
1) countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
2) economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.


V tabulce czechia _payroll jsou mzdy (value) uvedeny za jednotlivá čtvrtletí (payroll quarter) v příslušném roce (payroll year).
-dále-
v tabulce "czechia_payroll" jsou dvě různé hodnoty "value_type_code",
jejich význam je možné zjistit z tabulky "czechia_payroll_value_type" :
316 - Průměrný počet zaměstnaných osob
5958 - Průměrná hrubá mzda na zaměstnance
použiju kód 5958
-dále-
v tabulce czechia_payroll jsou dvě různé hodnoty "calculation_code",
jejich význam je možné zjistit z tabulky "czechia_payroll_calculation" :
100 - fyzický
200 - přepočtený 
použiju kód 200
-dále-
v tabulce czechia_payroll jsou dvě různé hodnoty "unit_code",
jejich význam je možné zjistit z tabulky "czechia_payroll_unit":
200 - Kč
80403 - tis. osob (tis. os.)
kód 200 je spřažen s kódem 5958 (value_type_code)
-dále-
v tabulce czechia_payroll jsou odvětví uvedena pod písmeným kódem "industry_branch_code",
jejich význam je možné zjistit z tabulky "czechia_payroll_industry_branch":
A	Zemědělství, lesnictví, rybářství
B	Těžba a dobývání
C	Zpracovatelský průmysl
D	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu
E	Zásobování vodou; činnosti související s odpady a sanacemi
F	Stavebnictví
G	Velkoobchod a maloobchod; opravy a údržba motorových vozidel
H	Doprava a skladování
I	Ubytování, stravování a pohostinství
J	Informační a komunikační činnosti
K	Peněžnictví a pojišťovnictví
L	Činnosti v oblasti nemovitostí
M	Profesní, vědecké a technické činnosti
N	Administrativní a podpůrné činnosti
O	Veřejná správa a obrana; povinné sociální zabezpečení
P	Vzdělávání
Q	Zdravotní a sociální péče
R	Kulturní, zábavní a rekreační činnosti
S	Ostatní činnosti



V tabulce "czechia_price" jsou ceny potravin (value) uvedeny za časové období (date_from a date_to) v příslušném roce 
-dále-
v tabulce  "czechia_price" jsou kódy potravin "category_code",
jejich význam je možné zjistit z tabulky "czechia_price_category":
111101	Rýže loupaná dlouhozrnná
111201	Pšeničná mouka hladká
111301	Chléb konzumní kmínový
111303	Pečivo pšeničné bílé
111602	Těstoviny vaječné
112101	Hovězí maso zadní bez kosti
112201	Vepřová pečeně s kostí
112401	Kuřata kuchaná celá
112704	Šunkový salám
114201	Mléko polotučné pasterované
114401	Jogurt bílý netučný
114501	Eidamská cihla
114701	Vejce slepičí čerstvá
115101	Máslo
115201	Rostlinný roztíratelný tuk
116101	Pomeranče
116103	Banány žluté
116104	Jablka konzumní
117101	Rajská jablka červená kulatá
117103	Papriky
117106	Mrkev
117401	Konzumní brambory
118101	Cukr krystalový
122102	Přírodní minerální voda uhličitá
212101	Jakostní víno bílé
213201	Pivo výčepní, světlé, lahvové
2000001	Kapr živý


V dodatečné tabulce "countries" je uveden přehled zemí (country) na světě.

V dodatečné tabulce "economies" je uveden hrubý domácí produkt (GDP) pro příslušnou zemi v daném roce.


# POSTUP
Nejdříve jsem vytvořil první tabulku "Petr_Kuchar_project_SQL_primary_final".
V této tabulce jsem pomocí CTE (Common Table Expresion) vybral a vyfiltroval potřebné sloupce z tabulky "czechia_payroll" a 
vypočítal průměrné mzdy pro daný rok  a příslušná odvětví za období 2006 až 2018 (společné období s tabulkou "czechia_price).
Následně jsem k této části připojil přes "UNION" vybranou a vyfiltrovanou část tabulky "czechia_price" včetně výpočtu průměrné ceny potravin pro danou kategorii v příslušném roce.
Dále jsem spojil tuto předchozí část s tabulkou s informacemi o HDP pro Českou republiku za stejné období 2006 až 2018.

Poté jsem pokračoval vytvořením 5 SQL souborů, z kterých je možné získat odpověď na jednotlivé otázky s využitím tabulky
"Petr_Kuchar_project_SQL_primary_final". Podrobnosti viz VÝSLEDKY.

Nakonec jsem vytvořil druhou tabulku "Petr_Kuchar_project_SQL_secondary_final", z které je možné vidět požadované informace o HDP, GINI koeficientu a populaci dalších evropských států ve stejném období (2006 až 2018).

# VÝSLEDKY
Vytvořeno 7 SQL souborů:
- Petr_Kuchar_project_SQL_primary_final
- Petr_Kuchar_project_SQL_secondary_final
- Petr_Kuchar_project_SQL_question_1
- Petr_Kuchar_project_SQL_question_2
- Petr_Kuchar_project_SQL_question_3
- Petr_Kuchar_project_SQL_question_4
- Petr_Kuchar_project_SQL_question_5

Odpovědi na otázky:
1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 
O: Ve výsledné tabulce, z období mezi 2006 až 2018, je možné vidět odvětví a roky v kterých mzda klesá.
   V ostatních případech mzdy rostou.
   Mzdy za sledované období 2006 až 2018 rostou pouze v odvětvích "Zpracovatelský průmysl" (číselník odvětví - C),
   "Zdravotní a sociální péče" (Q) a "Ostatní činnosti" (S).



2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

O: V roce 2006 (první srovnatelné období) je možné si koupit, za průměrnou měsíční mzdu přes všechna odvětví, 1315[kg] chleba
   nebo 1470[l] mléka.
   V roce 2018 (poslední srovnatelné období) je možné si koupit, za průměrnou měsíční mzdu přes všechna odvětví, 1367[kg] chleba
   nebo 1671[l] mléka.



3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

O: Nejpomaleji zdražuje Cukr krystalový. Ve sledovaném období, (2006 až 2018), byla cena v roce 2018 oproti roku 2006 o 27,2% nižší.



4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

O: Neexistuje rok, ve kterém by byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %).	



5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách    potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

O: Za výraznější roční růst HDP jsem určil hodnoty větší než 5%.
   Nelze jednoznačně říci, že by se výraznější růst HDP projevil růstem cen potravin nebo mezd ve stejném nebo následujícím roce.
   V roce 2007, kdy došlo k výraznějšímu růstu HDP a v následném roce 2008, ano výrazněji vzrostly ceny potravin a navýšily se mzdy.
   Na druhou stranu v roce 2015 a následném roce 2016 došlo k poklesu cen potravin a mírnému navýšení mezd.
   V roce 2017 došlo k výraznějšímu nárůstu cen potravin a navýšení mezd, ale v následném roce došlo jen k mírnému nárůstu
   cen potravin a výraznému navýšení mezd.


