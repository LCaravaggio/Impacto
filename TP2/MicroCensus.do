clear
set mem 1100m
cd "C:\Documents and Settings\jwolfers\My Documents\justin@gsb\Friedberg paper\DataAppendix"

infix  year       1-  2 statefip   3-  4 perwt      5-  8 age        9- 11 sex       12- 12 raceg     13- 13 rachist   14- 15 marst     16- 16 marrno    17- 17 bplg      18- 20 using jwolf045.dat

label var year "Census year"
label var statefip "State (FIPS code)"
label var perwt "Person weight"
label var age "Age"
label var sex "Sex"
label var raceg "Race -- General"
label var rachist "Race -- Historically Compatible"
label var marst "Marital status"
label var marrno "Times married"
label var bplg "Birthplace -- General"
label define yearlbl 85 "1850"
label define yearlbl 86 "1860", add
label define yearlbl 87 "1870", add
label define yearlbl 88 "1880", add
label define yearlbl 90 "1900", add
label define yearlbl 91 "1910", add
label define yearlbl 92 "1920", add
label define yearlbl 93 "1930", add
label define yearlbl 94 "1940", add
label define yearlbl 95 "1950", add
label define yearlbl 96 "1960", add
label define yearlbl 97 "1970", add
label define yearlbl 98 "1980", add
label define yearlbl 99 "1990", add
label define yearlbl 00 "2000", add
label define yearlbl 01 "2001", add
label define yearlbl 02 "2002", add
label define yearlbl 03 "2003", add
label define yearlbl 04 "2004", add
label values year yearlbl

label define statefiplbl 1 "Alabama"
label define statefiplbl 2 "Alaska", add
label define statefiplbl 4 "Arizona", add
label define statefiplbl 5 "Arkansas", add
label define statefiplbl 6 "California", add
label define statefiplbl 8 "Colorado", add
label define statefiplbl 9 "Connecticut", add
label define statefiplbl 10 "Delaware", add
label define statefiplbl 11 "District of Columbia", add
label define statefiplbl 12 "Florida", add
label define statefiplbl 13 "Georgia", add
label define statefiplbl 15 "Hawaii", add
label define statefiplbl 16 "Idaho", add
label define statefiplbl 17 "Illinois", add
label define statefiplbl 18 "Indiana", add
label define statefiplbl 19 "Iowa", add
label define statefiplbl 20 "Kansas", add
label define statefiplbl 21 "Kentucky", add
label define statefiplbl 22 "Louisiana", add
label define statefiplbl 23 "Maine", add
label define statefiplbl 24 "Maryland", add
label define statefiplbl 25 "Massachusetts", add
label define statefiplbl 26 "Michigan", add
label define statefiplbl 27 "Minnesota", add
label define statefiplbl 28 "Mississippi", add
label define statefiplbl 29 "Missouri", add
label define statefiplbl 30 "Montana", add
label define statefiplbl 31 "Nebraska", add
label define statefiplbl 32 "Nevada", add
label define statefiplbl 33 "New Hampshire", add
label define statefiplbl 34 "New Jersey", add
label define statefiplbl 35 "New Mexico", add
label define statefiplbl 36 "New York", add
label define statefiplbl 37 "North Carolina", add
label define statefiplbl 38 "North Dakota", add
label define statefiplbl 39 "Ohio", add
label define statefiplbl 40 "Oklahoma", add
label define statefiplbl 41 "Oregon", add
label define statefiplbl 42 "Pennsylvania", add
label define statefiplbl 44 "Rhode island", add
label define statefiplbl 45 "South Carolina", add
label define statefiplbl 46 "South Dakota", add
label define statefiplbl 47 "Tennessee", add
label define statefiplbl 48 "Texas", add
label define statefiplbl 49 "Utah", add
label define statefiplbl 50 "Vermont", add
label define statefiplbl 51 "Virginia", add
label define statefiplbl 53 "Washington", add
label define statefiplbl 54 "West Virginia", add
label define statefiplbl 55 "Wisconsin", add
label define statefiplbl 56 "Wyoming", add
label define statefiplbl 61 "Maine-New Hampshire-Vermont", add
label define statefiplbl 62 "Massachusetts-Rhode Island", add
label define statefiplbl 63 "Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota", add
label define statefiplbl 64 "Maryland-Delaware", add
label define statefiplbl 65 "Montana-Idaho-Wyoming", add
label define statefiplbl 66 "Utah-Nevada", add
label define statefiplbl 67 "Arizona-New Mexico", add
label define statefiplbl 68 "Alaska-Hawaii", add
label define statefiplbl 94 "Indian Territory", add
label define statefiplbl 97 "Military/Mil. Reservation", add
label define statefiplbl 99 "State not identified", add
label values statefip statefiplbl

label values age agelbl

label define sexlbl 1 "Male"
label define sexlbl 2 "Female", add
label values sex sexlbl

label define raceglbl 1 "White"
label define raceglbl 2 "Black/Negro", add
label define raceglbl 3 "American Indian or Alaska Native", add
label define raceglbl 4 "Chinese", add
label define raceglbl 5 "Japanese", add
label define raceglbl 6 "Other Asian or Pacific Islander", add
label define raceglbl 7 "Other race, nec", add
label define raceglbl 8 "Two major races", add
label define raceglbl 9 "Three or more major races", add
label values raceg raceglbl

label define rachistlbl 10 "White"
label define rachistlbl 11 "Other white group", add
label define rachistlbl 12 "Hispanic 'other race' (2000 & ACS)", add
label define rachistlbl 20 "Black/African American", add
label define rachistlbl 21 "Mulatto", add
label define rachistlbl 30 "American Indian", add
label define rachistlbl 31 "Alaska Native", add
label define rachistlbl 32 "American Indian/Alaska Native, n.s.", add
label define rachistlbl 40 "Asian Indian", add
label define rachistlbl 41 "Chinese", add
label define rachistlbl 42 "Filipino", add
label define rachistlbl 43 "Japanese", add
label define rachistlbl 44 "Korean", add
label define rachistlbl 45 "Other Asian group(s)", add
label define rachistlbl 46 "Hawaiian", add
label define rachistlbl 47 "Other Pacific Islander group(s)", add
label define rachistlbl 48 "Asian and Pacific Islander", add
label define rachistlbl 50 "Non-Hispanic 'other race' (2000 & ACS)", add
label values rachist rachistlbl

label define marstlbl 1 "Married, spouse present"
label define marstlbl 2 "Married, spouse absent", add
label define marstlbl 3 "Separated", add
label define marstlbl 4 "Divorced", add
label define marstlbl 5 "Widowed", add
label define marstlbl 6 "Never married/single (N/A)", add
label values marst marstlbl

label define marrnolbl 0 "Not Applicable"
label define marrnolbl 1 "Married once", add
label define marrnolbl 2 "Married twice (or more)", add
label define marrnolbl 3 "Three times", add
label define marrnolbl 4 "Four times", add
label define marrnolbl 5 "Five times", add
label define marrnolbl 6 "Six times", add
label define marrnolbl 7 "Unknown", add
label define marrnolbl 8 "Illegible", add
label define marrnolbl 9 "Missing", add
label values marrno marrnolbl

label define bplglbl 001 "Alabama"
label define bplglbl 002 "Alaska", add
label define bplglbl 004 "Arizona", add
label define bplglbl 005 "Arkansas", add
label define bplglbl 006 "California", add
label define bplglbl 008 "Colorado", add
label define bplglbl 009 "Connecticut", add
label define bplglbl 010 "Delaware", add
label define bplglbl 011 "District of Columbia", add
label define bplglbl 012 "Florida", add
label define bplglbl 013 "Georgia", add
label define bplglbl 015 "Hawaii", add
label define bplglbl 016 "Idaho", add
label define bplglbl 017 "Illinois", add
label define bplglbl 018 "Indiana", add
label define bplglbl 019 "Iowa", add
label define bplglbl 020 "Kansas", add
label define bplglbl 021 "Kentucky", add
label define bplglbl 022 "Louisiana", add
label define bplglbl 023 "Maine", add
label define bplglbl 024 "Maryland", add
label define bplglbl 025 "Massachusetts", add
label define bplglbl 026 "Michigan", add
label define bplglbl 027 "Minnesota", add
label define bplglbl 028 "Mississippi", add
label define bplglbl 029 "Missouri", add
label define bplglbl 030 "Montana", add
label define bplglbl 031 "Nebraska", add
label define bplglbl 032 "Nevada", add
label define bplglbl 033 "New Hampshire", add
label define bplglbl 034 "New Jersey", add
label define bplglbl 035 "New Mexico", add
label define bplglbl 036 "New York", add
label define bplglbl 037 "North Carolina", add
label define bplglbl 038 "North Dakota", add
label define bplglbl 039 "Ohio", add
label define bplglbl 040 "Oklahoma", add
label define bplglbl 041 "Oregon", add
label define bplglbl 042 "Pennsylvania", add
label define bplglbl 044 "Rhode Island", add
label define bplglbl 045 "South Carolina", add
label define bplglbl 046 "South Dakota", add
label define bplglbl 047 "Tennessee", add
label define bplglbl 048 "Texas", add
label define bplglbl 049 "Utah", add
label define bplglbl 050 "Vermont", add
label define bplglbl 051 "Virginia", add
label define bplglbl 053 "Washington", add
label define bplglbl 054 "West Virginia", add
label define bplglbl 055 "Wisconsin", add
label define bplglbl 056 "Wyoming", add
label define bplglbl 090 "Native American", add
label define bplglbl 099 "United States, ns", add
label define bplglbl 100 "American Samoa", add
label define bplglbl 105 "Guam", add
label define bplglbl 110 "Puerto Rico", add
label define bplglbl 115 "U.S. Virgin Islands", add
label define bplglbl 120 "Other US Possessions", add
label define bplglbl 150 "Canada", add
label define bplglbl 155 "St. Pierre and Miquelon", add
label define bplglbl 160 "Atlantic Islands", add
label define bplglbl 199 "North America, ns", add
label define bplglbl 200 "Mexico", add
label define bplglbl 210 "Central America", add
label define bplglbl 250 "Cuba", add
label define bplglbl 260 "West Indies", add
label define bplglbl 299 "Americas, ns", add
label define bplglbl 300 "SOUTH AMERICA", add
label define bplglbl 400 "Denmark", add
label define bplglbl 401 "Finland", add
label define bplglbl 402 "Iceland", add
label define bplglbl 403 "Lapland, n.s.", add
label define bplglbl 404 "Norway", add
label define bplglbl 405 "Sweden", add
label define bplglbl 410 "England", add
label define bplglbl 411 "Scotland", add
label define bplglbl 412 "Wales", add
label define bplglbl 413 "United Kingdom, ns", add
label define bplglbl 414 "Ireland", add
label define bplglbl 419 "Northern Europe, ns", add
label define bplglbl 420 "Belgium", add
label define bplglbl 421 "France", add
label define bplglbl 422 "Liechtenstein", add
label define bplglbl 423 "Luxembourg", add
label define bplglbl 424 "Monaco", add
label define bplglbl 425 "Netherlands", add
label define bplglbl 426 "Switerland", add
label define bplglbl 429 "Western Europe, ns", add
label define bplglbl 430 "Albania", add
label define bplglbl 431 "Andorra", add
label define bplglbl 432 "Gibraltar", add
label define bplglbl 433 "Greece", add
label define bplglbl 434 "Italy", add
label define bplglbl 435 "Malta", add
label define bplglbl 436 "Portugal", add
label define bplglbl 437 "San Marino", add
label define bplglbl 438 "Spain", add
label define bplglbl 439 "Vatican City", add
label define bplglbl 440 "Southern Europe, ns", add
label define bplglbl 450 "Austria", add
label define bplglbl 451 "Bulgaria", add
label define bplglbl 452 "Czechoslovakia", add
label define bplglbl 453 "Germany", add
label define bplglbl 454 "Hungary", add
label define bplglbl 455 "Poland", add
label define bplglbl 456 "Romania", add
label define bplglbl 457 "Yugoslavia", add
label define bplglbl 458 "Central Europe, ns", add
label define bplglbl 459 "Eastern Europe, ns", add
label define bplglbl 461 "Latvia", add
label define bplglbl 462 "Lithuania", add
label define bplglbl 463 "Baltic States, ns", add
label define bplglbl 465 "Other USSR/Russia", add
label define bplglbl 499 "Europe, ns", add
label define bplglbl 460 "Estonia", add
label define bplglbl 500 "China", add
label define bplglbl 501 "Japan", add
label define bplglbl 502 "Korea", add
label define bplglbl 509 "East Asia, ns", add
label define bplglbl 510 "Brunei", add
label define bplglbl 511 "Cambodia (Kampuchea)", add
label define bplglbl 512 "Indonesia", add
label define bplglbl 513 "Laos", add
label define bplglbl 514 "Malaysia", add
label define bplglbl 515 "Philippines", add
label define bplglbl 516 "Singapore", add
label define bplglbl 517 "Thailand", add
label define bplglbl 518 "Vietnam", add
label define bplglbl 519 "Southeast Asia, ns", add
label define bplglbl 520 "Afghanistan", add
label define bplglbl 521 "India", add
label define bplglbl 522 "Iran", add
label define bplglbl 523 "Maldives", add
label define bplglbl 524 "Nepal", add
label define bplglbl 530 "Bahrain", add
label define bplglbl 531 "Cyprus", add
label define bplglbl 532 "Iraq", add
label define bplglbl 533 "Iraq/Saudi Arabia", add
label define bplglbl 534 "Israel/Palestine", add
label define bplglbl 535 "Jordan", add
label define bplglbl 536 "Kuwait", add
label define bplglbl 537 "Lebanon", add
label define bplglbl 538 "Oman", add
label define bplglbl 539 "Qatar", add
label define bplglbl 540 "Saudi Arabia", add
label define bplglbl 541 "Syria", add
label define bplglbl 542 "Turkey", add
label define bplglbl 543 "United Arab Emirates", add
label define bplglbl 544 "Yemen Arab Republic (North)", add
label define bplglbl 545 "Yemen, PDR (South)", add
label define bplglbl 546 "Persian Gulf States, n.s.", add
label define bplglbl 547 "Middle East, ns", add
label define bplglbl 548 "Southwest Asia, nec/ns", add
label define bplglbl 549 "Asia Minor, ns", add
label define bplglbl 550 "South Asia, nec", add
label define bplglbl 599 "Asia, nec/ns", add
label define bplglbl 600 "AFRICA", add
label define bplglbl 700 "Australia and New Zealand", add
label define bplglbl 710 "Pacific Islands", add
label define bplglbl 800 "Antarctica, ns/nec", add
label define bplglbl 900 "Abroad (unknown) or at sea", add
label define bplglbl 950 "Other, nec", add
label define bplglbl 997 "Unknown", add
label define bplglbl 998 "Illegible", add
label define bplglbl 999 "Missing/blank", add
label values bplg bplglbl

save "CensusData", replace

clear
set mem 1100m
use CensusData, clear

keep if age>=25 & age<=50
keep if bplg<57
keep perwt raceg rachist marst marrno age state year sex

gen int white=perwt*(raceg==1)
gen int black=perwt*(raceg==2)
gen int other=perwt*(raceg>2)
replace white=perwt*(rachist==10 | rachist==12) if year==0
replace black=perwt*(rachist==20) if year==0
replace other=perwt*(rachist>20 & rachist~=.) if year==0
gen byte obs=1
collapse (sum) obs  white black other, by(state year sex age)
sort state year sex age
save censusbyrace, replace


use CensusData, clear

keep if age>=25 & age<=50
keep if bplg<57
keep perwt marst marrno age state year sex

gen int marsp=perwt*(marst==1)
gen int marab=perwt*(marst==2)
gen int separat=perwt*(marst==3)
gen int divorce=perwt*(marst==4)
gen int widow=perwt*(marst==5)
gen int nevermar=perwt*(marst==6)

drop perwt marst marrno 
collapse (sum) marsp marab separat divorce widow nevermar, by(state year sex age)
save censusbymarsp, replace

use CensusData, clear

keep if age>=25 & age<=50
keep if bplg<57
keep perwt marst marrno age state year sex

gen int marsp2=perwt*(marst==1)*(marrno>1)
gen int marab2=perwt*(marst==2)*(marrno>1)
gen int separat2=perwt*(marst==3)*(marrno>1)
gen int divorce2=perwt*(marst==4)*(marrno>1)
gen int widow2=perwt*(marst==5)*(marrno>1)

drop perwt marst marrno 
collapse (sum) marsp2 marab2 separat2 divorce2 widow2, by(state year sex age)
save censusbymarrno, replace


use censusbymarrno, clear
sort state year sex age
merge state year sex age using censusbyrace
tab _merge
drop _merge
sort state year sex age
merge state year sex age using censusbymarsp
tab _merge
drop _merge
erase censusbymarrno.dta
erase censusbymarsp.dta
erase censusbyrace.dta

for X in num 96 97 98 99 0 \ Y in num 1960 1970 1980 1990 2000: replace year=Y if year==X
replace sex=sex-1
label drop sexlbl
for var obs white black other marsp marab separat divorce widow nevermar marsp2 marab2 separat2 divorce2 widow2: rename X nX
gen pop=nwhite+nblack+nother
gen black=nblack/(nwhite+nblack+nother)
gen white=nwhite/(nwhite+nblack+nother)
gen other=nother/(nwhite+nblack+nother)
gen divorce=ndivorce/(nmarsp+nmarab+nseparat+ndivorce+nwidow+nneverma)
gen evdiv=(ndivorce+nmarsp2+nmarab2+nseparat2+nwidow2)/(nmarsp+nmarab+nseparat+ndivorce+nwidow+nneverma)
replace evdiv=. if year>1980
compress


gen str2 st=""
replace st="AK" if statefip==2
replace st="AL" if statefip==1
replace st="AR" if statefip==5
replace st="AS" if statefip==60
replace st="AZ" if statefip==4
replace st="CA" if statefip==6
replace st="CO" if statefip==8
replace st="CT" if statefip==9
replace st="DC" if statefip==11
replace st="DE" if statefip==10
replace st="FL" if statefip==12
replace st="GA" if statefip==13
replace st="GU" if statefip==66
replace st="HI" if statefip==15
replace st="IA" if statefip==19
replace st="ID" if statefip==16
replace st="IL" if statefip==17
replace st="IN" if statefip==18
replace st="KS" if statefip==20
replace st="KY" if statefip==21
replace st="LA" if statefip==22
replace st="MA" if statefip==25
replace st="MD" if statefip==24
replace st="ME" if statefip==23
replace st="MI" if statefip==26
replace st="MN" if statefip==27
replace st="MO" if statefip==29
replace st="MS" if statefip==28
replace st="MT" if statefip==30
replace st="NC" if statefip==37
replace st="ND" if statefip==38
replace st="NE" if statefip==31
replace st="NH" if statefip==33
replace st="NJ" if statefip==34
replace st="NM" if statefip==35
replace st="NV" if statefip==32
replace st="NY" if statefip==36
replace st="OH" if statefip==39
replace st="OK" if statefip==40
replace st="OR" if statefip==41
replace st="PA" if statefip==42
replace st="PR" if statefip==72
replace st="RI" if statefip==44
replace st="SC" if statefip==45
replace st="SD" if statefip==46
replace st="TN" if statefip==47
replace st="TX" if statefip==48
replace st="UT" if statefip==49
replace st="VA" if statefip==51
replace st="VI" if statefip==78
replace st="VT" if statefip==50
replace st="WA" if statefip==53
replace st="WI" if statefip==55
replace st="WV" if statefip==54
replace st="WY" if statefip==56

gen gruberlaw=.
replace gruberlaw=1971 if st=="AL"
replace gruberlaw=1935 if st=="AK"
replace gruberlaw=. if st=="AR"
replace gruberlaw=1973 if st=="AZ"
replace gruberlaw=1970 if st=="CA"
replace gruberlaw=1972 if st=="CO"
replace gruberlaw=1973 if st=="CT"
replace gruberlaw=. if st=="DC"
replace gruberlaw=1968 if st=="DE"
replace gruberlaw=1971 if st=="FL"
replace gruberlaw=1973 if st=="GA"
replace gruberlaw=1972 if st=="HI"
replace gruberlaw=1971 if st=="ID"
replace gruberlaw=. if st=="IL"
replace gruberlaw=1973 if st=="IN"
replace gruberlaw=1970 if st=="IA"
replace gruberlaw=1969 if st=="KS"
replace gruberlaw=1972 if st=="KY"
replace gruberlaw=. if st=="LA"
replace gruberlaw=1973 if st=="ME"
replace gruberlaw=. if st=="MD"
replace gruberlaw=1975 if st=="MA"
replace gruberlaw=1972 if st=="MI"
replace gruberlaw=1974 if st=="MN"
replace gruberlaw=. if st=="MS"
replace gruberlaw=. if st=="MO"
replace gruberlaw=1973 if st=="MT"
replace gruberlaw=1972 if st=="NE"
replace gruberlaw=1967 if st=="NV"
replace gruberlaw=1971 if st=="NH"
replace gruberlaw=. if st=="NJ"
replace gruberlaw=1933 if st=="NM"
replace gruberlaw=. if st=="NY"
replace gruberlaw=. if st=="NC"
replace gruberlaw=1971 if st=="ND"
replace gruberlaw=. if st=="OH"
replace gruberlaw=1953 if st=="OK"
replace gruberlaw=1971 if st=="OR"
replace gruberlaw=. if st=="PA"
replace gruberlaw=1975 if st=="RI"
replace gruberlaw=. if st=="SC"
replace gruberlaw=1985 if st=="SD"
replace gruberlaw=. if st=="TN"
replace gruberlaw=1970 if st=="TX"
replace gruberlaw=1987 if st=="UT"
replace gruberlaw=. if st=="VT"
replace gruberlaw=. if st=="VA"
replace gruberlaw=1973 if st=="WA"
replace gruberlaw=. if st=="WV"
replace gruberlaw=1978 if st=="WI"
replace gruberlaw=1977 if st=="WY"

gen unilat1=year>gruberlaw & gruberlaw~=.
gen unil1to10= (year-gruberlaw>=1) & (year-gruberlaw<11) & (gruberlaw~=.)
gen unil11to20=(year-gruberlaw>=11) & (year-gruberlaw<=20) & (gruberlaw~=.)
gen unil20pl=(year-gruberlaw>20) & (gruberlaw~=.)
gen unil11pl=(year-gruberlaw>=11) & (gruberlaw~=.)

la var st  "Two letter state code  (Official US Postal Codes)"
la var age  "Age group (25-50)"
la var year  "Year of observation (1950, 1960, 1970, 1980, 1990, 2000)"
la var sex  "Sex; 0 = female; 1=male"
la var nobs  "(Raw, unweighted) Number of observations in the IPUMS file."
la var nwhite  "Number of whites in this census*age*sex cell"
la var nblack  "Number of blacks in this census*age*sex cell"
la var nother  "Number of non-blacks, non-whites, in this census*age*sex cell"
la var nmarsp  "Number who are currently married, spouse present"
la var nmarab  "Number who are currently married, spouse absent"
la var nseparat  "Number who are currently separated"
la var ndivorce  "Number who are currently divorced"
la var nwidow  "Number who are currently widowed"
la var nneverma  "Number who are currenly widowed"
la var nmarsp2  "Number who are married with spouse present, but on 2nd (or higher) marriage.  1960-80."
la var nmarab2  "Number who are married and separated, but on 2nd (or higher) marriage.  1960-80."
la var nseparat2  "Number who are separated, and on 2nd (or higher) marriage.  1960-80."
la var ndivorce2  "Number who are divorced, and on 2nd (or higher) marriage"
la var nwidow2  "Number who are widowed, from 2nd (or higher) marriage"
la var unilat1  "Gruber's unilateral divorce variable"
la var divorce  "% of the population currently div; ndivorce/(nmarsp+nmarab+nseparat+ndivorce+nwidow+nneverma)"
la var pop  "Estimated population in that age*sex*year cell"
la var black  "%black; nblack/(nwhite+nblack+nother)"
la var white  "%white; nwhite/(nwhite+nblack+nother)"
la var other  "%neither white nor black; nother/(nwhite+nblack+nother)"
la var evdiv  "% of the population “Ever divorced”"
la var unil1to10  "Unilateral divorce laws passed in last 1 to 10 years; Gruber’s coding"
la var unil11to20  "Unilateral divorce laws passed in last 11 to 20 years; Gruber’s coding"
la var unil20pl  "Unilateral divorce laws passed 20 or more years ago; Gruber’s coding"
la var unil11pl  "Unilateral divorce laws passed 11 or more years ago; Gruber’s coding"

order st age year sex nobs nwhite nblack nother nmarsp nmarab nseparat ndivorce nwidow nneverma nmarsp2 nmarab2 nseparat2 ndivorce2 nwidow2 unilat1 divorce pop black white other evdiv unil1to10 unil11to20 unil20pl unil11pl
sort st year sex age
save "Census stock data.dta", replace


