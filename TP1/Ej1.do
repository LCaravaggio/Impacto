* Evaluación de Impacto - TP1
clear all

cd "C:\Users\lcaravaggio_mecon\Desktop\Evaluación de Impacto"
use jperandomizationdata.dta

set more off
tempfile results

* Prueba de diferencia de medias
local varlist zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill
matrix A = J(6,3,0)
local i=1
foreach var of local varlist {
    quietly ttest `var', by(audit)	
		 
	matrix A[`i',1] = (r(mu_1), r(mu_2), r(p))
	local i = `i' + 1
}

matrix rownames A = `varlist'
matrix colnames A = mu_1 mu_2 P-Value

esttab matrix(A) using "A.tex", replace title(Análisis de Diferencia de Medias) postfoot("\tabnotes{3}{Nota: mu_1 y mu_2 representan la media para el caso de los tratados y no tratados respectivamente. Se presenta también el P-Value de la prueba de diferencia de medias, donde p>0.05 implica medias estadísticamente equivalentes.}\label{A}") nomtitles


* Prueba de regresiones
local i=1
matrix B = J(6,2,.)
foreach var of local varlist {
    quietly reg audit `var' , robust
	local t = _b[`var']/_se[`var']
	local pval = 2*ttail(e(df_r),abs(`t'))
	local coef = _b[`var']
	matrix B[`i',1] = (`coef' , `pval')
	local i = `i' + 1
}
matrix rownames B = `varlist'
matrix colnames B = Coeficiente P-Value
esttab matrix(B) using "B.tex", replace title(Regresiones lineales) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de la estimación lineal entre las variables seleccionadas y el tratamiento. Se presenta también el P-Value de los mismos.}\label{B}") nomtitles

* Prueba F
matrix C = J(1,2,.)
quietly reg audit zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill
matrix C[1,1] = e(F)
matrix C[1,2] = Ftail(e(df_m), e(df_r), e(F))
matrix colnames C = F P-Value
esttab matrix(C) using "C.tex", replace title(Prueba F) postfoot("\tabnotes{3}{Nota: Se presenta el estadístico F de la regresión.}\label{C}") nomtitles

* Merge
merge 1:1 desaid using jperoaddata.dta

* Regresiones
matrix D = J(1,2,.)
quietly reg lndiffeall4mainancil audit, robust
local t = _b[audit]/_se[audit]
local pval = 2*ttail(e(df_r),abs(`t'))
local coef = _b[audit]
matrix D[1,1] = `coef'
matrix D[1,2] =`pval'
matrix colnames D = Coef P-Value
esttab matrix(D) using "D.tex", replace title(Regresión lineal) postfoot("\tabnotes{3}{Nota: Se presenta el coeficiente y el P-Value de la regresión simple con errores estándar robustos.}\label{D}") nomtitles

* Controles
local i=1
matrix E = J(7,2,.)
quietly reg lndiffeall4mainancil audit zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill , robust
local varlist audit zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill

foreach var of local varlist {
	local t = _b[`var']/_se[`var']
	local pval = 2*ttail(e(df_r),abs(`t'))
	local coef = _b[`var']
	matrix E[`i',1] = `coef' 
	matrix E[`i',2] =`pval'
	local i = `i' + 1
}
matrix rownames E = `varlist'
matrix colnames E = Coeficiente P-Value
esttab matrix(E) using "E.tex", replace title(Controles) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de la estimación lineal y también el P-Value de los mismos.}\label{E}") nomtitles

* Efectos Fijos por Enumerator
egen z7enumcode1 = group(z7enumcode)
quietly reg lndiffeall4mainancil audit zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill i.z7enumcode1,  robust

outreg2 using "F.tex", tex(frag) replace ctitle(Efectos Fijos por Enumerator)
*matrix F = J(7,2,.)
*local i=1
*foreach var of local varlist {
	*local t = _b[`var']/_se[`var']
	*local pval = 2*ttail(e(df_r),abs(`t'))
	*local coef = _b[`var']
	*matrix F[`i',1] = `coef' 
	*matrix F[`i',2] =`pval'
	*local i = `i' + 1
*}
*matrix rownames F = `varlist'
*matrix colnames F = Coeficiente P-Value
*esttab matrix(F) using "F.tex", replace title(Efectos Fijos por Enumerator) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de la estimación lineal incluyendo efectos fijos por enumerador y errores estándar robustos. También se presenta el P-Value de los coeficientes.}\label{F}") nomtitles



* Efectos fijos por Subdistrito
egen kecnum1 = group(kecnum)
quietly reg lndiffeall4mainancil audit zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill i.kecnum1, robust
matrix G = J(7,2,.)
local i=1
foreach var of local varlist {
	local t = _b[`var']/_se[`var']
	local pval = 2*ttail(e(df_r),abs(`t'))
	local coef = _b[`var']
	matrix G[`i',1] = `coef' 
	matrix G[`i',2] =`pval'
	local i = `i' + 1
}
matrix rownames G = `varlist'
matrix colnames G = Coeficiente P-Value
esttab matrix(G) using "G.tex", replace title(Efectos Fijos por Subdistrito) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de la estimación lineal incluyendo efectos fijos por subdistrito y errores estándar robustos. También se presenta el P-Value de los coeficientes. Por una cuestión de espacio no se reportan los coeficientes de los clusters.}\label{G}") nomtitles
*outreg2 using "G.tex", tex(frag) replace ctitle(Efectos Fijos por Subdistrito) noparen


* Efecto sustitución
rename _merge old_merge
merge 1:1 desaid using ties.dta
quietly reg lndiffeall4mainancil audit famprojhead famvilgovt, robust
matrix H = J(3,2,.)
local varlist audit famprojhead famvilgovt
local i=1
foreach var of local varlist {
	local t = _b[`var']/_se[`var']
	local pval = 2*ttail(e(df_r),abs(`t'))
	local coef = _b[`var']
	matrix H[`i',1] = `coef' 
	matrix H[`i',2] =`pval'
	local i = `i' + 1
}
matrix rownames H = `varlist'
matrix colnames H = Coeficiente P-Value
esttab matrix(H) using "H.tex", replace title(Efecto Sustitución) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de la estimación lineal con errores estándar robustos. También se presenta el P-Value de los coeficientes.}\label{H}") nomtitles


* Prueba de diferencia de medias para el tratamiento de Invitaciones
local varlist zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill
matrix I = J(6,3,0)
local i=1
foreach var of local varlist {
    quietly ttest `var', by(undfpm)	
		 
	matrix I[`i',1] = (r(mu_1), r(mu_2), r(p))
	local i = `i' + 1
}

matrix rownames I = `varlist'
matrix colnames I = mu_1 mu_2 P-Value

esttab matrix(I) using "I.tex", replace title(Análisis de Diferencia de Medias) postfoot("\tabnotes{3}{Nota: mu_1 y mu_2 representan la media para el caso de los tratados y no tratados respectivamente. Se presenta también el P-Value de la prueba de diferencia de medias, donde p>0.05 implica medias estadísticamente equivalentes.}\label{I}") nomtitles

* Controles para el tratamiento de Invitaciones
local i=1
matrix J = J(7,2,.)
quietly reg lndiffeall4mainancil undfpm zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill , robust
local varlist undfpm zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill

foreach var of local varlist {
	local t = _b[`var']/_se[`var']
	local pval = 2*ttail(e(df_r),abs(`t'))
	local coef = _b[`var']
	matrix J[`i',1] = `coef' 
	matrix J[`i',2] =`pval'
	local i = `i' + 1
}
matrix rownames J = `varlist'
matrix colnames J = Coeficiente P-Value
esttab matrix(J) using "J.tex", replace title(Controles con tratamiento Invitaciones) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de la estimación lineal con errores estándar robustos. También se presenta el P-Value de los coeficientes.}\label{J}") nomtitles

* Prueba de MDE
egen lndiffeall4mainancil_e = std(lndiffeall4mainancil)
reg lndiffeall4mainancil_e undfpm zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill , robust

global outcome "lndiffeall4mainancil_e"													
global treatment "undfpm"

local power = 0.8																
local nratio = 1																
local alpha =0.05																
local N_cov= _N																	
																				
local covariates "zkadesedyears zkadesage zpop zpercentpoorpra zdistancekec podeszhill"											
regress $outcome `covariates' 													

local res_sd = round(sqrt(`e(rss)'/`e(df_r)'),0.0001)							
																				
quietly sum $outcome if  !missing($outcome)					   					
local baseline = `r(mean)'
	
power twomeans `baseline', n(`N_cov') power(`power') sd(`res_sd') nratio(`nratio') alpha(`alpha')  table 
	

* Sample Size
quietly regress $outcome `covariates' 												    

local res_sd =round(sqrt(`e(rss)'/`e(df_r)'),0.0001)							

quietly sum $outcome if  !missing($outcome)					    				
local baseline = `r(mean)'
local sd = `r(sd)'
local effect_cov = `sd'*0.1
	
local treat = `baseline' + `effect_cov'

power twomeans `baseline' `treat', power(`power') sd(`res_sd') nratio(`nratio') alpha(`alpha') table
