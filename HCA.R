
source("library.R")

#logFPKM
#ratioD6
#meta


#################################################################################
######         PCA
#################################################################################

nam<-c("logFPKM","ratioD6")

pcsall_1<-c()
for ( i in 1:length(nam)){
  print(i)
  
  mat<-get(nam[i])
  
  dat_z2<-t(apply(mat,1,function(x){(x-mean(x))/sd(x)}))
  dat_z2<-dat_z2[apply(dat_z2,1,function(x){length(which(is.na(x)))==0}),]
  
  sample<-meta$sample[match(colnames(dat_z2),meta$library)]
  snrvaluet2<- round(snrdb_function(dat_z2,as.factor(sample)),1)
  ######pca
  pca_prcomp2 <- prcomp(t(dat_z2 ), scale=F)
  pcs2 <- data.frame(predict(pca_prcomp2))
  
  
  pcs2<-pcs2[,c("PC1","PC2")]
  pcs2$library<-rownames(pcs2)
  pcs2$sample<-meta$sample[match(pcs2$library,meta$library)]
  pcs2$batch<-meta$batch[match(pcs2$library,meta$library)]
  pcs2$batchid<-meta$batchid[match(pcs2$library,meta$library)]
  
  pcs2$datatype<-nam[i]
  pcs2$snr<-snrvaluet2
  pcs2$type<-nam[i]
  
  pcsall_1<-rbind(pcsall_1,pcs2)
  
}

