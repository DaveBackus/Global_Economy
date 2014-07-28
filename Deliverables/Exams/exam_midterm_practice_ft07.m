%  quiz1_practice_emba_a08.m
%  growth accounting calculations for class
%  this version:  uses GLC's PWT 6.2 summary
alpha = 1/3;
format compact 
format long g

%  data 
%     1=year  2=pop  3=y/pop  4=y/l  5=k/pop 6 = h
chn = [1985 1054727.5	1131.8372	1986.0278	2476.009	4.94;
       2003	1286975.5	4969.6449	8283.8461	10807.67	6.494];
ind = [1985	762384.04	1580.3678	3673.9924	1846.262	3.64
       2003	1049700.1	2990.0714	6724.5506	3509.067	5.384];
    
%  growth rates
data = ind;
year = data(:,1);
yl = data(:,4);
lpop = data(:,3)./data(:,4);
kl = data(:,5)./lpop;
a = yl./(kl.^alpha);
h = data(:,6)
data = [year yl kl a h]

[nrow,ncol] = size(data);   

years = (data(2:nrow,1)-data(1:nrow-1,1));
years = years(:,[ones(1,ncol-1)]);
growth = log(data(2:nrow,2:ncol)./data(1:nrow-1,2:ncol))./years
share = [1 alpha 1 0];
share = share([ones(1,nrow-1)],:);
contrib = share.*growth

