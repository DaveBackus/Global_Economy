%  exam_midterm.m
%  calculations for Mar 06 exam
format compact
format long

disp('Problem 1')
disp('-------------------------------------------------------------') 
%  data 
%     1=year  2=y/l  3=k/l  4=l   5=pop  6=h 
arg =  [1990 20564  58666  11.4  32.5  8.1; 
        2000 25670  50514  15.9  37.0  8.8];
chl =  [1990 16984  22950  4.8   13.1  7.0; 
        2000 25084  38488  6.0   15.2  7.6]; 
data = chl;             % one country at a time 
alpha = 1/3;

% GDP pc and TFP 
gdppc = data(:,2).*data(:,4)./data(:,5)
a = data(:,2)./(data(:,3).^alpha.*data(:,6).^(1-alpha)) 
part = data(:,4)./data(:,5)
data = [data(:,1) data(:,2) a data(:,3) data(:,6)];

%  growth rates (allows for multiple subperiods, not relevant here) 
[nrow,ncol] = size(data);
years = (data(2:nrow,1)-data(1:nrow-1,1));  % length of subperiods
years = years(:,[ones(1,ncol-1)]);
growth = log(data(2:nrow,2:ncol)./data(1:nrow-1,2:ncol))./years
share = [1 1 alpha 1-alpha];
share = share([ones(1,nrow-1)],:);
contrib = share.*growth

