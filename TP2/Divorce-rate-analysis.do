/* This file generates the results in 
"Did Unilateral Divorce Laws Raise Divorce Rates?  A Reconciliation and New Results"
by Justin Wolfers
The only line you should need to change in this code to replicate these results is the next line:
Point Stata to wherever you have the data file.
*/
cd "C:\Documents and Settings\jwolfers\My Documents\justin@gsb\Friedberg paper\DataAppendix\"
pause off
clear
set mem 50m
set matsize 400
use "Divorce-Wolfers-AER.dta" 

* Table 1: Replicating Friedberg

xi: reg div_rate unilateral divx* i.st i.year if year>1967 & year<1989 [w=stpop]
testparm _Iy*
testparm _Is*

xi i.st i.st*time i.year
reg div_rate unilateral divx* _I* if year>1967 & year<1989 [w=stpop]
testparm _Iy*
testparm _Ist_*
testparm _IstX*

xi i.st i.st*time i.st*timesq i.year
reg div_rate unilateral divx* _I* if year>1967 & year<1989 [w=stpop]
testparm _Iy*
testparm _Ist_*
testparm _IstXtime_*
testparm _IstXtimea*


* Table 2
xi i.years_unilateral i.st i.year
reg div_rate _I* if year>1955 & year<1989 [w=stpop]
testparm _Iyear_*
testparm _Ist_*

xi i.years_unilateral i.st*time i.year
reg div_rate _I* if year>1955 & year<1989 [w=stpop]
testparm _Iyear_*
testparm _Ist_*
testparm _IstXtime_*

xi i.years_unilateral i.st*time i.st*timesq i.year
reg div_rate _I*  if year>1955 & year<1989 [w=stpop]
testparm _Iyear_*
testparm _Ist_*
testparm _IstXtime_*
testparm _IstXtimea*

* Table 3 uses the census data. See CensusAnalysis.do

* Table 4, Panel A

gen div_mar=div_rate/married_annual /* Note that the NBER working paper version of the paper uses marrnber, which uses census data through to 1990, and CPS data for the 2000 estimates */
la var div_mar "Divorces per thousand married adults" 
summ div_rate div_mar married_annual [w=stpop] if year>1955 & year<1989
summ div_rate div_mar married_annual [w=stpop] if year>1955 & year<1999

xi: reg div_rate i.years_unilateral i.st i.year if year<1989 [w=stpop]
xi: reg div_rate i.years_unilateral_long i.st i.year if year<1999 [w=stpop]
xi: reg div_mar i.years_unilateral i.st i.year if year<1989 [w=stpop]
xi: reg div_mar i.years_unilateral_long i.st i.year if year<1999 [w=stpop]


* Table 5
xi: reg div_rate i.years_unilateral_long i.st i.year if year<1999 [w=stpop]
xi: reg div_rate neighper i.years_unilateral_long i.st i.year if year<1999 [w=stpop]
gen evdiv50_trend=evdiv50*time
xi: reg div_rate evdiv50_trend i.years_unilateral_long i.st i.year if year<1999 [w=stpop]
xi: reg div_rate i.years_unilateral_long i.year*evdiv50 i.st if year<1999 [w=stpop]
xi: reg div_rate i.years_unilateral_long i.st i.year if year<1999 & reform==1 [w=stpop]


* Appendix A

xi: reg div_rate unilateral i.st i.year if year>1955 & year<1989 [w=stpop]
testparm _Iy*
testparm _Is*

xi i.st i.st*time i.year
reg div_rate unilateral  _I* if year>1955 & year<1989 [w=stpop]
testparm _Iy*
testparm _Ist_*
testparm _IstX*

xi i.st i.st*time i.st*timesq i.year
reg div_rate unilateral _I* if year>1955 & year<1989 [w=stpop]
testparm _Iy*
testparm _Ist_*
testparm _IstXtime_*
testparm _IstXtimea*



