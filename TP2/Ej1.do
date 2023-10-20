* Install dependencies
* ssc install matsort
* ssc install eventdd


* Start Code
cd "C:\Users\lcaravaggio_mecon\Desktop\Evaluación de Impacto\TP2"
pause off
clear all
set more off
set mem 50m
set matsize 400

****** WOLFERS *******

use "Divorce-Wolfers-AER.dta" 

egen st_n = group(st)
xtset st_n year

****** TWFE *****
xtreg div_rate unilateral time timesq neighper i.year, fe cluster(st_n) robust
outreg2 using "A.tex", replace tex(frag) ctitle("TWFE Clásico") side drop(1987.year 1988.year 1989.year 1990.year 1991.year 1992.year 1993.year 1994.year 1995.year 1996.year 1997o.year 1998o.year)


****** EVENT STUDY ******

gen timeToTreat = year - lfdivlaw
sort st_n year
list st_n year lfdivlaw timeToTreat in 1/50, noobs sepby(st_n) abbreviate(50)

eventdd div_rate time timesq neighper, timevar(timeToTreat) cluster(st) fe graph_op(ytitle(Tasa de Divorcios) plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) xlabel(-10(5)10)) accum lags(10) leads(10)
graph export "Graph1.png", as(png) replace

eventdd div_rate time timesq neighper, timevar(timeToTreat) cluster(st) fe graph_op(ytitle(Tasa de Divorcios) plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) xlabel(-10(5)20)) accum lags(20) leads(10)
graph export "Graph2.png", as(png) replace

****** STEVENSON Y WOLFERS *******
* ssc install csdid 
* ssc install drdid

clear all
cd "C:\Users\lcaravaggio_mecon\Desktop\Evaluación de Impacto\TP2"
set more off
set mem 50m
set matsize 400
use "sw_nofault_divorce.dta"
xtset stfips year

replace _nfd=0 if _nfd==.


* Homicidios
csdid asmrh, ivar(stfips) time(year) gvar(_nfd) method(dripw) window(-10 20)
estat event, window(-10 20)
csdid_plot , style(rbar) ytitle(Tasa de Homicidios)
graph export "Graph3.png", as(png) replace
estat simple, window(-10 20)

* Suicidios
csdid asmrs, ivar(stfips) time(year) gvar(_nfd) method(dripw) window(-10 20)
estat event, window(-10 20)
csdid_plot , style(rbar) ytitle(Tasa de Suicidios) 
graph export "Graph4.png", as(png) replace
estat simple, window(-10 20)
