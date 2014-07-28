%  exam_midterm.m
%  calculations for Mar 05 exam
format compact 

disp('Problem 1')
disp('-------------------------------------------------------------') 
alpha = 1/3;
%  data 
%   1=year  2=y/l  3=k/l  4=h  [add 5=a]
chn =  [1985   2530  3011  4.9; 
        2000   6175  9190  6.4]; 
ind =  [1985   3546  3833  3.6; 
        2000   6216  6414  5.1]; 

%  growth rates
data = chn;
a = data(:,2)./(data(:,3).^alpha.*data(:,4).^(1-alpha));
TFP = a
data = [data a];

[nrow,ncol] = size(data);

years = (data(2:nrow,1)-data(1:nrow-1,1));
years = years(:,[ones(1,ncol-1)])
growth = log(data(2:nrow,2:ncol)./data(1:nrow-1,2:ncol))./years
share = [1 alpha 1-alpha 1];
share = share([ones(1,nrow-1)],:);
contrib = share.*growth

