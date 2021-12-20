clear
cd "C:\Users\jasonjia\Dropbox\Projects\denmark_spending"
sysdir set PLUS "C:\Users\jasonjia\Dropbox\Projects\denmark_spending\code\ado"
set more off
capture log close
log using "C:\Users\jasonjia\Dropbox\Projects\denmark_spending\code\log\calculateshare", append

import excel "data\spending_matrix.xlsx", sheet("Sheet1") firstrow

*set trace on
foreach i of varlist s_s*{
	egen `i'_share = pc(`i'), prop
}


*set trace off
gen cust_sector_truncated = substr(cust_sector, 1, 3)

* breakdown of spending on each sector of muni 161, by sector that consumers belong to
foreach i of varlist s_s*_spendinflow_161_share{
	graph bar (sum) `i', over(cust_sector_truncated, label(labsize(vsmall))) saving(`i'_g, replace) 
}

graph dir s_s*_spendinflow_161_share_g
local graphs = r(list)
graph combine `graphs', saving(graphs_combined_161)

* breakdown of spending on each sector of muni 161, by muni that consumers belong to
foreach i of varlist s_s*_spendinflow_161_share{
	graph bar (sum) `i', over(cust_muni, label(labsize(vsmall)) sort(1) descending) saving(`i'_muni_g, replace) 
}

graph dir s_s*_spendinflow_161_share_g
local graphs = r(list)
graph combine `graphs', saving(graphs_combined_161)

 