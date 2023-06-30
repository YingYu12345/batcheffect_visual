

source("library.R")

#logFPKM
#ratioD6
#meta


nam<-c("logFPKM","ratioD6")


mybreaks<-seq(-3,3,length.out=50)
  
for ( i in 1:length(nam)){
  print(i)
  
  mat<-get(nam[i])
   
  anno_col<-meta[match(colnames(mat),meta$library),c("library","batchid","sample") ]
  rownames(anno_col)<-anno_col$library
  anno_col$library<-NULL
  colnames(anno_col)<-c("Batch","Sample")
  
  ##setcolor
  l<-levels(as.factor(anno_col$Batch))
  colors.batch<-  pal_jama(alpha =1)(3)
  names(colors.batch)<-l
  
  ann_colors<-list(
    Batch=colors.batch,
    Sample=colors.sample.Quartet.fill
  )
  
  
  mat1<-mat[sample(1:nrow(mat),5000),]
  
  pheatmap(as.matrix(mat1),
           scale="row",
           cluster_cols = T,
           clustering_distance_rows = "correlation",
           clustering_distance_cols = "correlation",
           clustering_method = "ward.D",
           breaks=mybreaks,
           color = colorRampPalette(rev(brewer.pal(n = 7, name ="RdYlBu")))(50),
           show_rownames = F,
            show_colnames = F,
           filename =paste("pheatmap_",nam[i],".png",sep=""),
           width=6,
           height=2.5,
           annotation_col = anno_col,
           annotation_colors =ann_colors
  )
  
}
