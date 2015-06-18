#Script to run SVDquartets+QMC or SVDquartets+wQMC.
#Usage: ./15_getquartets_run_svdquartets_qmc.sh <SPECIES_PATH> <DATA_PARENT> <N> <K> <WCODE>
#<SPECIES_PATH> is the folder containing the nexus file of aggregated gene alignments for a particular replicate species tree
#<DATA_PARENT> is the parent folder of <SPECIES_PATH>, i.e. the folder containing all folders of replicate species trees for a particular model condition
#<N> is the number of sites sampled per gene (in our paper, N ranges from 10 to 200)
#<K> is the number of genes (in our paper, K ranges from 100 to 1000 for the 11-taxon and 15-taxon datasets, and 50 to 200 for the 37-taxon mammalian simulated datasets
#<WCODE> takes values A,B,C,...,I. The letters refer to various ways of converting SVD scores into quartet weights for wQMC.  

#!/bin/bash
SPECIES_PATH=$1
DATA_PARENT=$2
N=$3
K=$4
WCode=$5

#Create .paup and run SVDquartets on the input NEXUS file, relabeled_shortened_combined_N_subset_K.nex where
#N is the number of sites per gene, and K is the number of genes
cd ${DATA_PARENT}/${SPECIES_PATH}

rm -f paup_svdquartets_quartet_trees_${N}_sites_${K}_genes.txt
touch paupfile_${N}_sites_${K}_genes.paup
echo "begin paup;" >> paupfile_${N}_sites_${K}_genes.paup
echo "CD "${DATA_PARENT}"/"${SPECIES_PATH}";" >> paupfile_${N}_sites_${K}_genes.paup
echo "Execute relabeled_shortened_combined_"${N}"_subset_"${K}".nex;" >> paupfile_${N}_sites_${K}_genes.paup
echo "log file=paup_svdquartets_quartet_trees_"${N}"_sites_"${K}"_genes.txt start;" >> paupfile_${N}_sites_${K}_genes.paup
echo "SVDquartets showScores=yes evalQuartets=all seed=5000;" >> paupfile_${N}_sites_${K}_genes.paup
echo "log stop;" >> paupfile_${N}_sites_${K}_genes.paup
echo "end;" >> paupfile_${N}_sites_${K}_genes.paup
echo "quit;" >> paupfile_${N}_sites_${K}_genes.paup

echo "RUNNING SVDQUARTETS"
~/AGBsvdquartets/src-pipeline/paup_linux paupfile_${N}_sites_${K}_genes.paup
rm -f paup_quartet_trees.txt
cp paup_svdquartets_quartet_trees_${N}_sites_${K}_genes.txt paup_quartet_trees.txt

#Run QMC/wQMC on the respective quartet tree files, qmc_quartet_trees.txt or wqmc_quartet_trees.txt
#Comment out the lines for wQMC to run wQMC. 
rm -f qmc_quartet_trees.txt
rm -f wqmc_quartet_trees.txt
echo "CONVERTING SVDQUARTET OUTPUT TO QMC/WQMC using WFCode ${WCode}"
python ~/AGBsvdquartets/src-pipeline/convert_svd_qmc_wqmc_${WCode}.py
cp qmc_quartet_trees.txt qmc_quartet_trees_${N}_sites_${K}_genes.txt
#cp wqmc_quartet_trees.txt "$wqmc_quartet_trees_${N}_sites_${K}_genes_${WCode}.txt"

echo "RUNNING QMC"
~/AGBsvdquartets/src-pipeline/max-cut-tree qrtt=qmc_quartet_trees.txt weights=off otre=~/AGBsvdquartets/${SPECIES_PATH}/svdquartets_qmc_${N}_sites_${K}_genes.tree

#echo "RUNNING wQMC"
#./src-pipeline/max-cut-tree qrtt=wqmc_quartet_trees.txt weights=on otre="${SPECIES_PATH}/svd_wqmc_s_tree_${N}_${K}_${WCode}.trees"

rm -f log.txt out.txt paup_quartet_trees.txt qmc_quartet_trees.txt wqmc_quartet_trees.txt input_data_for_paup.nex svd_DP_complementquartets svd_DP_I_complement_quartets
