%  slides_growth3.m
%  growth accounting calculations for class
alpha = 1/3;

%  data 
%   1=year  2=y/l  3=k/l  4=h  [add 5=a]
usa = [1961	30260.204	57624.06	8.61;
       2000	64536.696	138910.8	12.05];
kor = [1961	4576.2349	11649.21	4.478;
       2000	36850.075	103945.1	10.84];
jpn = [1961	8577.1087	28661.97	7.742;
       1973	21313.875	48532.41	7.648;
       1990	35078.504	102396.8	8.96;
       2000	38737.141	143519.8	9.47];
irl = [1961	13740.265	30688.63	6.426;
       1987	29722.474	59082.09	8.174;
       2000	65053.411	98694.66	9.35];
chn = [1961	1185.6063	1784.42   4.000;
       1978	1705.9946	2220.649	4.608;
       2000	6174.8429	9189.572	6.35];

%  growth rates
data = jpn;
a = data(:,2)./(data(:,3).^alpha.*data(:,4).^(1-alpha));
data = [data a];

[nrow,ncol] = size(data);

years = (data(2:nrow,1)-data(1:nrow-1,1));
years = years(:,[ones(1,ncol-1)])
growth = log(data(2:nrow,2:ncol)./data(1:nrow-1,2:ncol))./years
share = [1 alpha 1-alpha 1];
share = share([ones(1,nrow-1)],:);
contrib = share.*growth

