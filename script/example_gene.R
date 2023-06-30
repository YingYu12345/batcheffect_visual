
source("library.R")

#logFPKM
#ratioD6
#meta

meta$sample_batch<-paste(meta$sample,meta$batch,sep="_")


#example
expr1<-data.frame(library=colnames(logFPKM),
  value=logFPKM[rownames(logFPKM) %in% c("ENSG00000109861"),],
  datatype="Before")

expr2<-data.frame(library=colnames(ratioD6),
                  value=ratioD6[rownames(ratioD6) %in% c("ENSG00000109861"),],
                  datatype="After")

expr3<-rbind(expr1,expr2)
expr3$batch<-meta$batchid[match(expr3$library,meta$library)]
expr3$sample<-meta$sample[match(expr3$library,meta$library)]

##setcolor
l<-levels(as.factor(meta$batchid))
colors.batch<-  pal_jama(alpha =1)(3)
names(colors.batch)<-l




n<-meta$library[order(meta$sample)]

expr3$library<-factor(expr3$library,levels=n,ordered=T)
expr3$datatype<-factor(expr3$datatype,levels=c("Before","After"),ordered=T)

p1<-ggplot(subset(expr3,datatype=="Before"),aes(x=library,y=value,color=batch,fill=batch))+
  geom_bar(position=position_dodge(),stat="identity",width=0.7) +
  scale_color_manual(values = colors.batch,name="Batch") +
scale_fill_manual(values = colors.batch,name="Batch") +
  theme_few()+
  facet_wrap(.~sample,scales="free_x",ncol=4)+
 theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
)+
  labs(x="",y="Before")
p1


p2<-ggplot(subset(expr3,datatype=="After"),aes(x=library,y=value,color=batch,fill=batch))+
  geom_bar(position=position_dodge(),stat="identity",width=0.7) +
  scale_color_manual(values = colors.batch,name="Batch") +
  scale_fill_manual(values = colors.batch,name="Batch") +
    theme_few()+
  facet_wrap(.~sample,scales="free_x",ncol=4)+
  
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
      )+
  ylim(c(-1,2))+
  labs(x="",y="After")

p1_n<-p1+theme(legend.position = "none")
p2_n<-p2+theme(legend.position = "none")


ll<-get_legend(ggplot(subset(expr3,datatype=="Before"),aes(x=library,y=value,color=batch,fill=batch))+
  geom_bar(position=position_dodge(),stat="identity",width=0.7) +
  scale_color_manual(values = colors.batch,name="Batch") +
  scale_fill_manual(values = colors.batch,name="Batch") +
  theme_few()+
  mytheme12+
  theme(axis.text.x = element_blank(),
        legend.position = "bottom"))

plot(ll)

p3<-plot_grid(p1_n,p2_n,
          align = "v",
          ncol = 1, 
          axis = "tblr", 
          rel_heights = c(1,1))  
