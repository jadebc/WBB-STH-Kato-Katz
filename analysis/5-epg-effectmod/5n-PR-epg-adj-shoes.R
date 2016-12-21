##############################################
# WASH Benefits Bangladesh STH Kato-Katz Study
# Primary outcome analysis  

# STH adjusted analysis
# Eggs per gram

# Effect modification by wearing shoes at the 
# time of data collection 

# by Jade
##############################################
library(devtools)
library(washb)

rm(list=ls())
data=read.csv("~/Box Sync/WASHB Parasites/Analysis datasets/Jade/sth.csv",stringsAsFactors=TRUE)
source("~/documents/crg/wash-benefits/bangladesh/src/sth/analysis/0-base-programs.R")

d=preprocess.sth(data)
d=preprocess.adj.sth(d)

d1=d[d$shoes==1,]
d0=d[d$shoes==0,]

# roof and landphone excluded due to low prevalence

W=c("counter","birthord","month","hfiacat","aged","sex","momage","momheight","momedu",
    "Nlt18","Ncomp","watmin","walls","floor",
    "elec","asset_wardrobe","asset_table","asset_chair","asset_khat","asset_chouki",
    "asset_tv","asset_refrig","asset_bike","asset_moto","asset_sewmach","asset_mobile")

shoe1=d1[,c("block","tr","clusterid","alepg","hwepg","ttepg",W)]
shoe0=d0[,c("block","tr","clusterid","alepg","hwepg","ttepg",W)]

#----------------------------------------------
# H1: Unadjusted prevalence ratios; each arm vs. 
# control. PR, CI, P-value
#----------------------------------------------
# index child
trlist=c("Water","Sanitation","Handwashing",
         "WSH","Nutrition","Nutrition + WSH")

SL.library=c("SL.mean","SL.glm","SL.bayesglm","SL.gam","SL.glmnet")

est.al.h1.shoe1.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe1$alepg,tr=shoe1$tr,
   pair=shoe1$block, id=shoe1$block,W=shoe1[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.shoe1.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe1$hwepg,tr=shoe1$tr,
   pair=shoe1$block, id=shoe1$block,W=shoe1[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.shoe1.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe1$ttepg,tr=shoe1$tr,
   pair=shoe1$block, id=shoe1$block,W=shoe1[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_ari_shoe1_j=format.epg.tmle(est.al.h1.shoe1.ari)
hw_fecr_h1_ari_shoe1_j=format.epg.tmle(est.hw.h1.shoe1.ari)
tt_fecr_h1_ari_shoe1_j=format.epg.tmle(est.tt.h1.shoe1.ari)

rownames(al_fecr_h1_ari_shoe1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_ari_shoe1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_ari_shoe1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")

est.al.h1.shoe1.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe1$alepg,tr=shoe1$tr,
   pair=shoe1$block, id=shoe1$block,W=shoe1[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.shoe1.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe1$hwepg,tr=shoe1$tr,
   pair=shoe1$block, id=shoe1$block,W=shoe1[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.shoe1.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe1$ttepg,tr=shoe1$tr,
   pair=shoe1$block, id=shoe1$block,W=shoe1[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_geo_shoe1_j=format.epg.tmle(est.al.h1.shoe1.geo)
hw_fecr_h1_geo_shoe1_j=format.epg.tmle(est.hw.h1.shoe1.geo)
tt_fecr_h1_geo_shoe1_j=format.epg.tmle(est.tt.h1.shoe1.geo)

rownames(al_fecr_h1_geo_shoe1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_geo_shoe1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_geo_shoe1_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")  

# Not index child
est.al.h1.shoe0.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe0$alepg,tr=shoe0$tr,
   pair=shoe0$block, id=shoe0$block,W=shoe0[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.shoe0.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe0$hwepg,tr=shoe0$tr,
   pair=shoe0$block, id=shoe0$block,W=shoe0[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.shoe0.ari=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe0$ttepg,tr=shoe0$tr,
   pair=shoe0$block, id=shoe0$block,W=shoe0[,W], FECR="arithmetic",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_ari_shoe0_j=format.epg.tmle(est.al.h1.shoe0.ari)
hw_fecr_h1_ari_shoe0_j=format.epg.tmle(est.hw.h1.shoe0.ari)
tt_fecr_h1_ari_shoe0_j=format.epg.tmle(est.tt.h1.shoe0.ari)

rownames(al_fecr_h1_ari_shoe0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_ari_shoe0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_ari_shoe0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")

est.al.h1.shoe0.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe0$alepg,tr=shoe0$tr,
   pair=shoe0$block, id=shoe0$block,W=shoe0[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.hw.h1.shoe0.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe0$hwepg,tr=shoe0$tr,
   pair=shoe0$block, id=shoe0$block,W=shoe0[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

est.tt.h1.shoe0.geo=apply(matrix(trlist), 1,function(x) washb_tmle(Y=shoe0$ttepg,tr=shoe0$tr,
   pair=shoe0$block, id=shoe0$block,W=shoe0[,W], FECR="geometric",
   family="gaussian",contrast=c("Control",x),Q.SL.library=SL.library,
   g.SL.library=SL.library, pval=0.2, seed=12345, print=TRUE))

al_fecr_h1_geo_shoe0_j=format.epg.tmle(est.al.h1.shoe0.geo)
hw_fecr_h1_geo_shoe0_j=format.epg.tmle(est.hw.h1.shoe0.geo)
tt_fecr_h1_geo_shoe0_j=format.epg.tmle(est.tt.h1.shoe0.geo)

rownames(al_fecr_h1_geo_shoe0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                               "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(hw_fecr_h1_geo_shoe0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")
rownames(tt_fecr_h1_geo_shoe0_j)=c("Water vs C","Sanitation vs C","Handwashing vs C",
                             "WSH vs C","Nutrition vs C","Nutrition + WSH vs C")  

#----------------------------------------------
# save objects
#----------------------------------------------

save(al_fecr_h1_geo_shoe1_j,hw_fecr_h1_geo_shoe1_j,tt_fecr_h1_geo_shoe1_j,
     al_fecr_h1_geo_shoe1_j,hw_fecr_h1_geo_shoe1_j,tt_fecr_h1_geo_shoe1_j,

     al_fecr_h1_ari_shoe0_j,hw_fecr_h1_ari_shoe0_j,tt_fecr_h1_ari_shoe0_j,
     al_fecr_h1_ari_shoe0_j,hw_fecr_h1_ari_shoe0_j,tt_fecr_h1_ari_shoe0_j,
     
     file="~/Box Sync/WASHB Parasites/Results/Jade/sth_pr_epg_adj_shoes.RData")

