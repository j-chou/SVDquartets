#!/bin/bash
#
#PBS -N 11-taxon_54_convert_nexus_to_phy
#PBS -l nodes=1:ppn=1
#PBS -l cput=1:00:00
#PBS -l walltime=1:00:00
#PBS -t 1-50
#

MODEL=model.10.5400000.0.000000037
for SPECIESNUMBER in {1..50}; do
    for N in 10 25 50 100 200; do
	for K in 100 500 1000; do
	python ~/phylogenetic_tools/bioscripts.convert-0.4/bioscripts/convert/convalign.py phylip ~/scratch/11-taxon_redo/${MODEL}/${SPECIESNUMBER}/relabeled_shortened_combined_${N}_subset_${K}.nex 
	done
    done
done
