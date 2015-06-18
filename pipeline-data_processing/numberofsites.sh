#This script shortens phylip alignments to length N.
#Usage: ./numberofsites <SPECIES_PATH> <DATA_PARENT> <N> <CFLAG>
#<SPECIES_PATH> is the folder (not path) containing the phylip alignments
#<DATA_PARENT> is the full path to the parent folder of the SPECIES_PATH folder
#<N> is the desired sequence length (in our paper, N ranged from 10 to 200)
#<CFLAG> should always be equal to 1. It is an option to sample sites from sequence alignments uniformly randomly, but the current code doesn't support this option anymore.

#!/bin/bash
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 input_speciestree_path data_parent_folder_path n contiguousflag"
  exit 1
fi

SPECIES_PATH=$1
DATA_PARENT=$2
N=$3
Cflag=$4


if [  ! -d ${SPECIES_PATH} ]; then
	echo "CREATING DIRECTORY ${SPECIES_PATH}"
	mkdir -p ${SPECIES_PATH}
fi

#Edit the path ~/AGBsvdquartets/2X-200-500/taxa_dict.txt to the path for your own dictionary taxa_dict.txt 
if [  ! -d "${DATA_PARENT}/${SPECIES_PATH}/relabeled_data" ]; then
	echo "RELABELING DATA AT ${SPECIES_PATH}"
	python src-pipeline/taxon_relabeler.py "${DATA_PARENT}/${SPECIES_PATH}" ~/AGBsvdquartets/2X-200-500/taxa_dict.txt
	cp "${DATA_PARENT}/${SPECIES_PATH}/S_relabeled_tree.trees" "${SPECIES_PATH}/S_relabeled_tree.trees"
fi

if [  ! -d "${DATA_PARENT}/${SPECIES_PATH}/relabeled_shortened_data_${N}" ]; then
	if [  "${Cflag}" == "0" ]; then
		echo "SHORTENING DATA ${SPECIES_PATH} non-continously for N=${N}"
		python src-pipeline/gene_length_shortener.py "${DATA_PARENT}/${SPECIES_PATH}" ${N}
	fi

	if [  "${Cflag}" == "1" ]; then
		echo "SHORTENING DATA ${SPECIES_PATH} continously for N=${N}"
		python src-pipeline/gene_length_shortener.py "${DATA_PARENT}/${SPECIES_PATH}" ${N} -c
	fi
fi

rm -f log.txt out.txt paup_quartet_trees.txt qmc_quartet_trees.txt wqmc_quartet_trees.txt input_data_for_paup.nex svd_DP_complementquartets svd_DP_I_complement_quartets 
