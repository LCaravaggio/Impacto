* Install dependencies
* ssc install matsort
* ssc install eventdd


* Start Code
cd "C:\Users\lcaravaggio_mecon\Desktop\Evaluación de Impacto\TP3"
pause off
clear all
set more off
set mem 50m
set matsize 400

****** NUN Y WANTCHEKON *******

use "Datos - Nunn y Wantchekon 2011\Nunn_Wantchekon_AER_2011.dta" 

egen isocode_numeric = group(isocode)


* Juntamos todas las variables de control en dos
local baseline_controls "age age2 male urban_dum i.education i.occupation i.religion i.living_conditions district_ethnic_frac frac_ethnicity_in_district isocode_numeric"
local colonial_controls "malaria_ecology total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33"
local dep "trust_relatives trust_neighbors intra_group_trust inter_group_trust trust_local_council"

* Errores estándar a nivel de distrito
ivreg2 `dep' `baseline_controls' `colonial_controls' ln_init_pop_density (ln_export_area=distsea), first cluster(district)
mat P=r(table)
local i=1
matrix B = J(2,3,.)
matrix B[1,1] = P[1,1]
matrix B[1,2] = P[2,1]
matrix B[1,3] = P[3,1]
matrix B[2,1] = P[1,2]
matrix B[2,2] = P[2,2]
matrix B[2,3] = P[3,2]

r(table)
matlist B

* Errores estándar a nivel de grupo étnico
ivreg2 `dep' `baseline_controls' `colonial_controls' ln_init_pop_density (ln_export_area=distsea), first cluster(murdock_name)


* Sin controles
ivreg2 `dep' ln_init_pop_density (ln_export_area=distsea), first cluster(district)

* Reduced form
reg `baseline_controls' `colonial_controls' ln_init_pop_density ln_export_area=distsea, cluster(district)
