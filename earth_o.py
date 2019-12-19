#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 10 00:56:42 2018

@author: onkar
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep  4 19:05:15 2018

@author: onkar
"""

import numpy as np
import matplotlib.pyplot as plt
#sfrom matplotlib import mplot3d
from scipy.integrate import odeint
from numpy.linalg import *

def f(y, t):
    """Integration of the governing vector differential equation.
    d2r_dt2 = -(mu/R^3)*r with d2r_dt2 and r as vecotrs.
    Initial position and velocity are given.
    y[0:2] = position components
    y[3:] = velocity components"""

    G = 6.674*(10**-11)
    E = 5972.e21
    S = 1989.e27
    
#    E = 500
#    S = 1000
#    R = 50
    p_e,  p_s, v_e,v_s = y.reshape(4,2)
    r_es = p_e - p_s
    
    dy0 = v_e
    dy2 = v_s
    a = +(G*S / (norm(r_es)**3)) * (r_es)
    
    c = (G*E / (norm(r_es)**3)) * (-r_es)
    dv = np.array([dy0,dy2,-a,-c])
    return np.reshape(dv,8)

p_e = np.array([0., 0.])
p_s = np.array([149.e9, 0.])
v_e = np.array([1000., 2000.])
v_s = np.array([0., 0.])
y_init = np.array([p_e,p_s, v_e,v_s])
#y_init = [400., 0., 20., 5., 2000., 0., 1., 8., 7., 5., 0., 0.]
t = np.arange(0, 11100000, 10)
sol = odeint(f, np.reshape(y_init, 8), t)

fig = plt.figure(1, figsize=(8,8))

plt.plot(sol[:,2], sol[:,3],"*")
plt.plot(sol[:,0],sol[:,1])
plt.show()