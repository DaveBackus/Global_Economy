%  slides_labor1.m
%  labor comparison of US and France 
%  this version:  uses GLC's PWT 6.2 summary
alpha = 1/3;
format long

%  data 
%  cols:   1=year  2=pop  3=y/pop  4=y/l  5=k/pop  6=h 
%  rows:   1=usa  2=fra   
data = [2003	292616.6	34875.372	67865.442	90962.43 1806;
        2003	60008.13	25663.665	56908.962	75146.22 1532];

year = data(:,1);
pop = data(:,2);
ypop = data(:,3);
yl = data(:,4);
lpop = data(:,3)./data(:,4);
kl = data(:,5)./lpop;

disp('year ypop yl  lpop kl')
newdata = [year ypop yl lpop kl]
ratio = newdata(1,:)./newdata(2,:)
logratio = log(ratio)


% output per hour
h = data(:,6);
yh = yl./h
kh = kl./h
a = yh./(kh.^alpha) 

clear newdata
newdata = [yh kh a h]
ratio = newdata(1,:)./newdata(2,:)
ratio(:,2) = ratio(:,2).^alpha
logratio = log(ratio)
