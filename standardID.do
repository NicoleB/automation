*Standardize upn, uwid, chrmcid

local varlist = ""
foreach x in upn uwid chrmcid {
	capture confirm variable `x'
	if !_rc {
		local varlist = "`varlist'" + "`x'" + " "
		di "`varlist'"
	}
}

foreach var of local varlist {
	local varType: type `var'
	if !inlist("`varType'", "byte", "int", "long", "float", "double") {
		replace `var'="." if inlist(`var', "NA", "")
		destring `var', replace
	}
	else {
		continue
	}
}
