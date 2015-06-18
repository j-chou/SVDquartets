#!/bin/bash                                                                      

MODELPATH=~/AGBsvdquartets/2X-200-500
#usage: ./get_FN_rates.sh 25
for N in 10 25 50 100 200; do
    for K in 50 100 200; do
	#svdquartets_qmc astral_fasttree_genetrees njst_fasttree_genetrees RAxML_bestTree.concatenation concatenation_fasttree RAxML_bestTree.concatenation_raxml_10runs
	for METHOD in svdquartets_qmc astral_fasttree_genetrees njst_fasttree_genetrees; do

            #remove old files
	    cd ${MODELPATH}
	    rm -f temp_${METHOD}_${N}_${K}
	    rm -f FN_${METHOD}_${N}_${K}_R_format.txt
	    touch temp_${METHOD}_${N}_${K}
	    touch FN_${METHOD}_${N}_${K}_R_format.txt
            #calculate FN rates for ${METHOD}
	    for SPECIESNUMBER in {1..20}; do 
		~/phylogenetic_tools/tree_comp/compareTrees.missingBranch ~/scratch/2X-200-500/R${SPECIESNUMBER}/S_relabeled_tree.trees ${MODELPATH}/R${SPECIESNUMBER}/${METHOD}_${N}_sites_${K}_genes.tree >> ${MODELPATH}/temp_${METHOD}_${N}_${K}
	    done
            #format FN rates file
	    rm -f FN_${METHOD}_${N}_${K}
	    touch FN_${METHOD}_${N}_${K}
	    awk -vORS=, '{ print $3 }' temp_${METHOD}_${N}_${K} | sed 's/,$/\n/' >> FN_${METHOD}_${N}_${K}
	    rm temp_${METHOD}_${N}_${K}

            #write ${METHOD} FN rates in correct format for R 
	    TEMP=$(cat FN_${METHOD}_${N}_${K})
	    echo "mammals_2X_sim_"${METHOD}"_"${N}"_sites_"${K}"_genes=c("${TEMP}")" >> FN_${METHOD}_${N}_${K}_R_format.txt
	    rm FN_${METHOD}_${N}_${K}
done
done
done

