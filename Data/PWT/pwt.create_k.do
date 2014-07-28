clear

cd "c:\data"

***********************************************************************************************************
* This program computes the estimate of the series for the capital stock
* The initial capital stock is assumed to be the steady state as computed by Hall & Jones ( QJE 1999), footnote 5 
***********************************************************************************************************

* Load the most recent version of the PWT
insheet using c:\data\pwt63.csv, comma n double

keep country isocode year rgdpch rgdpwok pop ki ppp xrat

outsheet using pwt63_mod.txt, noquote replace

**********************************************************************

* Input the depreciation rate
gen depr_rate=0.06

* Drop if we do not have data about investment
drop if ki==.

* Compute series of investment per capita
gen investment = rgdpch*ki/100

sort isocode year

* Compute output growth and employment growth for first ten years in sample
by isocode: gen growth_y   =(log(rgdpch[10])-log(rgdpch[1]))/10
by isocode: gen growth_pop =(log(pop[10])-log(pop[1]))/10

* Compute steady state capital per capita
gen denom = exp( growth_y + growth_pop ) - 1 + depr_rate
gen capital = investment/denom
by isocode: replace capital = 0 if _n > 1

* Compute capital per capita in the other years
by isocode: replace capital = (1-depr_rate)*capital[_n-1] + investment if _n > 1

drop growth_y growth_pop denom 

ren country name

rename isocode country

sort country year

save pwt_clean, replace

sort country year

* Saving as comma-separated spreadsheet
outsheet using pwt_clean.xls, noquote replace

clear 

***********************************************************************************************************
* Now we merge the PWT data with the education data
* The data being from Barro-Lee, covers up to 1994 and then projects up to 2000
* Here we extrapolate up to 2007
***********************************************************************************************************

insheet using c:\data\education\total_15_stat.csv, comma n double

keep country year avg_15

sort country year

merge country year using pwt_clean

sort country year

drop if capital==.

by country: ipolate avg_15 year, gen(education)

by country: drop if education==. & year<2000

drop education

by country: ipolate avg_15 year, gen(education) epolate

drop if education==.

drop avg_15 _merge

drop if rgdpwok==.

gen labor = rgdpch*pop/rgdpwok

keep name country year labor rgdpch rgdpwok pop capital education

ren rgdpwok output_worker
ren rgdpch output_head
ren capital capital_head
ren pop population

**************************** pwt_ge.xls includes only the country-year pairs for which we have data
**************************** on both capital stock and education
* Saving as comma-separated spreadsheet
outsheet using pwt_ge.xls, noquote replace

save pwt_ge, replace

keep country year education

sort country year

save educazione, replace

clear

cd "c:\data"

***********************************************************************************************************
* This program computes the estimate of the series for the capital stock
* The initial capital stock is assumed to be the steady state as computed by Hall & Jones ( QJE 1999), footnote 5 
***********************************************************************************************************

insheet using c:\data\pwt_clean.xls, n double

sort country year

merge country year using educazione

drop _merge

keep name country year pop rgdpwok rgdpch capital education

rename pop population
rename rgdpwok output_worker
rename rgdpch output_capita
rename capital capital_capita

************************* pwt_clean.xls includes all data from the original PWT plus capital
************************* and education data
* Saving as comma-separated spreadsheet
outsheet using pwt_clean.xls, noquote replace


