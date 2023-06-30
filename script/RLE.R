

source("library.R")

#logFPKM
#ratioD6
#meta

library(ggvis)


logFPKM_RLE<-apply(logFPKM,2,function(x){x-mean(x)})
#boxplot(logFPKM_RLE)
ratioD6_RLE<-apply(ratioD6,2,function(x){x-mean(x)})
#boxplot(ratioD6_RLE)


nam1<-c("logFPKM_RLE","ratioD6_RLE")

boxvalues<-c()

for (i in 1:length(nam1)){
  
  mat<-get(nam1[i])
  
  for ( j in 1:ncol(mat)){
    
  mat1<-data.frame(
  gene=rownames(mat),
  value=mat[,j])

  med<-median(mat1$value)
  Q1<-quantile(mat1$value,0.25)
  Q3<-quantile(mat1$value,0.75)
  IQR<-Q3-Q1
  min_<-max(Q1-1.5*IQR,min(mat1$value))
  max_<-min(Q3+1.5*IQR,max(mat1$value))
  
  boxvalues<-rbind(boxvalues,c(paste(nam1[i],colnames(mat)[j]),med,Q1,Q3,min_,max_))
}
}

boxvalues<-data.frame(boxvalues)
colnames(boxvalues)<-c("datatype_library","median","Q1","Q3","min_","max_")

for ( i in 2:ncol(boxvalues)){
  boxvalues[,i]<-as.numeric(as.character(boxvalues[,i]))
  
}
rownames(boxvalues)<-boxvalues$datatype_library
n<-sapply(strsplit(as.character(boxvalues$datatype_library)," "),function(x){x[2]})
boxvalues<-boxvalues[order(meta$sample[match(n,meta$library)]),]
boxvalues$datatype_library<-NULL


boxvalues_m<-melt(as.matrix(boxvalues))

boxvalues_m$datatype<-sapply(strsplit(as.character(boxvalues_m$Var1)," "),function(x){x[1]})
boxvalues_m$library<-sapply(strsplit(as.character(boxvalues_m$Var1)," "),function(x){x[2]})

#boxvalues_m1<-boxvalues_m[!grepl("D6",boxvalues_m$library),]
boxvalues_m$datatype<-ifelse(boxvalues_m$datatype =="logFPKM_RLE","high","low")

p1<-ggplot(boxvalues_m,aes(x=Var1,y=value,group=Var2))+
   theme_few()+
   theme(axis.text.x = element_blank(),
       axis.ticks.x = element_blank())+
  geom_area(data=subset(boxvalues_m,Var2 %in% c("min_","max_")),fill = 'grey80')+
  geom_area(data=subset(boxvalues_m,Var2 %in% c("Q1","Q3")),fill = 'grey50')+
  geom_point()+
  geom_line()+
  geom_point(data=subset(boxvalues_m,Var2 %in% c("median")),color="red",size=2)+
  geom_line(data=subset(boxvalues_m,Var2 %in% c("median")),color="red",size=1.5)+
  facet_wrap(.~datatype,scales="free",ncol=1)+
  labs(x="",y="RLE")
p1


anno_col<-meta[match(gsub("logFPKM_RLE ","",rownames(boxvalues)),meta$library),c("library","batchid","sample") ]
anno_col<-anno_col[!is.na(anno_col$library),]

##setcolor
l<-levels(as.factor(anno_col$batchid))
colors.batch<-  pal_jama(alpha =1)(3)
names(colors.batch)<-l

dt.forPlot <- anno_col
dt.forPlot$library<-factor(dt.forPlot$library,levels=as.character(dt.forPlot$library),ordered=T)

p.bar.batch <- ggplot(dt.forPlot, aes(x=library,y=1))+
  geom_bar(stat='identity', aes(fill=batchid),width=1)+
  theme_void()+
  theme(strip.background = element_blank(),
        strip.text.x = element_text(size=0)
  )+
  scale_fill_manual(values = colors.batch)+
  theme(legend.position = 'none'); p.bar.batch

p.bar.sample<- ggplot(dt.forPlot, aes(x=library,y=1))+
  geom_bar(stat='identity', aes(fill=sample),width=1)+
  theme_void()+
  theme(strip.background = element_blank(),
        strip.text.x = element_text(size=0))+
  scale_fill_manual(values = colors.sample.Quartet.fill)+
  theme(legend.position = 'none');p.bar.sample

plotbar <- plot_grid(p.bar.sample,
                     p.bar.batch, 
                     align = "v", ncol = 1, 
                     axis = "tb", 
                     rel_heights = c(1,1));  plotbar


p2<-plot_grid(p1,plotbar,
          align = "v",
          ncol = 1, 
          axis = "tb", 
          rel_heights = c(10,1))

