# SVDquartets
This repository contains all scripts used in our paper,
A Comparative Study of SVDquartets and Other Coalescent-Based Species Tree Estimation Methods.

##Simulated Datasets
Links to the simulated datasets and species tree estimation methods used in this study can all be found at goo.gl/EgkWRk

##Scripts for Processing Simulated Datasets
Scripts to relabel phylip alignments (convert taxa names to integers via a specified dictionary taxa_dict.txt),
shorten phylip alignments, and combine shortened alignments into a nexus file are in the folder src-pipeline.

##Scripts for Running Species Tree Estimation Methods on the Simulated Datasets

The files in each "pipeline-" folder are a combination of shell scripts and qsub scripts 
for the UIUC campus cluster. 

0) pipeline-data_processing contains scripts to run the python code in src-pipeline. 

1) pipeline-summary_methods contains scripts to estimate gene trees on shortened alignments with 
FastTree-2 or RAxML, and to run ASTRAL and NJst on the estimated gene trees.

2) pipeline-SVDquartets contains scripts to run SVDquartets+PAUP* (PAUP*'s implementation of SVDquartets)
on nexus files of aggregated, shortened gene alignments. 

3) pipeline-concatenation has scripts to run unpartitioned concatenation with RAxML. 
