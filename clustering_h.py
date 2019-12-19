
import pandas as pd
from numpy import *
import matplotlib.pyplot as  plt
from scipy.spatial import distance_matrix, distance
from scipy.spatial.distance import cdist

data = pd.read_csv("/nfs/cms/mtech17/onkar.ranade/Iris.csv")
data = data.iloc[:,1:5].values

#dd = distance_matrix(data,data).tolist()
#d = []
#for i in range(len(dd)-1):
#    d.append(dd[i][(i+1):])
#
#md_ind = []
#md = []
#for i in range(len(dd)-2):
#    md_ind.append([(i),argmin(d[i])+1])
#    md.append(amin(d[i]))

#print(argmin(d))
#d=md[0][1:]
#n = where(min(d))[0] + 1


new_cl = []
while(len(data) > 0):
    distnc = cdist(data,data)
    distnc[where(distnc == 0)] = inf
    ik = distnc.argmin(axis=0)
    mk = distnc.min(axis=0)
    indx = where(mk==min(mk))
    print(indx)
    new_cl.append(data[indx])
    data = delete(data,indx,axis=0)
