# batcheffect_visual

One of the most common methods for diagnosing and evaluating batch effects is visualization, which provides an initial impression of the effectiveness of BECAs. 
Here, we provide R code of visualization tools for diagnosing and evaluating batch effects. 

Example data: 

To better illustrate visualization tools in terms of assessing batch effects, we employ a multi-batch RNAseq dataset of four Quartet RNA reference materials, including 27 libraries from three batches. Different numbers of replicates (n=5~9) of reference materials are included in each batch to mimic a confounded scenario that replicates of reference materials are not equally distributed across batches. Data are available at Open Archive for Miscellaneous Data (OMIX) (accession number: OMIX002254). The examples have been performed using ratio-based scaling as the method for batch effect removal.
