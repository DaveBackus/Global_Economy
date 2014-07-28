* ----------------------------------------------------------------------------------
*  italy.do
*  Program reads in selected series for description of US business cycles 
*  Spreadsheet contains data from Datastream listed in GE cycles basic.llt (?)
*  Written by:  Dave Backus (Feb 06 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_08\Data\Cycles"
*cd "C:\Documents and Settings\David Backus\My Documents\Classes\Backus_08\Data\Cycles"

*  Input data from spreadsheet  
insheet date dep wages surplus res taxes gdp using "Italy income.csv", clear 
* Drop 2 header rows and last obs (NA) 
drop in 1/2     /* first two rows are description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1980+_n/4-1/8
gen time = _n
tsset time

*  (i) Generate ratios 

gen wy = wages/gdp 
gen depy = dep/gdp
gen resy = res/gdp
gen taxy = taxes/gdp
gen sury = surplus/gdp

line wy date || line depy date || line taxy date || line sury date 

