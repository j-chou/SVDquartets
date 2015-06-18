setwd('C:\\Users\\Michael\\Grad School Stuff\\Research\\Phylogenetics\\results\\2015_05_SVDquartets\\analysis')
library(ggplot2)
library(gridExtra)
library(RColorBrewer)

data<-read.csv("stats_astral_vs_svdq.csv")
levels(data$method)
dataastralsvd<-data[(data$method=='ASTRAL') | (data$method=='SVD+Paup'),]

#
# 1. ASTRAL vs. SVD + Paup
#
mydata<-dataastralsvd
frm<-FN.rate~method+M2+M3+M4+sites_25+sites_50+sites_100+sites_200+genes_500+genes_1000
lm1<-lm(frm,mydata)

frm2<-FN.rate~method*(M2+M3+M4)+sites_25+sites_50+sites_100+sites_200+genes_500+genes_1000
lm2<-lm(frm2,mydata)
# to test the difference in means vs. ILS, test each individual ILS*Method cofficient
#   individually:
summary(lm2)

#
# To test means of ASTRAL vs. SVD+Paup, we must test that the sums of the 
#   ILS*Method coefficients are different from zero:
#
beta<-summary(lm2)$coefficients[,1]
Sigma<-summary(lm2)$cov.unscaled
a1<-c(0,1,0,0,0,0,0,0,0,0,0,1,1,1)
t1<-(t(a1)%*%beta)/sqrt(t(a1)%*%Sigma%*%a1*summary(lm2)$sigma^2)
a2<-c(0,1,0,0,0,0,0,0,0,0,0,1,1,0)
t2<-(t(a2)%*%beta)/sqrt(t(a2)%*%Sigma%*%a2*summary(lm2)$sigma^2)
a3<-c(0,1,0,0,0,0,0,0,0,0,0,1,0,0)
t3<-(t(a3)%*%beta)/sqrt(t(a3)%*%Sigma%*%a3*summary(lm2)$sigma^2)
a4<-c(0,1,0,0,0,0,0,0,0,0,0,0,0,0)
t4<-(t(a4)%*%beta)/sqrt(t(a4)%*%Sigma%*%a4*summary(lm2)$sigma^2)
p1<-1-pnorm(t1)
p2<-1-pnorm(t2)
p3<-1-pnorm(t3)
p4<-1-pnorm(t4)
# The p-values for each of the four hypotheses. To conduct the BH correction,
#   see e.g. https://en.wikipedia.org/wiki/False_discovery_rate#Benjamini.E2.80.93Hochberg_procedure
c(p1,p2,p3,p4)

