* Evaluación de Impacto
* TP2
* Caravaggio, Leonardo A.

* Start Code
cd "C:\Users\PC\Desktop\Impacto-main\TP2"
pause off
clear all
set more off
set mem 50m
set matsize 400

use "Datos - Mitze et al 2020\Data.dta"

format date %td
xtset dist_id date

keep if type==1
keep if date >= date("27032020", "DMY")
drop if date > date("26042020", "DMY")

synth cum_cases density educated female_prop age_female age_male dependency_old dependency_young physicians pharmacies, trunit(16053) trperiod(`=td(06apr2020)') fig

graph export "Graph5.png", as(png) replace

esttab e(X_balance) using "B.tex", replace title(Balance de Predictores) postfoot("\tabnotes{3}{Nota: Se muestra el balance entre la ciudad de Jena real y la ciudad de Jena sintética.}\label{B}") nomtitles


************** CHECKS **************

gen city = "" 
replace city = "SK Kiel" if _n == 1
replace city = "SK Lübeck" if _n == 2
replace city = "SK Hamburg" if _n == 3
replace city = "SK Braunschweig" if _n == 4
replace city = "SK Salzgitter" if _n == 5
replace city = "SK Wolfsburg" if _n == 6
replace city = "SK Oldenburg" if _n == 7
replace city = "SK Osnabrück" if _n == 8
replace city = "SK Bremen" if _n == 9
replace city = "SK Bremerhaven" if _n == 10
replace city = "SK Düsseldorf" if _n == 11
replace city = "SK Duisburg" if _n == 12
replace city = "SK Essen" if _n == 13
replace city = "SK Krefeld" if _n == 14
replace city = "SK Mönchengladbach" if _n == 15
replace city = "SK Mülheim a.d.Ruhr" if _n == 16
replace city = "SK Oberhausen" if _n == 17
replace city = "SK Remscheid" if _n == 18
replace city = "SK Solingen" if _n == 19
replace city = "SK Wuppertal" if _n == 20
replace city = "SK Bonn" if _n == 21
replace city = "SK Köln" if _n == 22
replace city = "SK Leverkusen" if _n == 23
replace city = "SK Bottrop" if _n == 24
replace city = "SK Gelsenkirchen" if _n == 25
replace city = "SK Münster" if _n == 26
replace city = "SK Bielefeld" if _n == 27
replace city = "SK Bochum" if _n == 28
replace city = "SK Dortmund" if _n == 29
replace city = "SK Hagen" if _n == 30
replace city = "SK Hamm" if _n == 31
replace city = "SK Herne" if _n == 32
replace city = "SK Darmstadt" if _n == 33
replace city = "SK Frankfurt am Main" if _n == 34
replace city = "SK Offenbach" if _n == 35
replace city = "SK Wiesbaden" if _n == 36
replace city = "SK Kassel" if _n == 37
replace city = "SK Koblenz" if _n == 38
replace city = "SK Trier" if _n == 39
replace city = "SK Ludwigshafen" if _n == 40
replace city = "SK Mainz" if _n == 41
replace city = "SK Stuttgart" if _n == 42
replace city = "SK Heilbronn" if _n == 43
replace city = "SK Karlsruhe" if _n == 44
replace city = "SK Heidelberg" if _n == 45
replace city = "SK Mannheim" if _n == 46
replace city = "SK Pforzheim" if _n == 47
replace city = "SK Freiburg i.Breisgau" if _n == 48
replace city = "SK Ulm" if _n == 49
replace city = "SK Ingolstadt" if _n == 50
replace city = "SK München" if _n == 51
replace city = "SK Regensburg" if _n == 52
replace city = "SK Erlangen" if _n == 53
replace city = "SK Fürth" if _n == 54
replace city = "SK Nürnberg" if _n == 55
replace city = "SK Würzburg" if _n == 56
replace city = "SK Augsburg" if _n == 57
replace city = "SK Potsdam" if _n == 58
replace city = "SK Rostock" if _n == 59
replace city = "SK Chemnitz" if _n == 60
replace city = "SK Dresden" if _n == 61
replace city = "SK Leipzig" if _n == 62
replace city = "SK Halle" if _n == 63
replace city = "SK Magdeburg" if _n == 64
replace city = "SK Erfurt" if _n == 65
replace city = "SK Jena" if _n == 66


quietly synth_runner cum_cases density educated female_prop age_female age_male dependency_old dependency_young physicians pharmacies, trunit(16053) trperiod(`=td(06apr2020)') gen_vars


matrix A =  J(66,3,.)
levelsof dist_id, local(district_levels)
local i = 0
foreach var of local district_levels {
    local ratio = post_rmspe[31*`i'+1] / pre_rmspe[31*`i'+1]
	matrix A[`i'+1,1]=`ratio' 
	matrix A[`i'+1,2]=`var'
	local i = `i' + 1
}

svmat A
gen RMSPE=A1

graph dot RMSPE if RMSPE<1.5, over(city, sort(1)) saving(menores, replace) 
graph dot RMSPE if RMSPE>=1.5, over(city, sort(1)) saving(mayores, replace) 
gr combine menores.gph mayores.gph
graph export "Graph6.png", as(png) replace

* single_treatment
single_treatment_graphs
gr combine raw effects, col(1) iscale(0.5)
graph export "Graph7.png", as(png) replace

* pval_graphs
pval_graphs
gr combine pvals pvals_std, col(1) iscale(0.5)
graph export "Graph8.png", as(png) replace



* Corrimiento de la fecha
drop pre_rmspe post_rmspe lead effect cum_cases_synth
matrix B =  J(4,2,.)
local fechas 01apr2020 06apr2020 12apr2020 20apr2020
local i = 1
foreach var of local fechas {
    quietly synth_runner cum_cases density educated female_prop age_female age_male dependency_old dependency_young physicians pharmacies, trunit(16053) trperiod(`=td("`var'")') gen_vars
    local ratio = post_rmspe / pre_rmspe
    matrix B[`i', 1] = `ratio' 
    matrix B[`i', 2] = `=td("`var'")'
    local i = `i' + 1
    drop pre_rmspe post_rmspe lead effect cum_cases_synth
}

svmat B
