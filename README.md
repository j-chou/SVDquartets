# SVDquartets Experiments
This repository contains all scripts used in our paper,  
A Comparative Study of SVDquartets and Other Coalescent-Based Species Tree Estimation Methods 
by Jed Chou, Ashu Gupta, Shashank Yaduvanshi, Ruth Davidson, Mike Nute, Siavash Mirarab, and Tandy Warnow.

##Simulated Datasets
Links to the simulated datasets and species tree estimation methods used in this study can all be found at goo.gl/EgkWRk

##Scripts for Processing Simulated Datasets
Scripts to relabel PHYLIP alignments (i.e., to convert taxa names to integers via a user-specified dictionary taxa_dict.txt),
sample sites from PHYLIP alignments, and combine shortened alignments into a NEXUS file are in the folder src-pipeline.

##Scripts for Running Species Tree Estimation Methods on the Simulated Datasets

The files in each "pipeline-" folder are a combination of shell scripts and qsub scripts 
for the UIUC campus cluster. 

0) pipeline-data_processing contains shell scripts to run the Python code in src-pipeline. 

1) pipeline-summary_methods contains scripts to estimate gene trees on shortened alignments with 
FastTree-2 [1] or RAxML [2], and to run ASTRAL-2 [3] and NJst [4] on the estimated gene trees.

2) pipeline-SVDquartets contains scripts to run SVDquartets [5] through PAUP*'s [6] implementation
on NEXUS files of aggregated, shortened gene alignments. 

3) pipeline-concatenation has scripts to run concatenated analysis with maximum likelihood (CA-ML) with RAxML. 

##References
1. Price, M.N., Dehal, P.S., Arkin, A.P.: FastTree 2: approximately maximum-likelihood trees for large alignments. PLoS One 5, 9490 (2010)

2. Stamatakis, A.: RAxML-VI-HPC: maximum likelihood-based phylogenetic analyses with thousands of taxa and mixed models. Bioinformatics 22(21), 2688–2690 (2006)

3. Mirarab, S., Warnow, T.: ASTRAL-II: coalescent-based species tree estimation with many hundreds of taxa and thousands of genes. Bioinform. 31 (2015). doi:10.1093/bioinformatics/btv234

4. Liu, L., Yu, L.: Estimating species trees from unrooted gene trees. Syst. Biol. 60, 661–667 (2011)

5. Chifman, J., Kubatko, L.: Quartet inference from snp data under the coalescent model. Bioinformatics, 530 (2014)

6. Swofford, D., et al.: Phylogenetic analysis using parsimony (* and other methods). version 4. Sunderland, MA: Sinauer Associates (2002)
