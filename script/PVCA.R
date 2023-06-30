
source("library.R")

library(pvca)
library(golubEsets)

#logFPKM
#ratioD6
#meta

rownames(meta)<-meta$library


pct_threshold <- 0.6
batch.factors <- c("sample","batchid")

#########absolute

logFPKM_data<-ExpressionSet(as.matrix(logFPKM),
                            phenoData=AnnotatedDataFrame(meta))

logFPKM_pvcaObj <- pvcaBatchAssess (logFPKM_data, batch.factors, pct_threshold)

logFPKM_bats<-data.frame(value=as.numeric(logFPKM_pvcaObj$dat),
                     name=logFPKM_pvcaObj$label)

logFPKM_bats$datatype<-"high"


###ratio

ratioD6_data<-ExpressionSet(as.matrix(ratioD6),
                            phenoData=AnnotatedDataFrame(meta))

ratioD6_pvcaObj <- pvcaBatchAssess (ratioD6_data, batch.factors, pct_threshold)

ratioD6_bats<-data.frame(value=as.numeric(ratioD6_pvcaObj$dat),
                         name=ratioD6_pvcaObj$label)

ratioD6_bats$datatype<-"low"


RNA_bats<-rbind(logFPKM_bats,ratioD6_bats)



RNA_bats$name<-gsub("sample:batchid","mixed",RNA_bats$name)
RNA_bats$name<-gsub("batchid","batch",RNA_bats$name)
RNA_bats$name<-gsub("resid","residue",RNA_bats$name)

RNA_bats$name<-factor(RNA_bats$name,levels=c( "sample" ,  "batch" ,"mixed" ,  "residue"),ordered=T)


p2<-ggplot(RNA_bats,aes(x=name,y=value,fill=name))+
  geom_bar(position="stack",stat="identity") +
  theme_few()+
  theme(legend.position = "none")+
   scale_fill_brewer(palette = "Set1",name="")+
  labs(x="Source",y="",title="")+
  facet_wrap(.~datatype,ncol=1)+
  myx45
p2
