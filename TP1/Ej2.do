* Evaluación de Impacto - TP1
clear all
set more off

cd "C:\Users\lcaravaggio_mecon\Desktop\Evaluación de Impacto"
use dataset_donors_agg.dta

gen zipcode_n = real(zipcode)
xtset zipcode_n year

xtreg ltotamount lnwells i.year, fe i(zipcode_n) robust

local varlist lnwells
matrix K = J(2,2,.)
local i=1

local t = _b[lnwells]/_se[lnwells]
local pval = 2*ttail(e(df_r),abs(`t'))
local coef = _b[lnwells]

matrix K[1,1]=`coef'
matrix K[2,1]=`pval'

preserve
drop if highfracking != 1
xtreg ltotamount lnwells i.year, fe i(zipcode_n) robust

local t = _b[lnwells]/_se[lnwells]
local pval = 2*ttail(e(df_r),abs(`t'))
local coef = _b[lnwells]

matrix K[1,2]=`coef'
matrix K[2,2]=`pval'

restore

matrix rownames K = Coeficiente P-Value 
matrix colnames K = lnwells lnwells*
esttab matrix(K) using "K.tex", replace title(Regresiones Efectos Fijos) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de la estimación lineal con efectos fijos. Se presenta también el P-Value de los mismos. El primer par se refiere a la estimación sobre toda la base y el par indicado con asterísco a la estimación para los estados que concentran la mayor parte de la industria del fracking (highfracking = 1).}\label{K}") nomtitles

gen treatment = 0
replace treatment = 1 if year >=2005
gen did = frack*treatment

* DID
* Se conservan solo los 7 estados con más pozos de fracking
preserve
drop if highfracking!=1

lgraph ltotamountr year, by(frack) xline(2005) plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) legend(on order( 1 "No Tratados" 2 "Tratados") region(lwidth(none) color(gs16)))
graph export "Graph1.png", as(png) replace

lgraph ltotamountd year, by(frack) xline(2005) plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) legend(on order( 1 "No Tratados" 2 "Tratados") region(lwidth(none) color(gs16)))
graph export "Graph2.png", as(png) replace

xtreg ltotamount did frack treatment lnwells i.year, fe
outreg2 using "DID1.tex", replace tex(frag) ctitle("DID total")

xtreg ltotamountr did frack treatment lnwells i.year, fe
outreg2 using "DID1.tex", tex(frag) ctitle("DID Republicanos") append

xtreg ltotamountd did frack treatment lnwells i.year, fe
outreg2 using "DID1.tex", tex(frag) ctitle("DID Demócratas") append
restore

* DID 2X2
preserve
drop if highfracking!=1
drop if year!=2000 & year!=2014
lgraph ltotamountr year, by(frack) xline(2005) plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) legend(on order( 1 "No Tratados" 2 "Tratados") region(lwidth(none) color(gs16)))

xtreg ltotamount did frack treatment lnwells i.year, fe
outreg2 using "DID2.tex", replace tex(frag) ctitle("DID total")

xtreg ltotamountr did frack treatment lnwells i.year, fe
outreg2 using "DID2.tex", tex(frag) ctitle("DID Republicanos") append

xtreg ltotamountd did frack treatment lnwells i.year, fe
outreg2 using "DID2.tex", tex(frag) ctitle("DID Demócratas") append
restore

* Spillovers
preserve
gen n_ltotamount=exp(ltotamount)
gen n_ltotamountr=exp(ltotamountr)
gen n_ltotamountd=exp(ltotamountd)
gen n_lnwells=exp(lnwells)
collapse (sum) n_ltotamount n_ltotamountr n_ltotamountd n_lnwells frack, by(STATE year)
replace frack=1 if frack!=0
gen treatment = 1 if year >=2005
gen did = frack*treatment

gen ltotamount=log(n_ltotamount)
gen ltotamountr=log(n_ltotamountr)
gen ltotamountd=log(n_ltotamountd)
gen lnwells=log(n_lnwells)

egen state_id = group(STATE)
xtset state_id year

lgraph ltotamountr year, by(frack) xline(2005) plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) legend(on order( 1 "No Tratados" 2 "Tratados") region(lwidth(none) color(gs16)))

xtreg ltotamount did frack treatment lnwells i.year, fe
outreg2 using "DID3.tex", replace tex(frag) ctitle("DID total")

xtreg ltotamountr did frack treatment lnwells i.year, fe
outreg2 using "DID3.tex", tex(frag) ctitle("DID Republicanos") append

xtreg ltotamountd did frack treatment lnwells i.year, fe
outreg2 using "DID3.tex", tex(frag) ctitle("DID Demócratas") append

* Block Bootstrap
xtreg ltotamount did frack treatment lnwells i.year, fe vce(bootstrap, seed(1234))
outreg2 using "DID4.tex", replace tex(frag) ctitle("DID total")

xtreg ltotamountr did frack treatment lnwells i.year, fe vce(bootstrap, seed(1234))
outreg2 using "DID4.tex", tex(frag) ctitle("DID Republicanos") append

xtreg ltotamountd did frack treatment lnwells i.year, fe vce(bootstrap, seed(1234))
outreg2 using "DID4.tex", tex(frag) ctitle("DID Demócratas") append
restore

