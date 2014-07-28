%  Yield curve plots for intro slides 
%  Global Economy, Jan 2006 
%  Data:  zero rates from Datastream 
%  Written by:  Dave Backus 
format compact 

mats = [ [1 3 6 9]/12 1 2 3 4 5 6 7 8 9 10];
% euro rates 
y0 = [2.4472	2.5797	2.7031	2.7972	2.8744	3.0639	3.157	3.2279	3.2879	3.34	3.3948	3.4509	3.5032	3.5517];
y1 = [2.4802	2.5477	2.6686	2.7684	2.8423	3.0034	3.0874	3.1563	3.2184	3.277	3.3329	3.3923	3.4537	3.5114];
y6 = [2.1562	2.1708	2.1747	2.1895	2.2161	2.3688	2.527	2.6909	2.8451	2.9876	3.1223	3.2472	3.3595	3.4598];
y12 = [2.1583	2.1916	2.2292	2.2816	2.3405	2.578	2.7828	2.9569	3.1136	3.2588	3.3942	3.5174	3.6269	3.7219];
% dollar rates, 1/20/06 
y0 = [4.6589	4.736	4.8329	4.8655	4.8768	4.8508	4.8188	4.8304	4.8529	4.8699	4.8929	4.9103	4.9279	4.9524];
y1 = [4.4791	4.6205	4.7703	4.8447	4.8768	4.9284	4.9335	4.9606	4.9825	5.0048	5.0155	5.0329	5.0569	5.0813];
y6 = [3.5021	3.6998	3.9514	4.055	4.1159	4.3235	4.3962	4.4598	4.5192	4.5684	4.6128	4.6524	4.6928	4.7343];
y12 = [2.554	2.7347	2.9414	3.1146	3.2647	3.6219	3.836	4.0053	4.1535	4.2857	4.4028	4.5131	4.6178	4.7099];
% yen rates, 1/20/06 
y0 = [0.0106	0.0304	0.07102	0.071	0.1216	0.3407	0.5448	0.7504	0.9397	1.118	1.2746	1.4116	1.5341	1.6444];
y1 = [0.0103	0.0406	0.06079	0.0709	0.1216	0.3457	0.5549	0.7656	0.9705	1.1594	1.3294	1.4693	1.5893	1.6941];
y6 = [0.02	0.0202	0.04046	0.0507	0.0608	0.1627	0.2806	0.4193	0.5716	0.7379	0.9086	1.0707	1.2243	1.3636];
y12 = [0.0106	0.01	0.02026	0.0203	0.0405	0.1677	0.2957	0.4572	0.6301	0.8122	0.9964	1.1697	1.3265	1.4635];

FontSize=16;
FontName='Times' %'Helvetica'  % or 'Times' 
LineWidth=2
h = figure(1)
clf 
plot(mats,y0,'LineWidth',LineWidth,'Color','b','LineStyle','-')
hold on 
plot(mats,y6,'LineWidth',LineWidth,'Color','b','LineStyle','--')
plot(mats,y12,'LineWidth',LineWidth,'Color','b','LineStyle','-.')
ylabel('Yield to Maturity (Annual Percent)','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity in Years','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

%print -depsc slides_intro_usdr.eps
print -depsc slides_intro_jpyr.eps
%print -depsc slides_intro_eurr.eps

return








