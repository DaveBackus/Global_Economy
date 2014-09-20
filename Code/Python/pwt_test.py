"""
Penn World Table:  read in the whole thing, make some plots.  

References 
* http://www.rug.nl/research/ggdc/data/penn-world-table
* http://www.rug.nl/research/ggdc/data/pwt/v80/pwt80.xlsx
* http://stackoverflow.com/questions/10240289/how-to-fetch-a-file-from-a-url

Prepared for the NYU Course "Global Economy" 
* https://sites.google.com/site/nyusternglobal/home 
* https://github.com/DaveBackus/Global_Economy 

Written by Dave Backus @ NYU, September 2014  
Created with Python 3.4 
"""
import pandas as pd

"""
1. Read in PWT from downloaded spreadsheet 
"""
pwt = pd.read_excel('pwt80.xlsx', sheetname='Data') 
print(pwt.head(2))

