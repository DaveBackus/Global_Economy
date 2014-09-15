"""
Expdenditure shares of GDP from the World Bank dataset (the NIPA part of 
World Development Indicators).  This works for any country, just enter the 
2-digit country code.  I access country and variable codes by downloading 
the whole dataset as csv and skimming through the csv's for countries
and variables.  

World Bank data codes 
General government final consumption expenditure (current LCU)	NE.CON.GOVT.CN
Household final consumption expenditure, etc. (current LCU)	NE.CON.PETC.CN
Household final consumption expenditure (current LCU)	NE.CON.PRVT.CN
Final consumption expenditure, etc. (current LCU)	NE.CON.TETC.CN
Final consumption expenditure (current LCU)	NE.CON.TOTL.CN
Gross national expenditure (current LCU)	NE.DAB.TOTL.CN
Exports of goods and services (current LCU)	NE.EXP.GNFS.CN
Gross fixed capital formation, private sector (current LCU)	NE.GDI.FPRV.CN
Gross fixed capital formation (current LCU)	NE.GDI.FTOT.CN
Changes in inventories (current LCU)	NE.GDI.STKB.CN
Gross capital formation (current LCU)	NE.GDI.TOTL.CN
Imports of goods and services (current LCU)	NE.IMP.GNFS.CN
External balance on goods and services (current LCU)	NE.RSB.GNFS.CN
GDP (current LCU)	NY.GDP.MKTP.CN
Discrepancy in expenditure estimate of GDP (current LCU)	NY.GDP.DISC.CN

http://web.worldbank.org/WBSITE/EXTERNAL/DATASTATISTICS/0,,contentMDK:20451590~isCURL:Y~menuPK:64133156~pagePK:64133150~piPK:64133175~theSitePK:239419~isCURL:Y~isCURL:Y,00.html

References 
* http://data.worldbank.org/
* 
* http://pandas.pydata.org/pandas-docs/stable/remote_data.html#world-bank
* http://quant-econ.net/pandas.html#data-from-the-world-bank

Prepared for the NYU Course "Global Economy" 
* https://sites.google.com/site/nyusternglobal/home 
* https://github.com/DaveBackus/Global_Economy 

Written by Dave Backus @ NYU, September 2014  
Created with Python 3.4 
"""
from pandas.io import wb
import matplotlib as mpl
import matplotlib.pylab as plt

# set plot parameters 
mpl.rcParams['figure.figsize'] = 6, 4.5  # default is 6, 4
mpl.rcParams['legend.fontsize'] = 10  
mpl.rcParams['legend.labelspacing'] = 0.25
mpl.rcParams['legend.handlelength'] = 3


"""
1. Read in GDP and expenditure components from World Bank  
"""
country_list  = ['FR']
variable_list = ['NE.CON.GOVT.CN', 'NE.CON.PETC.CN', 'NE.CON.PRVT.CN', 
                 'NE.CON.TETC.CN', 'NE.CON.TOTL.CN', 
                 'NE.DAB.TOTL.CN',                 
                 'NE.EXP.GNFS.CN', 'NE.GDI.FTOT.CN', 'NE.GDI.STKB.CN',
                 'NE.GDI.TOTL.CN', 'NE.IMP.GNFS.CN', 'NE.RSB.GNFS.CN', 
                 'NY.GDP.MKTP.CN', 'NY.GDP.DISC.CN']
df = wb.download(indicator=variable_list, country=country_list, 
                 start=1990, end=2014)

# simplify variable names 
# http://stackoverflow.com/questions/11346283/renaming-columns-in-pandas
nicknames = {'NE.CON.GOVT.CN': 'g', 'NE.CON.PETC.CN': 'c1', 
             'NE.CON.PRVT.CN': 'c2', 'NE.CON.TETC.CN': 'c3', 
             'NE.CON.TOTL.CN': 'c4',
             'NE.DAB.TOTL.CN': 'a', 'NE.EXP.GNFS.CN': 'x',  
             'NE.GDI.FTOT.CN': 'i', 'NE.GDI.STKB.CN': 'v', 
             'NE.GDI.TOTL.CN': 'gcf', 'NE.IMP.GNFS.CN': 'm',  
             'NE.RSB.GNFS.CN': 'nx', 
             'NY.GDP.MKTP.CN': 'y', 'NY.GDP.DISC.CN': 'disc'}
df = df.rename(columns=nicknames)

# note:  this sets up a hierarchical index over country and date
df.index

#%%
"""
2. Check that things add up 
All set as long as we include the statistical discrepancy 
"""

check_iv = df['i'] + df['v'] - df['gcf']            # ok 
check_nx = df['x'] - df['m'] - df['nx']             # ok

check_c1 = df['g'] + df['c1'] - df['c4']            # ok
check_c2 = df['g'] + df['c2'] - df['c4']            # exact 

check_a1 = df['c4'] + df['gcf'] - df['a']           # ok
check_a2 = df['c2'] + df['g'] + df['gcf'] - df['a'] # ok

check_y1 = df['c2'] + df['g'] + df['gcf'] + df['nx'] - df['y']  # ok
check_y2 = df['c2'] + df['g'] + df['gcf'] + df['nx'] + df['disc'] - df['y'] 

#%%
"""
3. Plot expenditure shares, saving and investment 
"""
# this creates new series -- ok or better way?  
cy  = df['c2']/df['y']
iy  = df['gcf']/df['y']
gy  = df['g']/df['y']
nxy = df['nx']/df['y']
sy  = (df['y']-df['c2']-df['g'])/df['y']

# WE NEED TO GET 'year' OUT OF THE INDEX 
# this works, but looks clunky to me 
df.index
df.index.names 
year    = df.index.get_level_values(1)
country = df.index.get_level_values(0)

# make a picture 
plt.figure() 
plt.plot(year, nxy, label='Net Exports')
plt.plot(year, iy, label='Investment')
plt.plot(year, cy, label='Consumption')
plt.plot(year, gy, label='Government')
plt.ylabel('Share of GDP') 
#plt.axis([1990, 2015, -0.1, 0.6])
plt.axhline(y=0, color='k', linestyle='-', linewidth=1)   
plt.legend(loc='best') 
plt.title(country[0] + ':  Expenditure Shares of GDP', loc='left', fontsize=14)
plt.savefig('shares_exp_'+ country_list[0] +'.pdf')

# another one  
plt.figure() 
plt.plot(year, nxy, label='Net Exports')
plt.plot(year, iy, label='Investment')
plt.plot(year, sy, label='Saving')
plt.ylabel('Share of GDP') 
#plt.axis([1990, 2015, -0.1, 0.6])
plt.axhline(y=0, color='k', linestyle='-', linewidth=1)   
plt.legend(loc='best') 
plt.title(country[0] + ':  Saving and Investment', loc='left', fontsize=14)
plt.savefig('shares_sav_'+ country_list[0] +'.pdf')

#%%
"""
4. Spencer's version 
Works great but (a) has to be changed if not France and (b) plots backwards
Also kill the x axis label, add y axis label  
"""
# add series to df 
df['Consumption'] = df['c2']/df['y']
df['Investment'] = df['gcf']/df['y']
df['Government'] = df['g']/df['y']
df['Net Exports'] = nxy = df['nx']/df['y']
df['Saving'] = (df['y']-df['c2']-df['g'])/df['y']
#df['year'] = df.index.get_level_index('year')


#%%
# define a resuseable plotting function
# by keeping the numbers in a df, the plot takes the df's parameters
def wb_plot(df, country, cols, title_str=None, save_str=None, **kwargs):
    """
    Quick function to plot specific columns for a particular country
    in the DataFrame obtained from the world bank

    Any additional keyword arguments are passed directly to the
    DataFrame.plot method

    Parameters
    ----------
    df : DataFrame
        The DataFrame that contains the data

    country : string
        A string specifying the name of the country. This must also be
        the entry on the outer level of the hierarchical index

    cols : list
        A list of column names to be plotted.

    title_str : optional(default=None)
        An optional title to be added to the plot. Note that you can
        leave a placeholder for country and it will automatically
        be filled for you with the country argument. An example of how
        this can be done is the following:

            title_str = '{country}: Expenditure Shares of GDP'

    save_str : optional (default=None)
        Similar to title_str, but provides the name the figure should be
        saved under. If none is given, then the figure is not saved. 

    Returns
    -------
    ax : matplotlib.pyplot.Axes
        The axes containing the plot

    """
    # return flat (non hierarchical-indexed) dataframe for a single country
    new_df = df.loc[country]
    new_df = new_df.sort()  # this corrects the order of dates 
    ax = new_df[cols].plot()
    ax.axhline(y=0, color='k', linestyle='-', linewidth=1)
    ax.legend(loc='best')

    if title_str is not None:
        ax.set_title(title_str.format(**{'country': country}))

    if save_str is not None:
        ax.get_figure().savefig(save_str.format(**{'country': country}))

    return ax


# Now generate the first figure
countryname = country[0] 

ax1 = wb_plot(df,
                country=countryname,
                cols=['Net Exports', 'Investment', 'Consumption', 'Government'],
                title_str='{country}:  Expenditure Shares of GDP',
#                save_str="shares_sav_%s.pdf" % country_list[0]
                )


ax2 = wb_plot(df,
                country=countryname,
                cols=['Net Exports', 'Investment', 'Saving'],
                title_str='{country}:  Saving and Investment',
#                save_str="shares_exp_%s.pdf" % country_list[0]
                )
