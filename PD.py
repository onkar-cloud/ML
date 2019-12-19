#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep  3 16:45:38 2018

@author: onkar
"""

# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
#import random
import sys
def Strategy(a,b):
        if a==b==0:
            x = np.append(np.repeat(0,8000),np.repeat(1,1000))
            for i in range(100):
                np.random.shuffle(x)
                
            y = np.random.choice(x)
            return(y)
        
        elif a==1 and b==0:
            x = np.append(np.repeat(0,4500),np.repeat(1,4500))
            for i in range(100):
                np.random.shuffle(x)
                
            y = np.random.choice(x)
            return(y)
        
        elif a==0 and b==1:
            x = np.append(np.repeat(0,3000),np.repeat(1,6000))
            for i in range(100):
                np.random.shuffle(x)
                
            y = np.random.choice(x)
            return(y)
        
        elif a==b==1:
            y = 1
            return(y)

b = 1
him = [np.random.choice(2)]
me = [b]
#print("you chose ", him[-1], "and I chose ", me[-1])

if a==0 and b==1:
    my_pts = [0]
    your_pts = [3]
    #print("your punishment is ",your_pts[-1], "yrs and my punishment is ",my_pts[-1],"yrs")
elif a==b==1:
    my_pts = [2]
    your_pts = [2]
    #print("your punishment is ",your_pts[-1], "yrs and my punishment is ",my_pts[-1],"yrs \n")

for k in range(1000):
    
    a = np.random.choice(2)
    o_p = Strategy(him[-1], me[-1])
    him.append(a)
    me.append(o_p)
    #print("you chose ", him[-1], "and I chose ", me[-1])
    if me[-1] == him[-1] == 0:
        my_pts.append(1)
        your_pts.append(1)
    
    if him[-1] == 0 and me[-1] == 1:
        my_pts.append(0)
        your_pts.append(3)
    
    if him[-1] == 1 and me[-1] == 0:
        my_pts.append(3)
        your_pts.append(0)
    
    if him[-1] == 1 and me[-1] == 1:
        my_pts.append(2)
        your_pts.append(2)
    
    #print("your punishment is ",your_pts[-1], "yrs and my punishment is ",my_pts[-1],"yrs")
    
#print(your_pts,my_pts)
#print(" your moves: ", him)

him_mean = sum(your_pts)
me_mean = sum(my_pts)
print("your avg punishment :", him_mean, "yrs", "and my avg punishment :", me_mean, "yrs \n")