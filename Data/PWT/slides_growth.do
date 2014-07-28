* ----------------------------------------------------------------------------------
*  pwt62.do
*  Read in Gian Luca Clementi's version of the Penn World Tables, version 6.2
*  All countries, with growth accounting variables    
*  Output per worker graphs for growth accounting 
*  Written by:  Dave Backus, 2007 and after.  
* ----------------------------------------------------------------------------------
clear 
*cd "C:\Documents and Settings\David Backus\My Documents\Classes\Backus_07\Data\PWT"
cd "Q:\ECO\Global Economy\BCEFP\Backus_09\Data\PWT"

*  Input data from spreadsheet  
insheet using pwt_ge.xls, clear 

gen capital_worker = capital_capita*output_worker/output_capita
gen capital_output = capital_capita/output_capita

/*
* Graphs of GDP per worker 
line output_worker year if country=="USA", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylusa.emf, replace 

line output_worker year if country=="FRA" ///
	|| line output_capita year if country=="FRA", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylfra.emf, replace 

line output_worker year if country=="JPN", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtyljpn.emf, replace 

line output_worker year if country=="KOR", ///
	legend(off) xtitle("") ytitle("GDP Per Worker (2000 US Dollars)") 
graph export pwtylkor.emf, replace 

line output_worker year if country=="BRA",		///
	legend(off) xtitle("") ytitle("GDP Per Worker") 
graph export pwtylbra.emf, replace 

line output_capita year if country=="BRA"  ///
	|| line output_worker year if country=="BRA",		///
	text(8500 1985 "GDP Per Capita", place(e)) ///
	text(13000 1985 "GDP Per Worker", place(e)) ///
	legend(off) xtitle("") ytitle("PPP adjusted numbers (2000 US Dollars)") 
graph export pwtbramidterm07.emf, replace 
graph export pwtbramidterm07.eps, replace 

*keep if country=="BRA"
*list year output_worker capital_worker

line output_capita year if country=="IRL",		///
	legend(off) xtitle("") ytitle("PPP adjusted numbers (2000 US Dollars)") 
graph export pwtirlypop.emf, replace 

line output_capita year if country=="IRL"  ///
	|| line output_worker year if country=="IRL",		///
	legend(off) xtitle("") ytitle("PPP adjusted numbers (2000 US Dollars)") 
graph export pwtirlypopyl.emf, replace 
*list year output_worker capital_worker if country=="IRL"
*/

/*
* Midterm 2008 (Mexico) 
line output_capita year if country=="MEX"  ///
	|| line output_worker year if country=="MEX",		///
	text(9000 1985 "GDP Per Capita", place(e)) ///
	text(16000 1985 "GDP Per Worker", place(e)) ///
	legend(off) xtitle("") ytitle("PPP adjusted numbers (2000 US Dollars)") 
*graph export pwtmexypopyl.emf, replace 
*graph export pwtmexypopyl.eps, replace 

list year output_capita output_worker capital_worker if country=="MEX"
*/

* Midterm 2009 (Poland) 
line output_capita year if country=="POL" & year>1987 ///
	|| line output_worker year if country=="POL", ///
	text(7500 1985 "GDP Per Capita", place(e)) ///
	text(14000 1985 "GDP Per Worker", place(e)) ///
	legend(off) xtitle("") ytitle("PPP adjusted numbers (2000 US Dollars)") 
graph export pwtpolypopyl.emf, replace 
graph export pwtpolypopyl.eps, replace 

list year output_capita output_worker capital_output if country=="POL"
