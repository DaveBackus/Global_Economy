%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% liborcurve.m
% Smooth a spot rate curve from libor and swap rates
% Method: Extened Nelson-Sieghel
% Liuren Wu, 10/23/2000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%clear all
close all

tol=1e-9; 
fopt=optimset('Display','off','MaxIter',5e4,'MaxFunEvals',5e4,'TolX', tol, ...
   'TolFun', tol);


%Data:Libor 1,3,6,12; swap rates: 2,3,4,5,7,10
% 87/4/1--00/10/17
load d:\btw\libor\liborusd2.txt
rates=liborusd2;
[nobs, nvars]=size(rates)
matsome=[[1 3 6 12]/12 [2 3 4 5 7 10]]';
par=[  0.0823   -0.0260   -0.9263    0.9581    1.1202 ];
par=[0.1005   -0.0337   -0.0095    1.6588    0.5570];
errv=zeros(nobs,1);
%parv=zeros(nobs,5);
load parvpusd2.txt
parv=parvpusd2;
for i=2950:2955
   X=rates(i,2:nvars)';date1=rates(i,1);
   par=parv(i,:);
   err=swapens2(par,X,date1)
   temp=i
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   %Graphical check
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
figure(1)
plot(matsome, X, 'o',matsome, x2,'--',mat,y*100)
pause
end

return
complete1=[i round(100*i/nobs)]
   par=fminsearch('swapens2',par,fopt,X,date1);
   err=swapens2(par,X,date1)
   if err>0.05
      par=[0.1005   -0.0337   -0.0095    1.6588    0.5570];
      par=fminsearch('swapens2',par,fopt,X,date1);
      err=swapens2(par,X,date1)
   end 
   parv(i,:)=par;
   errv(i)=err;

end


save errv2.txt errv  -ascii -double
save parvpusd2.txt parv  -ascii -double
parvpusd=parv;

%change the date and separate files
date1=rates(:,1);
date2=x2mdate(date1);
nobs=length(date2);
begn=nweekdate(1,4,1987,4); %1987/4/01, first Wednesdsy
endn=nweekdate(2,4,2000,10); %2000/10/11

date3=[begn:7:endn]';
indv=date3;
nobsw=length(date3);it1=0;it2=0;
for i=1:nobsw
   ind=find(date2==date3(i));
   if ~(ind>0)
      ind=find(date2==date3(i)-1)
      it1=it1+1;
      if ~(ind>0)
         ind=find(date2==date3(i)+1)
         it2=it2+1;
         if ~(ind>0)
            disp('Manual Check');
            break
         end 
      end
      date3(i)=date2(ind);
   end
   indv(i)=ind;
end
   
%it1=it2=0; We have all wednesdays as business days.   
it=0;
for YY=1987:2000
   for MM=1:12
      tdate=lbusdate(YY,MM);
      if (tdate>=begn)&(tdate<date2(nobs))
         it=it+1;
         ind=find(date2==tdate);
         if ~(ind>0)
            ind=find(date2==tdate-1)
         end
         date4(it)=date2(ind);
         ind4(it)=ind;
      end
   end
end

         
    
   
%   load parvpusd.txt
   usddaily=[date2 parvpusd];
   usdweekly=[date3 parvpusd(indv,:)];
   usdmonthly=usdweekly(1:4:nobsw,:);
   usdmonthly2=[date4' parvpusd(ind4',:)];
   
   
   save usddaily.txt usddaily  -ascii -double
save usdweekly.txt usdweekly  -ascii -double
save usdmonthly.txt usdmonthly  -ascii -double
save usdmonthly2.txt usdmonthly2  -ascii -double


return
%There are a couple fishy days that we may want to fix later.