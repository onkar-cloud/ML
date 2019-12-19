# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd
from sklearn.svm import SVC

data = pd.read_csv("/nfs/cms/mtech17/onkar.ranade/breast_cancer.csv")

data = data.iloc[:,1:]

y = data.iloc[:,0]
X = data.iloc[:,1:]

from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
y = le.fit_transform(y)

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2)
model = SVC(C=2,kernel="linear")
mod = model.fit(X_train,y_train)
y_predict = model.predict(X_test)

from sklearn.metrics import accuracy_score, confusion_matrix
acc = accuracy_score(y_test, y_predict)
print(acc)

from sklearn.model_selection import cross_val_predict, cross_val_score, KFold
from sklearn.metrics import accuracy_score 

cv = KFold(n_splits=5)
y_pred = cross_val_score(model, X, y, cv=cv)
#cross_val_score gives the vector of accuracie.s of each fold.
#cross_val_predict merges all partially predicted labels and returns them as a whole.
#score = accuracy_score(y, y_pred)
print(y_pred)
cv_acc = y_pred.mean()
print(cv_acc)