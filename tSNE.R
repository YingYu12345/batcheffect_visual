

source("library.R")

#logFPKM
#ratioD6
#meta

#################################################################################
######         tSNE
#################################################################################

library(data.table)
library(Rtsne)


tsnevalue<-c()

for ( i in 1:length(nam)){
  
  exprMat<-get(nam[i])
  print(i)
  
  exprMat<-exprMat[!apply(exprMat,1,sd)==0,]
  exprMat<-exprMat[apply(exprMat,1,function(x){length(which(is.na(x)))==0}),]
  
  d<-  Rtsne(t(exprMat), initial_dims = 10,dims = 2,  pca =T, pca_scale =T ,perplexity=5,theta=0,num_threads=4)
  
  tsne.info<-data.frame(d$Y)
  colnames(tsne.info) <- c("tsne1","tsne2")
  rownames(tsne.info)<-colnames(exprMat)
  
  tsne.info$tsne1_scale<-rescale(tsne.info$tsne1,c(-100,100))
  tsne.info$tsne2_scale<-rescale(tsne.info$tsne2,c(-100,100))
  tsne.info$library<-rownames(tsne.info)
  tsne.info$sample<-as.character(meta$sample[match(rownames(tsne.info),meta$library)])
  tsne.info$batch<-as.character(meta$batch[match(rownames(tsne.info),meta$library)])
  tsne.info$batchid<-meta$batchid[match(rownames(tsne.info),meta$library)]
  tsne.info$datatype<-nam[i]
  
  tsnevalue<-rbind(tsnevalue,tsne.info)
  
  
}

