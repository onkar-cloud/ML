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
    E = (5972.e21)/1000000000.
    S = (1989.e27)/1000000000.
    R = 1.e-6
#    E = 500
#    S = 1000
#    R = 50
    p_e, p_r, p_s, v_e,v_r,v_s = y.reshape(6,2)
    r_er = p_e - p_r
    r_es = p_e - p_s
    r_rs = p_r - p_s
    
    dy0 = v_e
    dy1 = v_r
    dy2 = v_s
    a = (G*R / (norm(r_er)**3)) * (r_er) +(G*S / (norm(r_es)**3)) * (r_es)
    b = (G*E / (norm(r_er)**3)) * (-r_er) +(G*S / (norm(r_rs)**3)) * (r_rs)
    c = (G*E / (norm(r_es)**3)) * (-r_es) +(G*R / (norm(r_rs)**3)) * (-r_rs)
    dv = np.array([dy0,dy1,dy2,-a,-b,-c])
    return np.reshape(dv,12)

p_e = np.array([0., 0.])
p_r = np.array([100000., 0.])
p_s = np.array([149.e4, 0.])
v_e = np.array([40., 50.])
v_r = np.array([20., 22.])
v_s = np.array([0., 0.])
y_init = np.array([p_e, p_r, p_s, v_e,v_r,v_s])
#y_init = [400., 0., 20., 5., 2000., 0., 1., 8., 7., 5., 0., 0.]

t = np.arange(0, 11900, 1)
sol = odeint(f, np.reshape(y_init, 12), t)

fig = plt.figure(1, figsize=(8,8))
plt.plot(sol[:,2], sol[:,3],":m",label="rocket")
plt.plot(sol[:,0],sol[:,1], label = "earth")
plt.title("position of earth and rocket and Sun")
plt.xlabel("abscissa")
plt.ylabel("ordinate")

plt.plot(sol[:,4],sol[:,5],"*",label="Sun")
plt.legend(loc='best')
plt.show()

