*Define GVHD prophylaxis
	*Categorize alll those proplbl strings
	
	ge prop_gvhd_all="CSP or FK506, + MTX" if ((strpos(proplbl, "CSP") & strpos(proplbl, "MTX")) | (strpos(proplbl, "FK506") & strpos(proplbl, "MTX"))) & !strpos(proplbl, "MMF")
	replace prop_gvhd_all="MMF" if strpos(proplbl, "MMF")
	replace prop_gvhd_all="Other" if ((strpos(proplbl, "RAPA") |  strpos(proplbl, "ATG")) & !strpos(proplbl, "MMF")) | prop_gvhd_all==""
	replace prop_gvhd_all="None" if inlist(proplbl, "none", "NONE", "None", "")
	
	ge prop_gvhd_allo=prop_gvhd_all if txtype=="ALLO"
