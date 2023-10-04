/* This file generates the figures in 
"Did Unilateral Divorce Laws Raise Divorce Rates?  A Reconciliation and New Results"
by Justin Wolfers
The only line you should need to change in this code to replicate these results is the next line:
Point Stata to wherever you have the data file.
*/
cd "C:\Documents and Settings\jwolfers\My Documents\justin@gsb\Friedberg paper\DataAppendix\"
pause off
set more off
clear
set mem 50m
set matsize 400
use "Divorce-Wolfers-AER.dta" 

* Figure 1
gen lfreform=lfdivlaw>=1968 & lfdivlaw<=1988
xi: reg div_rate i.year*i.lfreform [w=stpop]
predict divreform if reform==1
predict divcontrol if reform==0
tomode divreform, by(year) replace /* You will need to download the tomode program*/
tomode divcontrol, by(year) replace
gen diff=divreform-divcontrol
gen friedbergsample=0.2 if year>=1968 & year<=1988
egen tagyear=tag(year)
#delimit ;
twoway
	(line divreform year, clcolor(black) clwidth(thick))
	(line divcontrol year, clcolor(gray) clwidth(thick))
	(line diff year, clcolor(black) clpattern(dash))
	(line friedbergsample year, clcolor(black))
	if tagyear==1,
	title("Average Divorce Rate: Reform States and Controls")
	xtitle("Year")
	xlabel(1956(2)1998, angle(forty_five))
	xmlabel(1956(1)1999, nolabels)
	xline(1969 1977, lcolor(black))
	ytitle("Divorce Rate" "Divorces per thousand people per year")
	ylabel(0(1)7, angle(horizontal))
	text(7 1973 "Reform period")
	text(6.4 1973 "28 states adopted" "unilateral divorce", size(small))
	text(0.5 1983 "Friedberg's Sample")
	legend(
		order(
			1 "Reform States" 
			2 "Control States" 
			3 "Difference in divorce rates: Reform states less controls"
			)
		rowgap(0)
		rows(3)
		pos(12))
	xsize(10) ysize(7.5)
;
#delimit cr
pause




* Figure 3
xi i.st i.year i.years_unilateral
reg div_rate _I* if year>1955 & year<1989 [w=stpop]
gen effect1=0
for num 2/9: replace effect1=_b[_Iyears_uni_X] if _Iyears_uni_X==1
for any lower1 upper1: gen X=.
for X in num 2/9: replace upper1=_b[_Iyears_uni_X]+1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1
for X in num 2/9: replace lower1=_b[_Iyears_uni_X]-1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1

xi i.years_unilateral i.st*time i.year
reg div_rate time _I* if year>1955 & year<1989 [w=stpop]
testparm _Iy*
testparm _Ist_*
testparm _IstX*
gen effect2=0
for num 2/9: replace effect2=_b[_Iyears_uni_X] if _Iyears_uni_X==1
for any lower2 upper2: gen X=0 if years_unilateral<0
for X in num 2/9: replace upper2=_b[_Iyears_uni_X]+1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1
for X in num 2/9: replace lower2=_b[_Iyears_uni_X]-1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1

xi i.years_unilateral i.st*time i.st*timesq i.year
reg div_rate time timesq _I*  if year>1955 & year<1989 [w=stpop]
gen effect3=0
for num 2/9: replace effect3=_b[_Iyears_uni_X] if _Iyears_uni_X==1
for any lower3 upper3: gen X=.
for X in num 2/9: replace upper3=_b[_Iyears_uni_X]+1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1
for X in num 2/9: replace lower3=_b[_Iyears_uni_X]-1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1

replace years_unilateral=-3 if years_unilateral==-99 & uniform()>0.5
replace years_unilateral=-1 if years_unilateral==-99 
#delimit ;
twoway 
	(rarea lower2 upper2 years_unilateral, sort blcolor(ltbluishgray) bfcolor(ltbluishgray)) 
	(connected effect2 years_unilateral, sort msymbol(diamond) msize(large) clcolor(black) clwidth(medthick)) 
	(connected effect1 years_unilateral, sort msymbol(triangle) msize(medlarge) clcolor(dkgreen) clwidth(medthick)) 
	(connected effect3 years_unilateral, sort msymbol(square) msize(medlarge) mcolor(navy) clcolor(navy) clwidth(medthick))
	, 
	ytitle("Regression coefficients: Effect on Divorce Rate" "Annual divorces per thousand people") 
	ylabel(-0.6(0.2)0.6, angle(horizontal) format(%9.1f)) 
	yline(0, lwidth(medium) lcolor(black)) 
	xtitle(Years since (until) adoption of Unilateral Divorce Laws) 
	xlabel(-3 "(3-4)" -1 "(1-2)" 1 "1-2" 3 "3-4" 5 "5-6" 7 "7-8" 9 "9-10" 11 "11-12" 13 "13-14" 15 ">=15") 
	title(Response of Divorce Rate to Unilateral Divorce Laws) 
	subtitle(Sensitivity to controlling for pre-existing state trends) 
	note("All regressions control for state and year fixed effects.  For details, see table 2.") 
	legend(order(2 "State Trends" 1 "95% confidence interval - State Trends" 3 "No state trends" 4 "Quadratic state trends"))
;
#delimit cr
replace years_unilateral=-99 if years_unilateral<0
pause
drop lower* upper* effect*




* Figure 4
* Top Panel: No state trends
for X in any gruber_yrs friedberg_yrs johnson_yrs mechoulan_yrs ellmanlohr1_yrs ellmanlohr2_yrs brinigbuckley_yrs nakonezny_yrs \ Y in any jg lf jm sm el1 el2 bb nz: gen Y=X \ gen Yh=0 if Y<0 \ xi: reg div_rate i.Y i.st i.year if year>1955 & year<1989 [w=stpop] \ for Z in num 2/9: replace Yh=_b[_IY_Z] if _IY_Z==1

xi i.years_unilateral i.st i.year
reg div_rate _I* if year>1955 & year<1989 [w=stpop]
gen effect1=0
for num 2/9: replace effect1=_b[_Iyears_uni_X] if _Iyears_uni_X==1
for any lower1 upper1: gen X=0 if years_unilateral<0
for X in num 2/9: replace upper1=_b[_Iyears_uni_X]+1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1
for X in num 2/9: replace lower1=_b[_Iyears_uni_X]-1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1

* Lower Panel: Including state trends
for Y in any jg lf jm sm el1 el2 bb nz: gen Yh2=0 if Y<0 \ xi: reg div_rate i.Y i.st*time i.year if year>1955 & year<1989 [w=stpop] \ for Z in num 2/9: replace Yh2=_b[_IY_Z] if _IY_Z==1

xi i.years_unilateral i.st*time i.year
reg div_rate _I* if year>1955 & year<1989 [w=stpop]
gen effect2=0
for num 2/9: replace effect2=_b[_Iyears_uni_X] if _Iyears_uni_X==1
for any lower2 upper2: gen X=0 if years_unilateral<0
for X in num 2/9: replace upper2=_b[_Iyears_uni_X]+1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1
for X in num 2/9: replace lower2=_b[_Iyears_uni_X]-1.96*_se[_Iyears_uni_X] if _Iyears_uni_X==1

replace years_unilateral=-1 if years_unilateral<0
replace years_unilateral=-3 if years_unilateral==-1 & uniform()<.5

for X in any gruber_yrs friedberg_yrs johnson_yrs mechoulan_yrs ellmanlohr1_yrs ellmanlohr2_yrs brinigbuckley_yrs nakonezny_yrs \ Y in any jg lf jm sm el1 el2 bb nz: gen Xh=Yh \ gen Xh2=Yh2 \ replace X=-1 if X<0

#delimit ;
twoway 
	(rarea lower1 upper1 years_unilateral, sort blcolor(ltbluishgray) bfcolor(ltbluishgray))  
	(line gruber_yrsh gruber_yrs, sort clcolor(black) clpat(shortdash))  
	(connected johnson_yrsh johnson_yrs, sort msymbol(triangle) clcolor(brown) mcolor(brown) clwidth(medium)) 
	(line mechoulan_yrsh mechoulan_yrs, sort clcolor(blue) clpat(longdash)) 
	(connected ellmanlohr1_yrsh ellmanlohr1_yrs, sort msymbol(circle) clcolor(green)) 
	(connected ellmanlohr2_yrsh ellmanlohr2_yrs, sort msymbol(x) clcolor(pink) mcolor(pink)) 
	(connected brinigbuckley_yrsh brinigbuckley_yrs, sort msymbol(plus) mcolor(purple) clcolor(purple)) 
	(line nakonezny_yrsh nakonezny_yrs, sort clcolor(gray))
	, 
	legend(off) 
	ylabel(-0.8(0.2)0.8, angle(horizontal) format(%9.1f)) 
	yline(0, lwidth(medium) lcolor(black))  
	xlabel(-3 "(3-4)" -1 "(1-2)" 1 "1-2" 3 "3-4" 5 "5-6" 7 "7-8" 9 "9-10" 11 "11-12" 13 "13-14" 15 ">=15") 
	title(Controlling for state and year fixed effects, ring(0)) 
	ytitle("",size(zero)) 
	xtitle("", size(zero))
	name(fig4a, replace)  
;

twoway 
	(rarea lower2 upper2 years_unilateral, sort blcolor(ltbluishgray) bfcolor(ltbluishgray))  
	(line gruber_yrsh2 gruber_yrs, sort clcolor(black) clpat(shortdash))  
	(connected johnson_yrsh2 johnson_yrs, sort msymbol(triangle) clcolor(brown) mcolor(brown) clwidth(medium)) 
	(line mechoulan_yrsh2 mechoulan_yrs, sort clcolor(blue) clpat(longdash)) 
	(connected ellmanlohr1_yrsh2 ellmanlohr1_yrs, sort msymbol(circle) clcolor(green)) 
	(connected ellmanlohr2_yrsh2 ellmanlohr2_yrs, sort msymbol(x) clcolor(pink) mcolor(pink)) 
	(connected brinigbuckley_yrsh2 brinigbuckley_yrs, sort msymbol(plus) mcolor(purple) clcolor(purple))
	(line nakonezny_yrsh2 nakonezny_yrs, sort clcolor(gray))
	,
	legend(
		order(
			2 "Gruber (2004)" 
			3 "Johnson and Mazingo (2000)" 
			4 "Mechoulan (2001)" 
			5 "Ellman and Lohr (1998a)" 
			6 "Ellman and Lohr (1998b)" 
			7 "Brinig and Buckley (1998)" 
			8 "Nakonezny Rodgers & Shull (1995)" 
			1 "Friedberg (1998): 95% interval"
			)
			cols(2) colgap(0) rowgap(0) keygap(0) colfirst ring(0) region(fcolor(none) margin(zero) lcolor(none)) size(small) )
	ylabel(-0.8(0.2)0.8, angle(horizontal) format(%9.1f)) 
	yline(0, lwidth(medium) lcolor(black))  
	ytitle("",size(zero)) 
	xlabel(-3 "(3-4)" -1 "(1-2)" 1 "1-2" 3 "3-4" 5 "5-6" 7 "7-8" 9 "9-10" 11 "11-12" 13 "13-14" 15 ">=15") 
	title(Also controlling for pre-existing state trends, ring(0))
	xtitle("", size(zero))
	name(fig4b, replace)
;

graph combine fig4a fig4b,
	colfirst 
	rows(2) 
	ycommon 
/*	xcommon */
	imargin(tiny) 
	title(Response of Divorce Rate to Divorce Law Reform, size(medlarge)) 
	subtitle(Sensitivity to different coding of family law regime) 
	commonscheme 
	ysize(10) xsize(9) 
	l2title("Regression coefficients: Effect on divorce rate", size(medsmall)) 
	l1title("(Annual divorces per thousand people)", size(small)) 
	b1title("Years since (until) adoption of Unilateral or No-Fault Divorce Laws", size(medsmall))  
; 

#delimit cr
replace years_unilateral=-99 if years_unilateral<0
pause




* Figure 5
xi: reg div_rate i.st i.year if year<1989 [w=stpop]
predict dresjw3a, res
gen dreslf3a=dresjw3a if year>1967 & year<1989
gen dreslft3a=-.072*time+0.447*(1988-1970)/(1988-1968)
replace dreslft3a=. if year<1968 | year>1988

la var dresjw3a "Divorces | State & Year FE"
la var dreslf3a "Friedberg's short sample"
la var dreslft3a "Fitted state-specific trend"
reg dresjw3a time if year<1970 & st=="CA"
predict dresjw3ah

xi: reg div_rate i.years_unilateral i.st i.year if year<1989 [w=stpop]
for var _Iyears_uni_*: replace X=0
predict dresjw3b, res

gen unilateral_real=unilateral
xi: reg div_rate unilateral i.st*time i.year if year<1989 & year>1967 [w=stpop]
replace unilateral=0
predict dreslf3b, res
replace unilateral=unilateral_real
drop unilateral_real
replace dreslf3b=. if year<1968 | year>1989
la var dresjw3b "Wolfers: less pre-reform trend"
la var dreslf3b "Friedberg: less declining trend"

#delimit ;
twoway 
	(line dreslf3a year, sort clcolor(gray) clwidth(vvthick)) 
	(line dresjw3a year, sort clcolor(red) clwidth(medium)) 
	(line dreslft3a year, sort clcolor(gray) clpat(longdash)) 
	(line dresjw3ah year if year<1970, sort clcolor(purple) clpat(shortdash) clwidth(medthick)) 
	if st=="CA" & year>1949 & year<1989
	, 
	ytitle("Divorce Rate, relative to the US" "Deviation from California's Long Run Average") 
	ylabel(-1(1)2, angle(horizontal)) 
	xlabel(1950(10)1990)
	xtitle("") 
	xline(1969, lcolor(black) lpat(dash)) 
	note("                                 Unilateral divorce law adopted " , size(medium) position(6) ring(0) justification(right)) 
	legend(
		colfirst 
		order(
			2 "Divorces | state & year effects" 
			1 "Friedberg's short sample" 
			3 "Friedberg's fitted trend" 
			4 "Actual pre-existing trend"
			) 
			position(11) ring(0)
		 )
	title("Divorce rate relative to state and year fixed effects") 
	name(fig5a, replace) 
;

twoway 
		(line dresjw3b year, sort clcolor(red) clwidth(medthin)) 
		(line dreslf3b year, sort clcolor(gray) clwidth(thick))
		if st=="CA" & year>1949 & year<1989
		, 
		ytitle("Divorce Rate, relative to the US" "Deviation from California's fitted trend") 
		ylabel(-1(1)2, angle(horizontal)) 
		yline(0, lcolor(black)) 
		xlabel(1950(10)1990) 
		xline(1969, lcolor(black) lpattern(dash)) 
		xtitle("") 
		note("                                 Unilateral divorce law adopted " , size(medium) position(6) ring(0) justification(right)) 
		legend(
			colfirst 
			nostack 
			rows(2) 
			order(
				2 "Divorce relative to Friedberg's fitted trend" 
				1 "Divorce relative to pre-existing trend") 
			position(11) ring(0)
			) 
		title("Divorce rate relative to fitted trend") 
		subtitle("(and state and year fixed effects)") 
		name(fig5b, replace)
;

graph combine fig5a fig5b,
	cols(1) 
	imargin(tiny) 
	title(California's Divorce Rate) 
	ysize(10) xsize(7.5)
;
#delimit cr
pause




* Figure 6
xi: reg div_rate i.years_unilateral i.st*time i.year if year<1989 [w=stpop]
for var _Iyears_uni_*: replace X=0
for var _Iyear*: replace X=0
predict div_ratejw4
sort st year
quietly by st: gen trendjw=div_ratejw4-div_ratejw4[_n-1] if year==1979

gen lfchtemp=unilateral
xi: reg div_rate lfchtemp i.st*time i.year if year<1989 [w=stpop]
replace lfchtemp=0
for var _Iyear*: replace X=0
predict div_ratelf4
sort st year
quietly by st: gen trendlf=div_ratelf4-div_ratelf4[_n-1] if year==1979

gen str7 ref="Reform" if lfdivlaw>1967 & lfdivlaw<2000
replace ref="Control" if lfdivlaw<1967 | lfdivlaw>1999

la var trendjw "State time trends: Wolfers"
la var trendlf "State time trends: Friedberg"

gen trendlft=trendlf if ref=="Reform"
gen trendlfc=trendlf if ref=="Control"

list trendjw trendlf if st=="NV" & year==1979

#delimit ;
twoway 
	(scatter trendlft trendjw, sort msymbol(lgx) mcolor(cranberry) mlabel(st) mlabcolor(cranberry)) 
	(scatter trendlfc trendjw, sort msymbol(circle_hollow) msize(large) mcolor(blue) mlabel(st) mlabcolor(blue)) 
	(line trendjw trendjw, sort clcolor(black)) 
	if year==1979 & st~="NV"
	, 
	ytitle("Estimated state time trends: Friedberg" "Table 1, Col. 2 specification", size(medium)) 
	ylabel(0(.05).2, angle(horizontal)) 
	xtitle("Estimated state time trends: Wolfers" "Table 2, Col. 2 specification", size(medium)) 
	xlabel(0(.05).2) 
	title(Estimates of State-Specific Linear Time Trends) 
	subtitle(Each point represents a regression-estimated state*time coefficient) 
	caption(Nevada off-scale (-0.60, -0.63). , size(small)) 
	note("Population-weighted least squares regression; 1956-1988.", size(medsmall)) 
	legend(
		rows(3) 
		order(
			1 "States that reformed divorce laws" 
			2 "Control states" 
			3 "45-degree line"
			) 
		size(medlarge)
		region(fcolor(none))
		keygap(0)
		position(10) ring(0)
		) 
		graphregion(margin(medsmall))
;
#delimit cr
drop lfchtemp



* Figure 7: Aggregate effects
egen uspopch6=sum(stpop), by(year)
gen evdiv50_trend=evdiv50*time
xi: reg div_rate evdiv50_trend  i.years_unilateral_long i.st i.year if year<1999 [w=stpop]
predict dhatch6r
for var _Iyears_uni_*: replace X=0
predict dhatch6c

egen ch6r=sum(stpop*dhatch6r), by(year)
egen ch6c=sum(stpop*dhatch6c), by(year)

replace ch6r=ch6r/uspopch6
replace ch6c=ch6c/uspopch6

la var ch6r "Actual Divorce Rate"
la var ch6c "Counterfactual: No Reform"

#delimit ;
twoway
	(line ch6r year, clcolor(black))
	(line ch6c year, clcolor(gray) clpattern(longdash))
	if st=="CA" & year>1955 & year<1999
	,
	title("US Divorce Rate: Effect of Divorce Laws")
	xtitle("Year")
	xlabel(1955(5)2000)
	xmlabel(1955(1)2000, nolabels)
	ytitle("Divorce Rate" "Annual divorces per thousand people")
	ylabel(0(1)6, angle(horizontal))
	legend(
		order(1 "Actual Divorce Rate"
			2 "Counterfactual: No reform"
			)
		ring(0) pos(12)
		)
	note("Figure is constructed based on the specification in column 3 of table 5")
	xsize(10) ysize(7.5)	
;
#delimit cr
pause
