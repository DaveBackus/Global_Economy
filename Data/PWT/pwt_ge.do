* ----------------------------------------------------------------------------------
*  pwt_ge.do
*  Read in Gian Luca Clementi's version of the Penn World Tables, version 6.3
*  All countries, with growth accounting variables    
*  Variables:  
*	name country year population ...  
*	output_head output_worker capital_head education
*  Written by:  Dave Backus, 2007 and after.  
* ----------------------------------------------------------------------------------
clear 
set more on
*cd "C:\Documents and Settings\David Backus\My Documents\Classes\Backus_07\Data\PWT"
cd "Q:\ECO\Global Economy\BCEFP\Backus_10\Data\PWT"

*  Input data from spreadsheet  
insheet using pwt_ge.csv, clear 
list in 1/3

gen ky = capital_head/output_head

keep if year==2000
*keep if output_head>20000
list country ky

scatter ky output_head, ///
	legend(off) xtitle("GDP Per Capita") ytitle("Capital-Output Ratio") /// 
	mlabel(country)
graph export ky_crosssection_2000.eps, replace 


/*
* Graphs of GDP per worker 
line output_worker year if country=="USA", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylusa.emf, replace 

line output_worker year if country=="FRA", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylfra.emf, replace 

line output_worker year if country=="JPN", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtyljpn.emf, replace 

line output_worker year if country=="KOR", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylkor.emf, replace 

line output_worker year if country=="CHN", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylchn.emf, replace 

line output_worker year if country=="IND", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylind.emf, replace 

line output_worker year if country=="VEN", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylven.emf, replace 


* graphs of GDP per capita 
gen USA = output_head if country=="USA"

gen FRA = output_head if country=="FRA"
gen GER = output_head if country=="GER"
gen ITA = output_head if country=="ITA"
gen ESP = output_head if country=="ESP"

gen BLR = output_head if country=="BLR"
gen GEO = output_head if country=="GEO"
gen POL = output_head if country=="POL"
gen RUS = output_head if country=="RUS"
gen TUR = output_head if country=="TUR"

gen JOR = output_head if country=="JOR"
gen ISR = output_head if country=="ISR"
gen ARE = output_head if country=="ARE"
gen IRQ = output_head if country=="IRQ"

gen COG = output_head if country=="COG"
gen GHA = output_head if country=="GHA"
gen ZWE = output_head if country=="ZWE"
gen ZAF = output_head if country=="ZAF"

gen ERI = output_head if country=="ERI"
gen EGY = output_head if country=="EGY"
gen KEN = output_head if country=="KEN"
gen UGA = output_head if country=="UGA"


gen KOR = output_head if country=="KOR"
gen SGP = output_head if country=="SGP"
gen MYS = output_head if country=="MYS"
gen CHN = output_head if country=="CHN"
gen IND = output_head if country=="IND"
gen BGD = output_head if country=="BGD"
gen PAK = output_head if country=="PAK"

gen ARG = output_head if country=="ARG"
gen BRA = output_head if country=="BRA"
gen CHL = output_head if country=="CHL"
gen MEX = output_head if country=="MEX"
gen PER = output_head if country=="PER"

line USA year || line FRA year || line GER year || line ITA year || line ESP year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwteur.emf, replace 

line USA year || line BLR year || line GEO year || line POL year || line RUS year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtussr.emf, replace 

line USA year || line JOR year || line ISR year || line ARE year || line IRQ year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtmideast.emf, replace 

line USA year || line KOR year || line SGP year || line MYS year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtasia1.emf, replace 

line USA year || line BGD year || line IND year || line PAK year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtasia2.emf, replace 

line BGD year || line IND year || line PAK year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtasia2nousa.emf, replace 

line USA year || line BRA year || line CHN year || line IND year || line RUS year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtbrics.emf, replace 

line USA year || line BRA year || line ARG year || line CHL year || line MEX year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtlam.emf, replace 

line USA year || line GHA year || line COG year || line ZAF year || line ZWE year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtafr1.emf, replace 

line USA year || line EGY year || line ERI year || line KEN year || line UGA year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtafr2.emf, replace 

line EGY year || line ERI year || line KEN year || line UGA year, ///
	, legend(rows(1)) xtitle("") ytitle("GDP Per Capita (2000 US Dollars)") 
graph export pwtafr2nousa.emf, replace 
*/
