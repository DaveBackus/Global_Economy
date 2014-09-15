"""
Messing around with Oliver Sherouse's wbdata, which accesses all of the 
World Bank's data API's. This follows the documentation, link below.  

Not sure this is ready for primetime, but it could be me... 

References 
* http://datacatalog.worldbank.org/
* http://blogs.worldbank.org/opendata/accessing-world-bank-data-apis-python-r-ruby-stata
* https://github.com/OliverSherouse/wbdata/blob/master/docs/source/index.rst 

Prepared for the NYU Course "Global Economy" 
* https://sites.google.com/site/nyusternglobal/home 
* https://github.com/DaveBackus/Global_Economy 

Written by Dave Backus @ NYU, September 2014  
Created with Python 3.4 
"""
import wbdata 

wbdata.get_source()
wbdata.get_indicator(source=15)
d   = wbdata.get_data('IC.BUS.EASE.XQ', country='USA')

indicators = {'IC.BUS.EASE.XQ': 'Ease', 'IRSPREAD': 'Spread'}
df1 = wbdata.get_dataframe(indicators, data_date=(2012, 2013), country='ARG')
#df2 = wbdata.get_dataframe('IRSPREAD', country='all', convert_date=True)

#%%
