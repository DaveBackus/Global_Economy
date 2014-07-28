%  ps1
%  Problem Set 1, 2005 
%  Problem 2:  prices indexes 
format compact
format long

p = [10 22 90; 10 7 120];
q = [100 10 80; 110 120 100];

pq = p.*q;
ngdp = sum(pq,2)

p0 = p(1,:);
p0big = [p0; p0];
p0q = p0big.*q;
rgdp = sum(p0q,2)

deflator = 100*ngdp./rgdp

q0 = q(1,:);
q0big = [q0; q0]
pq0 = p.*q0big;
cpi = sum(pq0,2)
cpibase = 100*cpi/cpi(1)

rgdpc = ngdp./cpi

table = [ngdp, rgdp, deflator, cpi, rgdpc]
growth = 100*((table(2,:)./table(1,:)) - 1)
anngrowth = 100*((table(2,:)./table(1,:)).^(1/7) - 1)

