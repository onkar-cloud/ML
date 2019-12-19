#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 17 16:27:02 2018

@author: ghuiii
"""

#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 16 18:46:59 2018

@author: ghuiii
"""
import pandas as pd
from numpy import *
import matplotlib.pyplot as  plt
from scipy.spatial import distance
from scipy.spatial.distance import cdist
data = pd.read_csv("/nfs/cms/mtech17/onkar.ranade/Iris.csv")
data = data.iloc[:,1:5].values
cluster = [data[0]]
indx= []

while(len(cluster) < 50):    
    d = cdist(data,data)[0][1:]
    ind=argmin(d) + 1
    
    indx.append(ind)
    cluster.append(data[ind])
    data = delete(data,ind, axis=0)
    data[0]=mean(cluster,axis=0)

from scipy.cluster.hierarchy import linkage, dendrogram
l = linkage(cluster,"ward")
#
num = []
for i in cluster:
    no = where(data == i)
    num.append(no)

#distanc = []
#new_cluster_1 = []
#
#for i in range(0,len(data)):
#    clus = data[i]
#    cluster.append(clus)
#    
##print(cluster)
#cluster_1 = cluster[0]
#new_cluster_1.append(cluster_1)
#
#for j in range(0,len(cluster)):
#    dist = distance.euclidean(cluster[0],cluster[j])
#    #print(dist)
#    distanc.append(dist)
#    #cluster.append(clus)
#
#distanc = array([distanc])
#index = 0
#distanc = delete(distanc,index)
##print(distanc)
##print(min(distanc))
#nn = where(distanc == min(distanc))
##print(nn)
##print(cluster[16])
#new_cluster_1.append(cluster[16])
#print(new_cluster_1)
#
#
#
##sorted_distance = sort(distanc)
##index = [0]
##sorted_distance = delete(sorted_distance,index)
##print(sorted_distance)
#
##min_dist = 