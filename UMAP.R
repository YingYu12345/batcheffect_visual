
source("library.R")

#logFPKM
#ratioD6
#meta

#################################################################################
######         UMAP
#################################################################################

library(umap)


umapevalue<-c()

for ( i in 1:length(nam)){
  
  exprMat<-get(nam[i])
  print(i)
  
  exprMat<-exprMat[!apply(exprMat,1,sd)==0,]
  exprMat<-exprMat[apply(exprMat,1,function(x){length(which(is.na(x)))==0}),]
  
  d<-umap(t(exprMat))
  
  umap.info<-data.frame(d$layout)
  colnames(umap.info) <- c("umap1","umap2")
  rownames(umap.info)<-colnames(exprMat)
  
  umap.info$umap1_scale<-rescale(umap.info$umap1,c(-100,100))
  umap.info$umap2_scale<-rescale(umap.info$umap2,c(-100,100))
  umap.info$library<-rownames(umap.info)
  umap.info$sample<-as.character(meta$sample[match(rownames(umap.info),meta$library)])
  umap.info$batch<-as.character(meta$batch[match(rownames(umap.info),meta$library)])
  umap.info$batchid<-meta$batchid[match(rownames(umap.info),meta$library)]
  umap.info$datatype<-nam[i]

  umapevalue<-rbind(umapevalue,umap.info)
  
}
