%  proj4.m 
%  Calculations for Group Project #4, Global Economy, Spring 2006
% -----------------------------------------------------------------------------------
format compact
format short 

disp('------------------------------------------------------------------')
disp('US-France comparison') 
%     GDP    K     L     Hrs  Educ   Pop 
data = ...
  [1594  5707  24.52 1453 11.9  59.76; ... 
  10282 28278 140.48 1792 13.8 290.81]; 
    
%    [1351  3852  27.50  1500  7.86  59.30; ...
%     9169 19600 142.08  1827 12.05 285.00]; 

disp('(a)') 
YPC = data(:,1)./data(:,6);
YPCrat = YPC(1)/YPC(2);
YPC = [YPC; YPCrat];

YPW = data(:,1)./data(:,3);
YPWrat = YPW(1)/YPW(2);
YPW = [YPW; YPWrat];

YPH = data(:,1)./(data(:,3).*data(:,4));
YPHrat = YPH(1)/YPH(2);
YPH = [YPH; YPHrat];

[YPC YPW YPH]

disp(' ')
disp('(b)') 

LP = data(:,3)./data(:,6)
LPrat = LP(1)/LP(2)
LP = [LP; LPrat]

A = data(:,1)./(data(:,2).^(1/3).*(data(:,3).*data(:,4).*data(:,5)).^(2/3));
Arat = A(1)/A(2);
A = [A; Arat]

KL = data(:,2)./data(:,3)
KLrat = KL(1)/KL(2)
KL = [KL; KLrat]

H = data(:,5);
Hrat = H(1)/H(2); 
H = [H; Hrat]

h = data(:,4);
hrat = h(1)/h(2); 
h = [h; hrat]

components = [LPrat Arat KLrat^(1/3) Hrat^(2/3) hrat^(2/3)]
product = cumprod(components);
check = product(5)
YPCrat

%return 

disp('------------------------------------------------------------------')
disp('Growth in Korea') 
%       year  GDP/POP   POP        K        L      H 
data = [1961    1542   25.982  102.2349   8.756   4.25;
        2000   15876   47.275  2117.083   20.367  10.84];
    
disp('(a)')
year = data(:,1);
YP = data(:,2);
LPOP = data(:,5)./data(:,3);
YL = data(:,2).*data(:,3)./data(:,5);
growth = log(YL(2)/YL(1))/39

disp('(b)') 
KL = data(:,4)./data(:,5)
H = data(:,6);
A = YL./(KL.^(1/3).*H.^(2/3))

newdata = [YL A KL H YP LPOP]
growth = log(newdata(2,:)./newdata(1,:))/(year(2)-year(1))
share = [1 1 1/3 2/3 1 1];
contribution = share.*growth

%return 

disp('------------------------------------------------------------------')
disp('Growth in China') 
%         Y     K      L
data = [5592  22276   747.36;         % China
        10761 31672   141.93];        % US
country = 1;  % 1=China, 2=US
    
disp('(a)') 
A = data(:,1)./(data(:,2).^(1/3).*data(:,3).^(2/3))

% parameters 
periods = 30;
alpha = 1/3;            % Capital share
delta = [0.06; 0.06];   % Depreciation rate
s = [0.22; 0.2];        % Saving rate
n = [0.01; 0.005];      % Employment growth 
a = [0.04; 0.02];       % TFP growth 


capital = zeros(periods,1);  % Capital Stock
prod    = zeros(periods,1);  % TFP 
output  = zeros(periods,1);  % Output
employ  = zeros(periods,1)   % Employment
date    = zeros(periods,1);  % Time

%  initializations 
date(1) = 2004;
capital(1) = data(country,2); 
employ(1) = data(country,3);
prod(1) = A(country);
output(1) = prod(1)*capital(1)^alpha*employ(1)^(1-alpha);

for i=2:periods
   date(i)=date(i-1)+1;
   employ(i) = (1+n(country))*employ(i-1);
   prod(i) = (1+a(country))*prod(i-1);
   capital(i) = capital(i-1)*(1-delta(country)) + s(country)*output(i-1);  
   output(i) = prod(i)*capital(i)^alpha*employ(i)^(1-alpha);
end

disp('   Date     Output    Employment    Prod') 

[date output employ prod]

return