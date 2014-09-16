"""
Penn World Table:  direct input of the whole thing from the url.  
And some plots.  

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
import urllib.request

"""
1. Read in PWT 
"""
url = 'http://www.rug.nl/research/ggdc/data/pwt/v80/pwt80.xlsx'
response = urllib.request.urlopen(url)
data = response.read() 
