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

* IV Reg Distrito
matrix B = J(10,3,.)
local i=1
foreach d in trust_relatives trust_neighbors intra_group_trust inter_group_trust trust_local_council {
quietly ivreg2 `d' `baseline_controls' `colonial_controls' ln_init_pop_density (ln_export_area=distsea), first cluster(district)
mat P=e(b)
matrix V = e(V)
matrix B[`i',1] = P[1,1]
matrix B[`i'+1,1] = sqrt(V[1,1])
matrix B[`i',2] = P[1,2]
matrix B[`i'+1,2] = sqrt(V[2,2])
*matrix B[`i',3] = P[1,3]
*matrix B[`i'+1,3] = sqrt(V[3,3])
matrix B[`i',3] = e(widstat)
local i=`i'+2
}


matrix rownames B = trust_relatives R.S.E. trust_neighbors R.S.E. intra_group_trust  R.S.E. inter_group_trust R.S.E. trust_local_council R.S.E.
matrix colnames B = ln_export_area ln_init_pop_density  KP_F
esttab matrix(B) using "B.tex", replace title(Regresiones Instrumentales - Distrito) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de las regresiones instrumentales clusterizadas a nivel de distrito.}\label{B}") nomtitles

* IV Reg Grupo Étnico
matrix B = J(10,3,.)
local i=1
foreach d in trust_relatives trust_neighbors intra_group_trust inter_group_trust trust_local_council {
quietly ivreg2 `d' `baseline_controls' `colonial_controls' ln_init_pop_density (ln_export_area=distsea), first cluster(murdock_name)
mat P=e(b)
matrix V = e(V)
matrix B[`i',1] = P[1,1]
matrix B[`i'+1,1] = sqrt(V[1,1])
matrix B[`i',2] = P[1,2]
matrix B[`i'+1,2] = sqrt(V[2,2])
*matrix B[`i',3] = P[1,3]
*matrix B[`i'+1,3] = sqrt(V[3,3])
matrix B[`i',3] = e(widstat)
local i=`i'+2
}


matrix rownames B = trust_relatives R.S.E. trust_neighbors R.S.E. intra_group_trust  R.S.E. inter_group_trust R.S.E. trust_local_council R.S.E.
matrix colnames B = ln_export_area ln_init_pop_density  KP_F
esttab matrix(B) using "C.tex", replace title(Regresiones Instrumentales - Grupo Étnico) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de las regresiones instrumentales clusterizadas a nivel de grupo étnico.}\label{C}") nomtitles




* Sin controles
* IV Reg Distrito
matrix B = J(10,3,.)
local i=1
foreach d in trust_relatives trust_neighbors intra_group_trust inter_group_trust trust_local_council {
quietly ivreg2 `d' ln_init_pop_density (ln_export_area=distsea), first cluster(district)
mat P=e(b)
matrix V = e(V)
matrix B[`i',1] = P[1,1]
matrix B[`i'+1,1] = sqrt(V[1,1])
matrix B[`i',2] = P[1,2]
matrix B[`i'+1,2] = sqrt(V[2,2])
*matrix B[`i',3] = P[1,3]
*matrix B[`i'+1,3] = sqrt(V[3,3])
matrix B[`i',3] = e(widstat)
local i=`i'+2
}


matrix rownames B = trust_relatives R.S.E. trust_neighbors R.S.E. intra_group_trust  R.S.E. inter_group_trust R.S.E. trust_local_council R.S.E.
matrix colnames B = ln_export_area ln_init_pop_density  KP_F
esttab matrix(B) using "D.tex", replace title(Regresiones Instrumentales sin Controles) postfoot("\tabnotes{3}{Nota: Se presentan los coeficientes de las regresiones instrumentales clusterizadas a nivel de distrito pero sin controles.}\label{D}") nomtitles


* Reduced form
reg `baseline_controls' `colonial_controls' ln_init_pop_density ln_export_area=distsea, cluster(district)
