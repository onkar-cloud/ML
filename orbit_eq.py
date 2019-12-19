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

def f(Y, t):
    """Integration of the governing vector differential equation.
    d2r_dt2 = -(mu/R^3)*r with d2r_dt2 and r as vecotrs.
    Initial position and velocity are given.
    y[0:2] = position components
    y[3:] = velocity components"""

    G = 6.674*(10**-11)
    E = 5.972*(10**24)
    S = 1.989*(10**30)
    R = 100000.
#    E = 500
#    S = 1000
#    R = 50
    r_er = np.sqrt((Y[0]-Y[2])**2 + (Y[1]-Y[3])**2)
    r_es = np.sqrt((Y[0]-Y[4])**2 + (Y[1]-Y[5])**2)
    r_rs = np.sqrt((Y[2]-Y[4])**2 + (Y[5]-Y[3])**2)
    
    dy0, dy1, dy2, dy3, dy4, dy5, dy6, dy7, dy8, dy9, dy10, dy11 = Y
    a = -(G*R / (r_er**3)) * (Y[0]-Y[2]) -(G*S / (r_es**3)) * (Y[0]-Y[4])
    b = -(G*R / (r_er**3)) * (Y[1]-Y[3]) -(G*S / (r_es**3)) * (Y[1]-Y[5])
    c = -(G*E / (r_er**3)) * (Y[2]-Y[0]) -(G*S / (r_rs**3)) * (Y[2]-Y[4])
    d = -(G*E / (r_er**3)) * (Y[3]-Y[1]) -(G*S / (r_rs**3)) * (Y[3]-Y[5])
    e = -(G*E / (r_es**3)) * (Y[4]-Y[0]) -(G*R / (r_rs**3)) * (Y[4]-Y[2])
    f = -(G*E / (r_es**3)) * (Y[5]-Y[1]) -(G*R / (r_rs**3)) * (Y[5]-Y[3])
    return [Y[6], Y[7], Y[8], Y[9], Y[10], Y[11], -a, -b, -c, -d, -e, -f]

y_init = [0., 0., 10000., 100000., 149.e12, 0., 0., 0., 0., 0., 0., 0.]
#y_init = [400., 0., 20., 5., 2000., 0., 1., 8., 7., 5., 0., 0.]
t = np.arange(0, 8000, 0.1)
sol = odeint(f, y_init, t)

plt.plot(sol[:,2], sol[:,3])
plt.show()
plt.plot(sol[:,0],sol[:,1])
plt.show()