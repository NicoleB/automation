*Standardize upn, uwid, chrmcid to only numeric values

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
		
		foreach nonnum in " " "-" "/" "U" "NA" {
			replace `var' = subinstr(`var', "`nonnum'", "", .)
		}
		
		destring `var', replace

		di "________________________________"
		di "`var'", " was type: ", "`varType'"	
	}
	
	else {
		di "________________________________"
		di "All values in", "`var'", "are numeric!"
		di "________________________________"
		continue
	}
	
	local varType: type `var'
	di "`var'", " is now type: ", "`varType'"	
	di "________________________________"
	
	capture drop nonnumeric
	
	if !inlist("`varType'", "byte", "int", "long", "float", "double") {
		ge byte nonnumeric = real(`var')==.
		di "________________________________"
		di "This ", "`var'", " contains nonnumeric characters:"
		list upn `var' if nonnumeric==1 & `var' != ""
		di "________________________________"
	}
	
	else {
		di "________________________________"
		di "All values in", "`var'", "are numeric!"
		di "________________________________"
		}
}
