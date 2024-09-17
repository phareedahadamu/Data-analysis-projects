#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
df = pd.read_csv(r"D:\Training\Data Analysis\MySQL\Airbnb\calendar.csv")
df


# In[2]:


df.drop_duplicates()


# In[3]:


df.drop(columns=['adjusted_price', 'minimum_nights', 'maximum_nights'], inplace=True)


# In[4]:


df.dropna(subset=['listing_id', 'price'], inplace=True)


# In[5]:


df.head(100)


# In[6]:


df['price'] = df['price'].str.replace(',', '')
df['price'] = df['price'].apply(lambda x: int(x[1:-3]))


# In[7]:


df.head(100)


# In[8]:


df.info()


# In[9]:


df['date'] = pd.to_datetime(df['date'])


# In[10]:


df


# In[11]:


df.isna().any().sum()


# In[12]:


from sqlalchemy import create_engine
 
db_url = "mysql+mysqlconnector://{USER}:{PWD}@{HOST}/{DBNAME}"
db_url = db_url.format(
    USER = "root",
    PWD = "Farida1?",
    HOST = "localhost:3306",
    DBNAME = "airbnb_info"
)
engine = create_engine(db_url, echo=False)


# In[13]:


with engine.begin() as conn:
    df.to_sql(name='calendar', con=conn, index=False)


# In[ ]:




