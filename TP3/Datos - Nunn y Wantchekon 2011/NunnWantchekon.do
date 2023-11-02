
* Juntamos todas las variables de control en dos

local baseline_controls "age age2 male urban_dum i.education i.occupation i.religion i.living_conditions district_ethnic_frac frac_ethnicity_in_district i.isocode"
local colonial_controls "malaria_ecology total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33"

* Un ejemplo de cómo usar baseline_controls y colonial_controls en una regresión. Estos coeficientes no se reportan, pero se están usando (y nos nos preocupa)
reg trust_relatives `baseline_controls' `colonial_controls', robust

* Podemos agregar una tercera varaible que sí nos muestre su coeficiente
reg trust_relatives `baseline_controls' `colonial_controls' ln_init_pop_density, robust

* En el TP usen como controles: `baseline_controls' `colonial_controls' ln_init_pop_density





