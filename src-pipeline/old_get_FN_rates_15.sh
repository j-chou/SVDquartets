#!/bin/bash                                                                      

#usage: ./get_FN_rates.sh 25
n=$1
MODELPATH=~/scratch/AGBsvdquartets/data/model

#remove old files
cd ${MODELPATH}
rm -f temp_astral_${n}
rm -f temp_njst_${n}

#calculate FN rates for astral and njst trees
for FOLDERNUMBER in {1..10}; do 
    cd ${MODELPATH}/${FOLDERNUMBER}
    cp ~/phylogenetic_tools/tree_comp/CompareTree.pl .
    cp ~/phylogenetic_tools/tree_comp/MOTree.pm .
    cp ~/phylogenetic_tools/tree_comp/compareTrees .
    cp ~/phylogenetic_tools/tree_comp/compareTrees.missingBranch .
    ./compareTrees.missingBranch S_relabeled_tree.trees njst_s_tree_${n}.trees >> ${MODELPATH}/temp_njst_${n}
    ./compareTrees.missingBranch S_relabeled_tree.trees astral_s_tree_${n}.trees >> ${MODELPATH}/temp_astral_${n}
    rm CompareTree.pl
    rm MOTree.pm
    rm compareTrees*
done

#format FN rates file
cd ${MODELPATH}
rm -f FN_astral_${n}
touch FN_astral_${n}
awk -vORS=, '{ print $3 }' temp_astral_${n} | sed 's/,$/\n/' >> FN_astral_${n}
rm temp_astral_${n}
rm -f FN_njst_${n}
touch FN_njst_${n}
awk -vORS=, '{ print $3 }' temp_njst_${n} | sed 's/,$/\n/' >> FN_njst_${n}
rm temp_njst_${n}

rm -f FN_rates_all_${n}_R_format.txt
touch FN_rates_all_${n}_R_format.txt

#write ASTRAL FN rates in correct format for R 
TEMP=$(cat FN_astral_${n})
echo "FN_astral_"${n}"=c("${TEMP}")" >> FN_rates_all_${n}_R_format.txt
TEMP=$(cat FN_njst_${n})
echo "FN_njst_"${n}"=c("${TEMP}")" >> FN_rates_all_${n}_R_format.txt

rm FN_astral_${n}
rm FN_njst_${n}