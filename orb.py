import matplotlib.pyplot as plt
import numpy as np
from scipy.integrate import odeint
from mpl_toolkits.mplot3d import Axes3D
from numpy.linalg import *

def dr_dt(y, t):
    """Integration of the governing vector differential equation.
    d2r_dt2 = -(mu/R^3)*r with d2r_dt2 and r as vecotrs.
    Initial position and velocity are given.
    y[0:2] = position components
    y[3:] = velocity components"""

    G = 6.672*(10**-11)
    M = 5.972*(10**24)
    mu = G*M
    p,v = y.reshape(2,2)
    r = p
    
    dy0 = v
    dy3 = -(mu / norm(r)**3) * p
    dv = np.array([dy0,dy3])
    return np.reshape(dv,4)

t = np.arange(0,2090, 0.1)
p = np.array([7.e6, 0.])
v = np.array([0., 1.e3])


y0 = np.array([p,v])
y = odeint(dr_dt, np.reshape(y0, 4), t)


plt.plot(y[:,0],y[:,1])
plt.show()