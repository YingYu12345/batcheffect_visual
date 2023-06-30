# batcheffect_visual

One of the most common methods for diagnosing and evaluating batch effects is visualization, which provides an initial impression of the effectiveness of BECAs. 
Here, we provide R code of visualization tools for diagnosing and evaluating batch effects. 

## Dataset
Quartet RNA reference materials and multi-batch RNA-seq dataset: 
The Quartet RNA reference materials were derived from the Epstein-Barr Virus (EBV) immortalized B-lymphoblastoid cell lines from four members of a Chinese family quartet including monozygotic twin daughters (D5 and D6), father (F7), and mother (M8). RNA-seq datasets from the Quartet RNA reference materials were then collected, consisting of 252 RNA-seq libraries from 21 batches generated in eight labs using two library construction protocols (PolyA selection and RiboZero) and two sequencing platforms (Illumina NovaSeq (ILM) and MGI DNBSEQ-T7 (BGI)). Here, a batch is defined as 12 libraries from a standard sample set, consisting of 12 vials with each representing one of the triplicates of the Quartet RNA reference sample groups, whose library construction and sequencing experiments were conducted simultaneously. To facilitate the adoption of reference materials, reference datasets, and quality metrics from the Quartet Project, we developed a Quartet Data Portal (http://chinese-quartet.org/) for access to the Quartet resources and enhancing quality consciousness of the community. Researchers can request the reference materials, datasets, and reference datasets from the data portal.

## Dataset used in this study
A subset of datasets from Quartet RNA reference materials for illustrating visualization tools in terms of diagnostics of batch effects. This example dataset includes 27 libraries from three RNA-seq batches. Different numbers of replicates (n=5~9) of reference materials are included in each batch to mimic a confounded scenario that replicates of reference materials are not equally distributed across batches.

## Analysis
Expression matrix in log2-transformed Fragments Per Kilobase of transcript per Million mapped reads (FPKM) values were used as expression profiles before batch correction. Expression profiles based on detected genes were used for further analysis. A gene was considered detectable (expressed) in a biological group within a batch if ≥ 3 reads were mapped onto it in at least two of the three replicates. 
Ratio-based scaling was conducted for batch correction. Specifically, ratio-based scaling were calculated based on log2FPKM values. For each gene, the mean of expression profiles of replicates of reference sample(s) (e.g. D6) was first calculated, and then subtracted from the log2FPKM values of that gene in each study.
