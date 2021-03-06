#!/bin/bash                                                                      

MODELPATH=~/AGBsvdquartets/11-taxon_redo
cd $MODELPATH

rm -f FN_rates_11-taxon.csv
touch FN_rates_11-taxon.csv
echo "model,# taxa,method,# sites,# genes,replicate,FN rate" >> FN_rates_11-taxon.csv

#FN rates for ASTRAL, NJst, and RAxML with 10 runs
for MODEL in model.10.5400000.0.000000037 model.10.1800000.0.000000111 model.10.600000.0.000000333 model.10.200000.0.000001000; do
for N in 10 25 50 100 200; do
    for K in 100 500 1000; do
	# svdquartets_qmc astral astral_fasttree_genetrees njst njst_fasttree_genetrees RAxML_bestTree.concatenation
	for METHOD in astral_fasttree_genetrees njst_fasttree_genetrees RAxML_bestTree.concatenation_raxml_10runs; do

            #remove old files
	    rm -f temp_${METHOD}_${N}_${K}
	    touch temp_${METHOD}_${N}_${K}
	    
            #calculate FN rates for ${METHOD}
	    for SPECIESNUMBER in {1..50}; do 
		~/phylogenetic_tools/tree_comp/compareTrees.missingBranch ~/scratch/11-taxon_redo/${MODEL}/${SPECIESNUMBER}/S_relabeled_tree.trees ${MODELPATH}/${MODEL}/${SPECIESNUMBER}/${METHOD}_${N}_sites_${K}_genes.tree >> ${MODELPATH}/temp_${METHOD}_${N}_${K}
		TEMP=$(awk -vORS= '{ print $3 }' temp_${METHOD}_${N}_${K})
		echo "11-taxon_"${MODEL}",11,"${METHOD}","${N}","${K}","${SPECIESNUMBER}","${TEMP} >> FN_rates_11-taxon.csv
		rm temp_${METHOD}_${N}_${K}
	    done
done
done
done
echo "Finished getting ASTRAL, NJst, and RAxML FN rates for "${MODEL}
done

#FN rates for SVDquartets+PAUP*
for MODEL in model.10.5400000.0.000000037 model.10.1800000.0.000000111 model.10.600000.0.000000333 model.10.200000.0.000001000; do
for N in 10 25 50 100 200; do
    for K in 100 500 1000; do
	for METHOD in svdquartets_paup; do

            #remove old files
	    cd ${MODELPATH}
	    rm -f temp_${METHOD}_${N}_${K}
	    rm -f FN_${METHOD}_${N}_${K}_R_format.txt

	    for SPECIESNUMBER in {1..50}; do 
		~/phylogenetic_tools/tree_comp/compareTrees.missingBranch ~/scratch/11-taxon_redo/${MODEL}/${SPECIESNUMBER}/S_relabeled_tree.trees ${MODELPATH}/11-taxon_svdquartets_paup_trees/${MODEL}/${METHOD}_R${SPECIESNUMBER}_${N}_sites_${K}_genes.tree >> ${MODELPATH}/temp_${METHOD}_${N}_${K}
		TEMP=$(awk -vORS= '{ print $3 }' temp_${METHOD}_${N}_${K})
		echo "1-taxon_"${MODEL}",15,"${METHOD}","${N}","${K}","${SPECIESNUMBER}","${TEMP} >> FN_rates_11-taxon.csv
                rm temp_${METHOD}_${N}_${K}
	    done
done
done
done
echo "Finished getting SVDquartets+PAUP* FN rates for "${MODEL}
done