* Install Dependencies
* net install rdrobust, from(https://raw.githubusercontent.com/rdpackages/rdrobust/master/stata) replace
* net install rdlocrand, from(https://raw.githubusercontent.com/rdpackages/rdlocrand/master/stata) replace
* net install lpdensity, from(https://raw.githubusercontent.com/nppackages/lpdensity/master/stata) replace
* ssc install rddensity
* ssc install coefplot

* Start Code
cd "C:\Users\PC\Desktop\Impacto\TP3"
pause off
clear all
set more off
set mem 50m
set matsize 800

****** LUDWING MILLER *******
use "Datos - Ludwig y Miller 2007\headstart.dta" 

gl Y mort_age59_related_postHS
gl R povrate60
gl c = 59.1984
gl covs  "census1960_pop census1960_pctsch1417 census1960_pctsch534 census1960_pctsch25plus census1960_pop1417 census1960_pop534 census1960_pop25plus census1960_pcturban census1960_pctblack" 

gen double R = $R - $c
local lab: variable label $Y

* Histograma *
histogram $R , plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) 
graph export "Graph1.png", as(png) replace
 
* RDD Simple * 
rdrobust $Y $R, p(0) c($c)
outreg2 using "RDD1.tex", replace tex(frag) ctitle("RDD Simple")

* RDD con covs * 
rdrobust $Y $R, p(0) c($c) covs($covs)
outreg2 using "RDD1.tex", append tex(frag) ctitle("RDD con Controles")

* RDD plot *
rdplot $Y $R if $Y <= 20, c($c) nbins(3000)	///
	graph_options(graphregion(color(white)) title("") /// 
	ytitle("`lab'") legend(off))
graph export "Graph2.png", as(png) replace

* RDD 
rdplot $Y $R, c($c) graph_options(graphregion(color(white)) ///
	title("") ytitle("`lab'") legend(off))
graph export "Graph3.png", as(png) replace

* RDD Sorting check *
rddensity $R, plot c($c) graph_opt(graphregion(color(white)) ///
	title("") ytitle("`lab'") legend(off))
graph export "Graph4.png", as(png) replace


* Cutoffs irrelevantes *
local start = 58
local end = 60
local i = `start'
local name=1
while `i' <= `end' {
    rdrobust $Y $R, p(0) c(`i')
	estimates store Reg`name'
    local i = `i' + 0.1
	local name = `name' + 1
}

coefplot (Reg1, mlcolor(black) mfcolor(black)) /// 
	(Reg1, mlcolor(black) mfcolor(black)) /// 
	(Reg2, mlcolor(black) mfcolor(black)) /// 
	(Reg3, mlcolor(black) mfcolor(black)) /// 
	(Reg4, mlcolor(black) mfcolor(black)) /// 
	(Reg5, mlcolor(black) mfcolor(black)) /// 
	(Reg6, mlcolor(black) mfcolor(black)) /// 
	(Reg7, mlcolor(black) mfcolor(black)) /// 
	(Reg8, mlcolor(black) mfcolor(black)) /// 
	(Reg9, mlcolor(black) mfcolor(black)) /// 
	(Reg10, mlcolor(black) mfcolor(black)) /// 
	(Reg11, mlcolor(black) mfcolor(black)) /// 
	(Reg12, mlcolor(black) mfcolor(black)) /// 
	(Reg13, mlcolor(black) mfcolor(black)) /// 
	(Reg14, mlcolor(black) mfcolor(black)) /// 
	(Reg15, mlcolor(black) mfcolor(black)) /// 
	(Reg16, mlcolor(black) mfcolor(black)) /// 
	(Reg17, mlcolor(black) mfcolor(black)) /// 
	(Reg18, mlcolor(black) mfcolor(black)) /// 
	(Reg19, mlcolor(black) mfcolor(black)) /// 
	(Reg20, mlcolor(black) mfcolor(black)) /// 
	, yline(0) vertical legend(off) ciopts(recast(rcap) color(black)) graphregion(color(white))
graph export "Graph5.png", as(png) replace


* Gráfico de P-Values *
rdwinselect R mort_age59_related_preHS $covs60, reps(1000) stat(ksmirnov) nwin(40) wmin(.3) wstep(.2) level(.2) plot
mat Res = r(results)
preserve
svmat Res
rename Res1 pvalues 
rename Res6 w
gen red=pval if Res3==43
twoway(scatter pval w)(scatter red w, msize(vlarge) msymbol(circle_hollow) mlwidth(medthick)), ///
	xline(1.1,lpattern(shortdash)) ytitle(p-values) xtitle(bandwidth) ///
	xlabel(0.3(.4)8.1, labsize(small)) legend(off) graphregion(color(white))
graph export "Graph6.png", as(png) replace
restore

