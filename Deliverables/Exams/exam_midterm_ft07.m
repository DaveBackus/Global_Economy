%  quiz1_emba_a08.m
%  growth accounting calculations for class
%  this version:  uses GLC's PWT 6.2 summary
alpha = 1/3;
format compact 
format long g

%  data 
%     1=year  2=pop  3=y/pop  4=y/l  5=k/pop 
bra  = [1950	53443.075	1801.9926	5045.4745	3056.858;
        1980	122958.13	6775.6352	17284.784	15312.93;
        2003	182032.6	7204.938	15461.572	17523.04];

%  ratios 
data = bra;
year = data(:,1);
pop = data(:,2);
ypop = data(:,3);
y = ypop.*pop;
yl = data(:,4);
lpop = data(:,3)./data(:,4);
kl = data(:,5)./lpop;
a = yl./(kl.^alpha);
data = [year ypop yl kl a y]

[nrow,ncol] = size(data);   

%return 

% growth rates 

years = (data(2:nrow,1)-data(1:nrow-1,1));
years = years(:,[ones(1,ncol-1)]);
growth = log(data(2:nrow,2:ncol)./data(1:nrow-1,2:ncol))./years
share = [0 1 alpha 1 0];
share = share([ones(1,nrow-1)],:);
contrib = share.*growth

return