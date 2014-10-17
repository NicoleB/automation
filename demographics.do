/* This do.file creates the following demographic vars:
	txage 		(cont: age at transplant)
	myel 		(bin: receipt of myeloablative conditioning)
	prop_gvhd 	(dummy: gvhd prophylaxis; see prop_gvhd.do for details)
	race 		(dummy: patient race; see race.do for details)
	diagBroad 	(dummy: disease at transplant; see below for details)
	donor 		(dummy: donor relationship; see below for details)

*/

*USER: Replace the following (after "cd") with your do.file directory:
cd /Users/nicole/FHCRC/automation/



*Age
	replace txage=floor(txage)
*Txtype
	ge txtype=hla_lbl
	replace txtype="ALLO" if txtype!="AUTO"
*Myelo
	*Fix workhla missing value error (these should be autos)
	replace workhla="AUTOLOGOUS" if txtype=="AUTO"
	*Now define myel
	ge myel=cond(!inlist(workhla,"RELATED MINI", "UNRELATED MINI"), "1", "0")
	destring myel, replace
	replace myel=. if workhla=="AUTOLOGOUS"
	label define fmyel 1 "Myelo" 0 "Nonmyelo"
	label value myel fmyel
	
do prop_gvhd.do
do race.do

*Diagnosis
ge diagBroad=""
foreach name in ANL NHL MM MDS ALL CLL CML HD {
    replace diagBroad="`name'" if dxgroup=="`name'" | dxgroux=="`name'"
}	
replace diagBroad="Other" if diagBroad==""

*Donor relationship
ge donor=""
foreach name in Self "Identical Twin" Sibling {
	replace donor="`name'" if donrel=="`name'"
	}
replace donor="Unrelated" if donrel=="Not Related"
replace donor= "Haplo" if inlist(donrel, "Child", "Parent")
replace donor="Other related" if donor==""
