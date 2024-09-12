#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
from bs4 import BeautifulSoup
import requests


# In[2]:


url = r"https://www.jumia.com.ng/baby-bath-toys/"
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Avast/127.0.0.0", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}
retrieve = requests.get(url, headers=headers)
soup = BeautifulSoup(BeautifulSoup(retrieve.content, 'html.parser').prettify(), "html.parser")


# In[3]:


title = []
price = []
ratings = []
shipped_from = []


# In[4]:


while (url != 'nil'):
    info = soup.find_all('div', class_='info')
    for items in info:
        title.append(items.find('h3', class_='name').text.strip())
        price.append(items.find('div', class_='prc').text.replace('₦', '').replace(',', '').strip())
        if items.find('div', class_='bdg _glb _xs') is None:
            shipped_from.append('Nigeria')
        else:
            shipped_from.append('Abroad')
        if items.find('div', class_='rev') is None:
            ratings.append('nil')
        else:
            ratings.append(items.find('div', class_='rev').find('div', class_='stars _s').text.strip())
    url = 'nil'
    for link in soup.find_all('a', href=True, class_='pg'):
        if link['aria-label'] == 'Next Page':
            url = 'https://www.jumia.com.ng' + link['href']
    if (url == 'nil'):
        break
    retrieve = requests.get(url, headers=headers)
    soup = BeautifulSoup(BeautifulSoup(retrieve.content, 'html.parser').prettify(), "html.parser")


# In[5]:


df = pd.DataFrame({'Product':title, 'Price':price, 'Shipped_from':shipped_from, 'Ratings':ratings})


# In[6]:


df.to_csv(r"D:\Training\Data Analysis\Python\Jumia_scraping_project.csv", index=False)

