*Redefine race
replace race="1" if race=="Caucasian"
replace race="2" if race=="Hispanic"
replace race="3" if inlist(race, "Asian", "Chinese", "East Indian", "Filipino", "Japanese", "Korean", "Pacific Islande", "Southeast Asian")
replace race="4" if inlist(race, "American Black", "African Black")
replace race="5" if race=="Native American"
replace race="6" if inlist(race, "Jewish", "Multiple", "Middle Eastern")
replace race="7" if race=="Unknown" | !inlist(race, "1", "2", "3", "4", "5", "6")
destring race, replace

label define frace 1 "Caucasian" 2 "Hispanic" 3 "Asian" 4 "Black (American/African)" 5 "Native American" 6 "Other" 7 "Unknown"
label value race frace
