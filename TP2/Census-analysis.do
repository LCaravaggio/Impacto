/* This file generates the figures in 
"Did Unilateral Divorce Laws Raise Divorce Rates?  A Reconciliation and New Results"
by Justin Wolfers
The only line you should need to change in this code to replicate these results is the next line:
Point Stata to wherever you have the data file.
*/
cd "C:\Documents and Settings\jwolfers\My Documents\justin@gsb\Friedberg paper\DataAppendix\"
pause on
clear
set mem 50m
set matsize 400

use "Census stock data", clear
keep if age>24 & age<51
set matsize 800

xi i.st i.age*i.year

* Table 3
summ divorce if year>=1960 & year<=1990 & sex==1 [w=nobs]
gen m1=r(mean)
reg divorce unilat1 black white _I* if year>1950 & year<2000 & sex==1 [w=nobs], cluster(st)
gen el1=_b[unilat1]/m1
summ divorce if year>=1960 & year<=1980 & sex==1 [w=nobs]
gen m2=r(mean)
reg divorce unilat1 black white _I* if year>1950 & year<1990 & sex==1 [w=nobs], cluster(st)
gen el2=_b[unilat1]/m2
summ evdiv if year>=1960 & year<=1980 & sex==1 [w=nobs]
gen m3=r(mean)
reg evdiv unilat1 black white _I* if year>1950 & year<1990 & sex==1 [w=nobs], cluster(st)
gen el3=_b[unilat1]/m3
summ el1 el2 el3



summ divorce if year>=1960 & year<=1990 & sex==0 [w=nobs]
gen m4=r(mean)
reg divorce unilat1 black white _I* if year>1950 & year<2000 & sex==0 [w=nobs], cluster(st)
gen el4=_b[unilat1]/m4
summ divorce if year>=1960 & year<=1980 & sex==0 [w=nobs]
gen m5=r(mean)
reg divorce unilat1 black white _I* if year>1950 & year<1990 & sex==0 [w=nobs], cluster(st)
gen el5=_b[unilat1]/m5
summ evdiv if year>=1960 & year<=1980 & sex==0 [w=nobs]
gen m6=r(mean)
reg evdiv unilat1 black white _I* if year>1950 & year<1990 & sex==0 [w=nobs], cluster(st)
gen el6=_b[unilat1]/m6
summ el4 el5 el6


* Table 4

reg divorce unil1to10 unil11pl black white _I* if year>1950 & year<2000 & sex==1 [w=nobs], cluster(st)
reg divorce unil1to10 unil11to20 unil20pl black white _I* if year>1950 & year<=2000 & sex==1 [w=nobs], cluster(st)
gen divmar=ndivorce/(nmarsp+nmarab+nseparat+ndivorce+nwidow)
reg divmar unil1to10 unil11pl black white _I* if year>1950 & year<2000 & sex==1 [w=nobs], cluster(st)
reg divmar unil1to10 unil11to20 unil20pl black white _I* if year>1950 & year<=2000 & sex==1 [w=nobs], cluster(st)
summ divmar divorce if year>1950 & year<2000 & sex==1 [w=nobs]
summ divmar divorce if year>1950 & year<=2000 & sex==1 [w=nobs]
