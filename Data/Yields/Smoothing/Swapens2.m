%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% function err = swapens(par,X,date);
% Erro function for estimating the spot rates curve from swap rates data
% Extended Nelson-Bliss Method
% X=LIBOR (at 1,3,6,12 months) and swap rates at (2,3,4,5,7,10 years)
% day countiung convention: 
%		USD LIBOR actual/360
%		USD swap: 360/360, semi-annual compounding
% Liuren Wu, October 19, 2000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function err = swapens2(par,X,date1);

beta0=par(1);
beta1=par(2);
beta2=par(3);
tau1=par(4);
tau2=par(5);

x2=X;

mat1=[1 3 6 12]'; %month
[yr mt dt]=datevec(date1);
date2=datenum(yr,mt+mat1,dt);
nmat1=daysact(date1, date2)./360;%USD LIBOR convention: act/360  

y1=beta0+beta1*(1-exp(-nmat1/tau1))./(nmat1/tau1)+ ...
   beta2*((1-exp(-nmat1/tau2))./(nmat1/tau2) -exp(-nmat1/tau2));
x2(1:4)=100*(exp(y1.*nmat1)-1)./nmat1; 


mat=[6:6:120]'/12;
y=beta0+beta1*(1-exp(-mat/tau1))./(mat/tau1)+ ...
   beta2*((1-exp(-mat/tau2))./(mat/tau2) -exp(-mat/tau2));
dis=exp(-y.*mat);
mat2=[2 3 4 5 7 10]'; %year
swr=200*(1-dis)./cumsum(dis);
x2(5:10)=swr(mat2*2);

ev=x2-X;
err=ev'*ev;

