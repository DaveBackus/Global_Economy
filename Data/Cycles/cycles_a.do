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
cd "Q:\ECO\Global Economy\BCEFP\Backus_09\Data\Cycles"
*cd "C:\Documents and Settings\David Backus\My Documents\Classes\Backus_06\Data\Cycles"

*  (i) Input data from spreadsheet
#delimit ;
insheet date ygdp ypvt yagr ymin yuts ycon yman ywhl yret ytrn yinf yfin
    ysvc yedu yhlt yart ygov 
    niipcc niipmv 
    using cycles_indicators_a.csv, clear;

#delimit cr
* Drop 2 header rows and last obs (NA)
drop in 1/2    /* first two rows are description and Datastream mnemonic */
*drop in -1
destring _all, replace force
replace date = 1950+_n-1
gen time = _n
tsset time

* BEGIN ADDED BY ESPEN
format date %ty
tsset  date
sort   date
* END ADDED BY ESPEN

/*
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
*	 BEGIN ADDED BY ESPEN;
twoway tsline agr man inf fin dis svc hlt, 
/*	if tin(1950, 2005), */
      xlabel(1950(10)2010)
      legend(c(4))
	text(0.295 1952 "Manufacturing", place(e))    
	text(0.075 1952 "Agriculture", place(e))    
	text(0.21 2000 "Finance", place(w))    
	text(0.09 1985 "Business Services", place(w))  
      xtitle("") ytitle("Share of GDP (VA at current prices)") ;
* END ADDED BY ESPEN;
graph export us_indshares.emf, replace;
*/

*  (iii) Draw pix
gen niipccy = 0.001*niipcc/ygdp
gen niipmvy = 0.001*niipmv/ygdp
keep if date>1970 

#delimit ;
line niipccy date || line niipmvy date, 
      xlabel(1970(10)2010)
      legend(off)
	text(0.13 1982 "Current Cost", place(e)) 
	text(0.01 1992 "Market Value", place(e)) 
      xtitle("") ytitle("Net Foreign Assets (Ratio to GDP)");  
graph export us_niip.emf, replace;


#delimit cr
/* old version */
* line agr date || line man date || line inf date || line fin date
*     || line dis date || line svc date || line hlt date,
*     legend(rows(2)) xtitle("") ytitle("Share of GDP (VA at current prices)") ;
* 
