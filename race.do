*Redefine race
replace race="1" if race=="Caucasian"
replace race="2" if race=="Hispanic"
replace race="3" if race=="Asian" | race=="Chinese" | race=="East Indian" | race=="Filipino" | race=="Japanese" | race=="Korean" | race=="Pacific Islande" | race=="Southeast Asian"
replace race="4" if race=="American Black" | race=="African Black"
replace race="5" if race=="Native American"
replace race="6" if race=="Jewish" | race=="Multiple" | race=="Middle Eastern"
replace race="7" if race=="Unknown" | race!="1" & race!="2" & race!="3" & race!="4" & race!="5" & race!="6"
destring race, replace
label define frace 1 "Caucasian" 2 "Hispanic" 3 "Asian" 4 "African (American or otherwise)" 5 "Native American" 6 "Other" 7 "Unknown"
label value race frace
