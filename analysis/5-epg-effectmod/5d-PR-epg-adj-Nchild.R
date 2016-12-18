##############################################
# WASH Benefits Bangladesh STH Kato-Katz Study
# Primary outcome analysis  

# STH adjusted analysis
# Eggs per gram

# Effect modification by number of children
# 5-12 years

# by Jade
##############################################
library(devtools)
library(washb)

rm(list=ls())
data=read.csv("~/Box Sync/WASHB Parasites/Analysis datasets/Jade/sth.csv",stringsAsFactors=TRUE)
source("~/documents/crg/wash-benefits/bangladesh/src/sth/analysis/0-base-programs.R")

d=preprocess.sth(data)
d=preprocess.adj.sth(d)

d1=d[d$n5to14==1,]
d0=d[d$n5to14==0,]

# roof and landphone excluded due to low prevalence

W=c("counter","birthord","month","hfiacat","aged","sex","momage","momheight","momedu",
    "Nlt18","Ncomp","watmin","walls","floor",
    "elec","asset_wardrobe","asset_table","asset_chair","asset_khat","asset_chouki",
    "asset_tv","asset_refrig","asset_bike","asset_moto","asset_sewmach","asset_mobile")

dW1=d1[,c("block","tr","clusterid","alepg","hwepg","ttepg",W)]
dW0=d0[,c("block","tr","clusterid","alepg","hwepg","ttepg",W)]

#----------------------------------------------
# H1: Unadjusted prevalence ratios; each arm vs. 
# control. PR, CI, P-value
#----------------------------------------------
# index child
trlist=c("Water","Sanitation","Handwashing",
         "WSH","Nutrition","Nutrition + WSH")

SL.library=c("SL.mean","SL.glm","SL.bayesglm","SL.gam","SL.glmnet")

est.al.h1.ch1.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW1$alepg,tr=dW1$tr,
   pair=dW1$block, id=dW1$block,W=dW1[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.ch1.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW1$hwepg,tr=dW1$tr,
   pair=dW1$block, id=dW1$block,W=dW1[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.ch1.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW1$ttepg,tr=dW1$tr,
   pair=dW1$block, id=dW1$block,W=dW1[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_ari_ch1_j=format.epg.tmle(est.al.h1.ch1.ari)
hw_fecr_h1_ari_ch1_j=format.epg.tmle(est.hw.h1.ch1.ari)
tt_fecr_h1_ari_ch1_j=format.epg.tmle(est.tt.h1.ch1.ari)

rownames(al_fecr_h1_ari_ch1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_ari_ch1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_ari_ch1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")

est.al.h1.ch1.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW1$alepg,tr=dW1$tr,
   pair=dW1$block, id=dW1$block,W=dW1[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.ch1.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW1$hwepg,tr=dW1$tr,
   pair=dW1$block, id=dW1$block,W=dW1[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.ch1.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW1$ttepg,tr=dW1$tr,
   pair=dW1$block, id=dW1$block,W=dW1[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_geo_ch1_j=format.epg.tmle(est.al.h1.ch1.geo)
hw_fecr_h1_geo_ch1_j=format.epg.tmle(est.hw.h1.ch1.geo)
tt_fecr_h1_geo_ch1_j=format.epg.tmle(est.tt.h1.ch1.geo)

rownames(al_fecr_h1_geo_ch1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_geo_ch1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_geo_ch1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")  

# Not index child
est.al.h1.ch0.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW0$alepg,tr=dW0$tr,
   pair=dW0$block, id=dW0$block,W=dW0[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.ch0.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW0$hwepg,tr=dW0$tr,
   pair=dW0$block, id=dW0$block,W=dW0[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.ch0.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW0$ttepg,tr=dW0$tr,
   pair=dW0$block, id=dW0$block,W=dW0[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_ari_ch0_j=format.epg.tmle(est.al.h1.ch0.ari)
hw_fecr_h1_ari_ch0_j=format.epg.tmle(est.hw.h1.ch0.ari)
tt_fecr_h1_ari_ch0_j=format.epg.tmle(est.tt.h1.ch0.ari)

rownames(al_fecr_h1_ari_ch0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_ari_ch0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_ari_ch0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")

est.al.h1.ch0.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW0$alepg,tr=dW0$tr,
   pair=dW0$block, id=dW0$block,W=dW0[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.ch0.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW0$hwepg,tr=dW0$tr,
   pair=dW0$block, id=dW0$block,W=dW0[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.ch0.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=dW0$ttepg,tr=dW0$tr,
   pair=dW0$block, id=dW0$block,W=dW0[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_geo_ch0_j=format.epg.tmle(est.al.h1.ch0.geo)
hw_fecr_h1_geo_ch0_j=format.epg.tmle(est.hw.h1.ch0.geo)
tt_fecr_h1_geo_ch0_j=format.epg.tmle(est.tt.h1.ch0.geo)

rownames(al_fecr_h1_geo_ch0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_geo_ch0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_geo_ch0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")  

#----------------------------------------------
# save objects
#----------------------------------------------

save(al_fecr_h1_geo_ch1_j,hw_fecr_h1_geo_ch1_j,tt_fecr_h1_geo_ch1_j,
     al_fecr_h1_geo_ch1_j,hw_fecr_h1_geo_ch1_j,tt_fecr_h1_geo_ch1_j,

     al_fecr_h1_ari_ch0_j,hw_fecr_h1_ari_ch0_j,tt_fecr_h1_ari_ch0_j,
     al_fecr_h1_ari_ch0_j,hw_fecr_h1_ari_ch0_j,tt_fecr_h1_ari_ch0_j,
     
     file="~/Box Sync/WASHB Parasites/Results/Jade/sth_pr_epg_adj_Nchild.RData")

