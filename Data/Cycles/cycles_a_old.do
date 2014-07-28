* ----------------------------------------------------------------------------------
*  cycles_a.do
*  Program reads in annual data on nominal US GDP by industry, 1950-present  
*  We use it to generate pictures for the Global Economy class
*  Spreadsheet contains data from Datastream listed in cycles_indicators_a.llt 
*  Variable names:
*     gdp = gdp 
*     pvt = private industry 
*     agr = agriculture, forestry, fishing, and hunting
*     min = mining
*     uts = utilities 
*     con = construction
*     man = manufacturing
*     whl = wholesale trade 
*     ret = retail trade 
*     trn = transportation and warehousing 
*     inf = information (publishing, broadcasting, data processing) 
*     fin = finance, insurance, and real estate 
*     svc = professional and business services 
*     edu = education 
*     hlt = healthcare and social assistance 
*     art = arts, entertainment, recreation 
*     gov = government 
*  Written by:  Dave Backus (Dec 07 and after)
* ----------------------------------------------------------------------------------
clear 
cd "Q:\ECO\Global Economy\BCEFP\Backus_08\Data\Cycles"
*cd "C:\Documents and Settings\David Backus\My Documents\Classes\Backus_06\Data\Cycles"

*  (i) Input data from spreadsheet  
#delimit ;
insheet date ygdp ypvt yagr ymin yuts ycon yman ywhl yret ytrn yinf yfin 
	ysvc yedu yhlt yart ygov 
	using cycles_indicators_a.csv, clear;

#delimit cr
* Drop 2 header rows and last obs (NA) 
drop in 1/2    /* first two rows are description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1950+_n-1 
gen time = _n
tsset time

*  (ii) Generate output shares 
gen agr = yagr/ygdp
gen min = ymin/ygdp
gen uts = yuts/ygdp
gen con = ycon/ygdp
gen man = yman/ygdp
gen whl = ywhl/ygdp
gen ret = yret/ygdp
gen dis = whl+ret
gen trn = ytrn/ygdp
gen inf = yinf/ygdp
gen fin = yfin/ygdp
gen svc = ysvc/ygdp
gen edu = yedu/ygdp
gen hlt = yhlt/ygdp
gen art = yart/ygdp
gen gov = ygov/ygdp

*  (iii) Draw pix 
#delimit ;
/* this one for the measurement lecture */  
line agr date || line man date || line inf date || line fin date 
	|| line dis date || line svc date || line hlt date, 
	legend(rows(2)) xtitle("") ytitle("Share of GDP (VA at current prices)") ;
graph export us_indshares.emf, replace;
