#!/usr/bin/env python
# coding: utf-8

# In[1]:


### Movie rating cleaning project
import pandas as pd
df = pd.read_csv(r"D:\Training\Data Analysis\Python\movies.csv")
df


# In[2]:


df.drop(columns=['RunTime', 'Gross', 'ONE-LINE', 'STARS'], inplace=True)
pd.set_option('display.max_rows', None)


# In[3]:


df.dropna(subset='RATING', ignore_index=True, inplace=True)
df


# In[4]:


df['MOVIES'] = df['MOVIES'].str.strip()
df


# In[5]:


df.drop_duplicates(ignore_index=True, inplace=True)
df


# In[6]:


test = df[df['MOVIES'].duplicated()==True].sort_values(['MOVIES', 'VOTES'], ascending = [True, False]).groupby('MOVIES').VOTES.agg('max')
test
#for j in test.index:
    #print(test[j])


# In[7]:


for i in test.index:
    #print(df[df['MOVIES']== i].index)
    for j in df[df['MOVIES']== i].index:
        if df['VOTES'][j] != test[i]:
            df.drop(index=j, inplace=True)


# In[8]:


df.drop_duplicates(inplace=True, subset='MOVIES')


# In[9]:


df[df['MOVIES'].duplicated()==True].sort_values(['MOVIES', 'VOTES'], ascending = [True, False])


# In[10]:


df


# In[11]:


category= []
for year in df['YEAR']:
    if ('–' in year):
        category.append('Series')
    else:
        if (year == 'nil'):
            category.append('Unknown')
        else:
            category.append('Movie')


# In[12]:


df["Category"] = category
df


# In[13]:


df['GENRE'] = df['GENRE'].fillna('nil')


# In[14]:


df[df['GENRE'].isna() == True]


# In[15]:


df


# In[16]:


#df[df['GENRE'].isna() == True]
df['GENRE'] = df['GENRE'].str.strip()
#df['GENRE'].apply(lambda x: [x.split(',')])
#for i in df.index:
    #df.loc[i, 'GENRE'] = df.loc[i, 'GENRE'].split(', ')
df


# In[17]:


df['YEAR'] = df['YEAR'].str.replace('[^0-9]', ' ', regex=True)
df['YEAR'] = df['YEAR'].str.strip()
df['YEAR'] = df['YEAR'].str.replace(' ', '-')


# In[18]:


df


# In[19]:


start_year = []
for i in df['YEAR']:
    if (i.split('-') is None):
        start_year.append(i)
    else:
        start_year.append(i.split('-')[0])

df['Start_year'] = start_year
df


# In[20]:


end_year = []
for i in df.index:
    if (df['Category'][i] == 'Movie'):
        end_year.append('nil')
    else:
        if (len(df['YEAR'][i].split('-')) < 2):
           end_year.append('Running')
        else:
            end_year.append(df['YEAR'][i].split('-')[1])
            #print(df['YEAR'][i])
df['End_Year'] = end_year
df


# In[21]:


df['VOTES'] = df['VOTES'].str.replace(',', '')
df['VOTES'] = df['VOTES'].apply(lambda x: int(x))
df.info()


# In[22]:


df


# In[23]:


df.to_csv(r'D:\Training\Data Analysis\Python\cleaned_movies.csv', index=False)


# In[24]:


#x = 0
#for i in df['GENRE']:
    #for j in i.split(', '):
       # if (j == 'Crime'):
           # x = x + 1
#print(x)

