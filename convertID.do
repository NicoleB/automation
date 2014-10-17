* Convert upns/uwids/chrmcid

import delimited using "~/FHCRC/cdiff/data-orig/cdiff_demographics_010111-073114.csv", clear
	
	*Clean up, standardize
	keep upn uwid chrmcid
	do ~/FHCRC/automation/standardID.do
	duplicates drop
	save ~/FHCRC/automation/convertID1.dta, replace

use /Users/nicole/FHCRC/cdiff/data-dta/merged_labs_demo_all.dta, clear
	*Clean up, standardize
	keep upn uwid chrmcid
	do ~/FHCRC/automation/standardID.do
	duplicates drop

append using ~/FHCRC/automation/convertID1.dta, keep(upn uwid chrmcid)

foreach var of varlist uwid chrmcid {
		bysort upn (`var'): carryforward `var', replace
		}
duplicates drop
drop if uwid==. & chrmcid==.
