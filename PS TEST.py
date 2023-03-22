#!/usr/bin/env python
# coding: utf-8

# In[2]:


import numpy as np 
import matplotlib.pyplot as plt
import math 
import seaborn as sns
import pandas as pd


# In[3]:


BARRIOS = pd.read_csv(r'C:\Users\geosh\Documents\peoplesoft_test\exa_barrios.csv')
DISPOSITIVOS = pd.read_csv(r'C:\Users\geosh\Documents\peoplesoft_test\exa_dispositivos.csv')
CLIENTES = pd.read_csv(r'C:\Users\geosh\Documents\peoplesoft_test\exa_trx_clientes.csv')



# In[4]:


DISPOSITIVOS


# In[5]:


BARRIOS


# In[6]:


CLIENTES


# In[7]:


NEWDF = pd.merge(DISPOSITIVOS, BARRIOS, on='id_barrio')
NEWDF


# In[8]:


TRANSACCIONES = pd.merge(NEWDF, CLIENTES, on=['codigo_dispositivo','tipo_dispositivo' ])
TRANSACCIONES


# In[10]:


TRANSACCIONES['tipo_dispositivo'].value_counts()


# In[11]:


TRANSACCIONES['nombre_barrio'].value_counts()


# In[15]:


TRANSACCIONES['num_cliente'].nunique(dropna=True)


# In[16]:


TRANSACCIONES.to_excel("TRANSACCIONES.xlsx",
             sheet_name='TABLA')  


# In[17]:


CALCULO = 0.51*159433327802087


# In[18]:


CALCULO


# In[ ]:




