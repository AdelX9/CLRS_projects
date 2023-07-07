#CLRS_stats_assignment2
#Q1106 ADEL 
#import libra maxima
import pandas as pd
import numpy as np
from scipy import stats
import math
from math import sqrt

#Exercise 1
av_t = 98.25
std_t = 0.73
ss = 130
ci = 0.99
z = stats.norm.ppf((1 + ci) / 2) #no need for the table
#margin of error
me = z * (std_t / math.sqrt(ss))
#ci 99%
ci_final = (av_t - me, av_t + me)
ci_final

#Exercise 2
av_h = 5.4
std_h = 3.1 
ss_h = 500
ci_h = 0.95
z = stats.norm.ppf((1 + ci_h) / 2) #no need for the table   
#margin of error
me = z * (std_h / math.sqrt(ss_h))
#ci 95%
ci_hfin = (av_h - me, av_h + me)
ci_hfin

#Exercise 3
av_pop = 13.2
av_sal = 12.2
std_sal = 2.5
ss_sal = 40
df = ss_sal-1
alpha = 0.01
#manual cal-n
a = (av_sal-av_pop)/(std_sal/sqrt(ss_sal))
a
#p-value
p = stats.norm.cdf(a) #  It is used for the cumulative distribution function.
p
if p < alpha:
    print('At {} level of significance, we can reject the null hypothesis in favor of alternative hypothesis.'.format(alpha))
else:
    print('At {} level of significance, we fail to reject the null hypothesis.'.format(alpha))
    
#Exercise 4
data = pd.read_excel("soil.xlsx")
alpha = 0.01
s1 = data["Soil1"]
s2 = data["Soil2"]
t = stats.ttest_ind(s1, s2, nan_policy='omit')
p = 2.59
if p < alpha:
    print('At {} level of significance, we can reject the null hypothesis in favor of alternative hypothesis.'.format(alpha))
else:
    print('At {} level of significance, we fail to reject the null hypothesis.'.format(alpha))
    
#Exercise 5
df = pd.read_excel("2015 PISA Test.xlsx")
#distribution
con_code = list(df["Continent_Code"].value_counts().index) #df[df["Continent_Code"]== "AS"].describe()
for i in con_code:
    sub= df[df["Continent_Code"] == i]
    print(sub.describe())
#two-sample t-test
alpha = 0.05
eu_math = df[df["Continent_Code"] == "EU"]["Math"]
as_math = df[df["Continent_Code"] == "AS"]["Math"]
test = stats.ttest_ind(eu_math, as_math, equal_var = True)
p = 0.38
if p < alpha:
    print('At {} level of significance, we can reject the null hypothesis in favor of alternative hypothesis.'.format(alpha))
else:
    print('At {} level of significance, we fail to reject the null hypothesis.'.format(alpha))