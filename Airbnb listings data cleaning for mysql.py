#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
df = pd.read_csv(r"D:\Training\Data Analysis\MySQL\Airbnb\listings.csv")
df


# In[2]:


df.drop(columns=['calculated_host_listings_count_entire_homes', 'listing_url', 'scrape_id', 'last_scraped', 'source', 'description', 'neighborhood_overview', 'picture_url', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_communication', 'review_scores_location', 'review_scores_value', 'license', 'instant_bookable', 'calculated_host_listings_count', 'review_scores_checkin', 'calculated_host_listings_count_private_rooms', 'calculated_host_listings_count_shared_rooms', 'host_url', 'host_since', 'host_location', 'host_about', 'host_response_time', 'host_response_rate', 'host_response_rate', 'host_response_rate', 'calendar_last_scraped', 'number_of_reviews', 'number_of_reviews_ltm', 'number_of_reviews_l30d', 'first_review', 'last_review', 'review_scores_rating', 'reviews_per_month', 'host_acceptance_rate',
       'host_is_superhost', 'host_thumbnail_url', 'host_picture_url',
       'host_neighbourhood', 'host_listings_count',
       'host_total_listings_count', 'host_verifications',
       'host_has_profile_pic', 'host_identity_verified', 'minimum_nights', 'maximum_nights', 'minimum_minimum_nights',
       'maximum_minimum_nights', 'minimum_maximum_nights',
       'maximum_maximum_nights', 'minimum_nights_avg_ntm',
       'maximum_nights_avg_ntm', 'calendar_updated', 'has_availability',
       'availability_30', 'availability_60', 'availability_90',
       'availability_365', 'neighbourhood', 'neighbourhood_group_cleansed', 'beds', 'amenities', 'bathrooms_text', 'property_type'], inplace=True)


# In[3]:


df


# In[4]:


df.columns


# In[5]:


df = df.drop_duplicates()


# In[6]:


pd.set_option('display.max_rows', None)


# In[7]:


df.dropna( subset=['price', 'bedrooms', 'bathrooms'], inplace=True)


# In[8]:


df[df.isna().any(axis=1)]


# In[9]:


df.info()


# In[10]:


df['bedrooms'] = df['bedrooms'].apply(lambda x: int(x))
df['price'] = df['price'].str.replace('$', '')
df['price'] = df['price'].str.replace(',', '')
df['price'] = df['price'].apply(lambda x: int(x[0:-3]))


# In[11]:


df


# In[12]:


my_list = ['name', 'host_name', 'neighbourhood_cleansed', 'room_type']
for i in my_list:
    df[i] = df[i].str.strip()


# In[13]:


df


# In[14]:


df[df.isna().any(axis=1)]


# In[15]:


df.columns


# In[30]:


df


# In[32]:


from sqlalchemy import create_engine
 
db_url = "mysql+mysqlconnector://{USER}:{PWD}@{HOST}/{DBNAME}"
db_url = db_url.format(
    USER = "root",
    PWD = "Farida1?",
    HOST = "localhost:3306",
    DBNAME = "airbnb_info"
)
engine = create_engine(db_url, echo=False)


# In[34]:


with engine.begin() as conn:
    df.to_sql(name='listings_1', con=conn, index=False)


# In[ ]:




