* Install Dependencies
* net install rdrobust, from(https://raw.githubusercontent.com/rdpackages/rdrobust/master/stata) replace
* net install rdlocrand, from(https://raw.githubusercontent.com/rdpackages/rdlocrand/master/stata) replace
* net install lpdensity, from(https://raw.githubusercontent.com/nppackages/lpdensity/master/stata) replace

* Start Code
cd "C:\Users\lcaravaggio_mecon\Desktop\Evaluación de Impacto\TP3"
pause off
clear all
set more off
set mem 50m
set matsize 400

****** LUDWING MILLER *******


use "Datos - Ludwig y Miller 2007\headstart.dta" 

gl Y mort_age59_related_postHS
gl R povrate60
gl c = 59.1984

gen double R = $R - $c
local lab: variable label $Y

* Histograma *
histogram $R , plotregion(fcolor(white) style(none) color(gs16)) graphregion(fcolor(white)) 
graph export "Graph1.png", as(png) replace
 
* RDD Simple * 
rdrobust $Y $R, p(0) c($c)

* RDD Sorting check *
rddensity $R, plot c($c) 
graph export "Graph2.png", as(png) replace

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
	, yline(0) vertical legend(off) ciopts(recast(rcap) color(black)) 


rdplot $Y $R if $Y <= 20, c($c) nbins(3000)	///
	graph_options(graphregion(color(white)) title("") /// 
	ytitle("`lab'") legend(off))
graph export "Graph3.png", as(png) replace

rdplot $Y $R, c($c) graph_options(graphregion(color(white)) ///
	title("") ytitle("`lab'") legend(off))
graph export "Graph4.png", as(png) replace



