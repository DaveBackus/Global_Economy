%  proj4_07.m 
%  Calculations for Group Project #4, Global Economy, Spring 2007
%  Also used as Proj 2 for EMBA A08
% -----------------------------------------------------------------------------------
format compact
format long  

disp('------------------------------------------------------------------')
disp('Growth in Arg and Chile') 
%      1=year  2=POP  3=L  4=Y/POP  5=K/POP 
arg = [1960 20.6 8.1 7838 12713;
       2004 39.1 16.2 10939 24343];
chl = [1960 7.59 2.55 5086 16666;
       2004 15.67 6.57 12678 29437];
data = chl; 
    
disp('(a)')
year = data(:,1);
YP = data(:,4);
growth = log(YP(2)/YP(1))/(year(2)-year(1))
LPOP = data(:,3)./data(:,2);
YL = data(:,2).*data(:,4)./data(:,3);
growth = log(YL(2)/YL(1))/(year(2)-year(1))

%return 

disp('(b)') 
KL = data(:,5)./LPOP
A = YL./KL.^(1/3)

newdata = [YP LPOP A KL]
growth = log(newdata(2,:)./newdata(1,:))/(year(2)-year(1))
share = [1 1 1 1/3];
contribution = share.*growth

return 


disp('------------------------------------------------------------------')
disp('Japan-Korea level comparison') 
%     1=POP  2=Y/POP  3=L/POP  4=K/Y  5=Educ  6=hours 
data = ...
  [127.7 24036 0.534 4.003 9.6 1801; ... 
    47.5 17600 0.494 1.608 11.0 2434]; 

disp(' ') 
disp('(a)') 
YPC = data(:,2);
YPCrat = YPC(1)/YPC(2);
YPC = [YPC; YPCrat];

YPW = data(:,2)./data(:,3);
YPWrat = YPW(1)/YPW(2);
YPW = [YPW; YPWrat];

YPH = data(:,2)./(data(:,3).*data(:,6));
YPHrat = YPH(1)/YPH(2);
YPH = [YPH; YPHrat];

[YPC YPW YPH]

disp(' ')
disp('(b)') 

LP = data(:,3);
LPrat = LP(1)/LP(2)
LP = [LP; LPrat]

%return

KL = data(:,4).*data(:,2)./data(:,3); 
KLrat = KL(1)/KL(2); 
KL = [KL; KLrat] 

%return 

h = data(:,6);
hrat = h(1)/h(2); 
h = [h; hrat]

YL = YPW;
A = YL./(h.^(2/3).*KL.^(1/3))
Arat = A(3);

components = [LPrat Arat KLrat^(1/3) hrat^(2/3)]
product = cumprod(components);
check = product(4)
YPCrat

%return 

