#!/bin/bash                                                                      

#usage: ./get_FN_rates.sh 25 model.10.1800000.0.000000111
n=$1
MODEL=$2
MODELPATH=~/AGBsvdquartets/data/${MODEL}

#remove old files
cd ${MODELPATH}
rm -f temp_astral_${n}
rm -f temp_njst_${n}
rm temp_qmc_${n}_${n}
for WCODE in A B C D E F G H I J K L M N O; do
    rm temp_wqmc_${n}_${n}_${WCODE}
done

#calculate FN rates for svd+qmc/wqmc and summary method trees
for FOLDERNUMBER in {1..50}; do 
    cd ${MODELPATH}/${FOLDERNUMBER}
    cp ~/phylogenetic_tools/tree_comp/CompareTree.pl .
    cp ~/phylogenetic_tools/tree_comp/MOTree.pm .
    cp ~/phylogenetic_tools/tree_comp/compareTrees .
    cp ~/phylogenetic_tools/tree_comp/compareTrees.missingBranch .
    ./compareTrees.missingBranch S_relabeled_tree.trees njst_s_tree_${n}.trees >> ${MODELPATH}/temp_njst_${n}
    ./compareTrees.missingBranch S_relabeled_tree.trees astral_s_tree_${n}.trees >> ${MODELPATH}/temp_astral_${n}
    ./compareTrees.missingBranch S_relabeled_tree.trees svd_qmc_s_tree_${n}_${n}.trees >> ${MODELPATH}/temp_qmc_${n}_${n}
    for WCODE in A B C D E F G H I J K L M N O; do
        ./compareTrees.missingBranch S_relabeled_tree.trees svd_wqmc_s_tree_${n}_${n}_${WCODE}.trees >> ${MODELPATH}/temp_wqmc_${n}_${n}_${WCODE}
    done
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
rm -f FN_svd_qmc_${n}_${n}
touch FN_svd_qmc_${n}_${n}
awk -vORS=, '{ print $3 }' temp_qmc_${n}_${n} | sed 's/,$/\n/' >> FN_svd_qmc_${n}_${n}
rm temp_qmc_${n}_${n}
for WCODE in A B C D E F G H I J K L M N O; do
    rm -f FN_svd_wqmc_${n}_${n}_${WCODE}
    touch FN_svd_wqmc_${n}_${n}_${WCODE}
    awk -vORS=, '{ print $3 }' temp_wqmc_${n}_${n}_${WCODE} | sed 's/,$/\n/' >> FN_svd_wqmc_${n}_${n}_${WCODE}
    rm temp_wqmc_${n}_${n}_${WCODE}
done

rm -f FN_rates_all_${n}_R_format.txt
touch FN_rates_all_${n}_R_format.txt

#write ASTRAL FN rates in correct format for R 
TEMP=$(cat FN_astral_${n})
echo "FN_astral_"${n}"=c("${TEMP}")" >> FN_rates_all_${n}_R_format.txt
TEMP=$(cat FN_njst_${n})
echo "FN_njst_"${n}"=c("${TEMP}")" >> FN_rates_all_${n}_R_format.txt
#write SVDQuartets+QMC/wQMC FN rates in correct format for R
TEMP=$(cat FN_svd_qmc_${n}_${n})
echo "FN_svd_qmc_"${n}"_"${n}"=c("${TEMP}")" >> FN_rates_all_${n}_R_format.txt
for WCODE in A B C D E F G H I J K L M N O; do
    WTEMP=$(cat FN_svd_wqmc_${n}_${n}_${WCODE})
    echo "FN_svd_wqmc_"${n}"_"${n}"_"${WCODE}"=c("${WTEMP}")" >> FN_rates_all_${n}_R_format.txt
done

