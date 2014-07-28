*  Blanchard-Wolfers Stata program 
*  Unemployment and institutions

set more off
set matsize 600
program drop _all
sort country period

* De-mean the institutions variables: We need to set the mean to zero of institutions.  Note that this must be zero over the specific sample that we are using
gen tshock= (unr~=. & empro~=.)
la var tshock "Obsn is included in t-shock regressions"

egen avrrate=mean(rrate) if tshock
egen avben=mean(benefit)  if tshock
egen avuni=mean(union) if tshock
egen avempro=mean(empro) if tshock
egen avalmp=mean(almphat) if tshock
egen avuden=mean(uden) if tshock
egen avt=mean(t) if tshock
egen avcoord=mean(coord) if tshock
egen avoecd=mean(oecdrate) if tshock
egen avnewep=mean(newep) if tshock
egen avrr1=mean(rr1) if tshock
egen avrr2=mean(rr2) if tshock
egen avrr35=mean(rr35) if tshock
egen avrr25=mean(rr25) if tshock

gen trrate=rrate-avrrate
gen tbenefit=benefit-avben
gen tunion=union-avuni
gen tempro=empro-avempro
gen talmphat=almp-avalmp
gen tuden=uden-avuden
gen tt=t-avt
gen tcoord=coord-avcoord
gen toecdrte=oecdrate-avoecd
gen tnewep=newep-avnewep
gen trr1=rr1-avrr1
gen trr2=rr2-avrr2
gen trr35=rr35-avrr35
gen trr25=rr25-avrr25

drop av*

**** Institutions interacted with unobservable shocks
* This program is time FE and country FE - no lagged dependent
program define nlprogt2
	if "`1'" == "?" {
		global S_1 "C RHO T1 T2 T3 T4 T5 T6 T7 T8 XRRATE XBENEFIT XUNION XEMPRO XALMPHAT XUDEN XT XCOORD AUS AUT BEL CAN DEN FIN FRA GER IRE ITA JAP NET NOR NZ POR SPA SWE SWZ UK USA PORTDUM"
		global C=0.00
		global PORTDUM=0
		global RHO=0.00
		global AUS=0
		global AUT=0
		global BEL=0
		global CAN=0
		global DEN=0
		global FIN=0
		global FRA=0
		global GER=0
		global IRE=0
		global ITA=0
		global JAP=0
		global NET=0
		global NOR=0
		global NZ=0
		global POR=0
		global SPA=0
		global SWE=0
		global SWZ=0
		global UK=0
		global USA=0
		global T1=0.00
		global T2=0.00
		global T3=0.00
		global T4=0.00
		global T5=0.00
		global T6=0.00
		global T7=0.00
		global T8=0.00
		global XRRATE=0
		global XBENEFIT=0
		global XUNION=0
		global XEMPRO=0
		global XALMPHAT=0
		global XUDEN=0
		global XT=0
		global XCOORD=0
		exit
	}
	replace `1' = ($XRRATE*`2'+$XBENEFIT*`3'+$XEMPRO*`4'+$XUNION*tunion+$XALMPHAT*talmphat+$XUDEN*`5'+$XT*tt+$XCOORD*`6')*($T2*Iperio_2+$T3*Iperio_3+$T4*Iperio_4+$T5*Iperio_5+$T6*Iperio_6+$T7*Iperio_7+$T8*Iperio_8)+$T2*Iperio_2+$T3*Iperio_3+$T4*Iperio_4+$T5*Iperio_5+$T6*Iperio_6+$T7*Iperio_7+$T8*Iperio_8
	replace `1'=`1'+$AUS*Icoun_1+$AUT*Icoun_2+$BEL*Icoun_3+$CAN*Icoun_4+$DEN*Icoun_5+$FIN*Icoun_6+$FRA*Icoun_7+$GER*Icoun_8+$IRE*Icoun_11+$ITA*Icoun_12+$JAP*Icoun_13+$NET*Icoun_17+$NOR*Icoun_18+$NZ*Icoun_19+$POR*Icoun_20+$SPA*Icoun_21+$SWE*Icoun_22 +$SWZ*Icoun_23+$UK*Icoun_25+$USA*Icoun_26
end

set more on

nl progt2 unr trrate tbenefit tempro tuden tcoord if tshock, nolog


**** Institutions interacted with observable shocks

set more off
program drop _all
sort country period


* De-mean the institutions variables: We need to set the mean to zero of institutions.  Note that this must be zero over the specific sample that we are using
gen idshock= (unr~=. & tfpgap~=. & ld8~=. & rl~=. & empro~=.)

la var idshock "Obsn is included in ID-shock regressions"

egen avrrate=mean(rrate) if idshock
egen avben=mean(benefit)  if idshock
egen avuni=mean(union) if idshock
egen avempro=mean(empro) if idshock
egen avalmp=mean(almphat) if idshock
egen avuden=mean(uden) if idshock
egen avt=mean(t) if idshock
egen avcoord=mean(coord) if idshock
egen avoecd=mean(oecdrate) if idshock
egen avnewep=mean(newep) if idshock
egen avrr1=mean(rr1) if idshock
egen avrr25=mean(rr25) if idshock
egen avrr2=mean(rr2) if idshock
egen avrr35=mean(rr35) if idshock
egen avtfpgap=mean(tfpgap) if idshock
egen avrl=mean(rl) if idshock
egen avld8=mean(ld8) if idshock

gen irrate=rrate-avrrate
gen ibenefit=benefit-avben
gen iunion=union-avuni
gen iempro=empro-avempro
gen ialmphat=almp-avalmp
gen iuden=uden-avuden
gen it=t-avt
gen icoord=coord-avcoord
gen ioecdrte=oecdrate-avoecd
gen inewep=newep-avnewep
gen irr1=rr1-avrr1
gen irr2=rr2-avrr2
gen irr35=rr35-avrr35
gen irr25=rr25-avrr25
gen idrl=rl-avrl
gen idtfpgap=tfpgap-avtfpgap
gen idld8=ld8-avld8

drop av*

xi i.period i.country
gen Icoun_1=country=="AUSTRALIA"
gen Iperio_1=period==1960

program define nlprogi2
	if "`1'" == "?" {
		global S_1 "SLD SRL STFP XRRATE XBENEFIT XUNION XEMPRO XALMPHAT XUDEN XT XCOORD AUS AUT BEL CAN DEN FIN FRA GER IRE ITA JAP NET NOR NZ POR SPA SWE SWZ UK USA PORTDUM"
		global PORTDUM=0
		global AUS=0
		global AUT=0
		global BEL=0
		global CAN=0
		global DEN=0
		global FIN=0
		global FRA=0
		global GER=0
		global IRE=0
		global ITA=0
		global JAP=0
		global NET=0
		global NOR=0
		global NZ=0
		global POR=0
		global SPA=0
		global SWE=0
		global SWZ=0
		global UK=0
		global USA=0
		global SLD=0.00
		global SRL=0.00
		global STFP=0.00
		global XRRATE=0
		global XBENEFIT=0
		global XUNION=0
		global XEMPRO=0
		global XALMPHAT=0
		global XUDEN=0
		global XT=0
		global XCOORD=0
		exit
	}
	replace `1' = (($SLD*idld8+$SRL*idrl+$STFP*idtfpgap+$PORTDUM*portrev)*(1+$XRRATE*`2'+$XBENEFIT*`3'+$XUNION*iunion+$XEMPRO*`4'+$XALMPHAT*ialmphat+$XUDEN*iuden+$XT*it+$XCOORD*icoord))
	replace `1'=`1'+$AUS*Icoun_1+$AUT*Icoun_2+$BEL*Icoun_3+$CAN*Icoun_4+$DEN*Icoun_5+$FIN*Icoun_6+$FRA*Icoun_7+$GER*Icoun_8+$IRE*Icoun_11+$ITA*Icoun_12+$JAP*Icoun_13+$NET*Icoun_17+$NOR*Icoun_18+$NZ*Icoun_19+$POR*Icoun_20+$SPA*Icoun_21+$SWE*Icoun_22 +$SWZ*Icoun_23+$UK*Icoun_25+$USA*Icoun_26
end
set more on

nl progi2 unr irrate ibenefit iempro if idshock
