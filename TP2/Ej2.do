* Start Code
cd "C:\Users\lcaravaggio_mecon\Desktop\Evaluación de Impacto\TP2"
pause off
clear all
set more off
set mem 50m
set matsize 400

use "Datos - Mitze et al 2020\Data.dta"

format date %td
xtset dist_id date

*preserve
keep if type==1
keep if date >= date("27032020", "DMY")
drop if date > date("26042020", "DMY")

synth cum_cases density educated female_prop age_female age_male dependency_old dependency_young physicians pharmacies, trunit(16053) trperiod(`=td(06apr2020)') fig 
graph export "Graph5.png", as(png) replace

esttab e(X_balance) using "B.tex", replace title(Balance de Predictores) postfoot("\tabnotes{3}{Nota: Se muestra el balance entre el estado de Jena real y el estado de Jena sintético.}\label{B}") nomtitles


************** CHECKS **************
local i=1
matrix A =  J(66,3,.)
levelsof dist_id, local(district_levels)
levelsof district, local(district_names)
local i = 1
foreach var of local district_levels {
	quietly synth cum_cases density educated female_prop age_female age_male dependency_old dependency_young physicians pharmacies, trunit(`var') trperiod(`=td(06apr2020)')
    matrix A[`i',1]=e(RMSPE)
	matrix A[`i',2]=`var'
	matrix A[`i',3]= `district_names'[`i']
	local i = `i' + 1
}

svmat A
gen RMSPE=A1

graph dot RMSPE if RMSPE<75, over(A2, sort(1)) saving(menores, replace) 
graph dot RMSPE if RMSPE>75, over(A2, sort(1)) saving(mayores, replace) 
gr combine menores.gph mayores.gph 
graph export "Graph6.png", as(png) replace

*restore


