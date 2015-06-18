#!/bin/bash
#
#PBS -N 11-taxon_54_subset_100and500
#PBS -l nodes=1:ppn=1
#PBS -l cput=4:00:00
#PBS -l walltime=4:00:00
#PBS -m be
#PBS -l naccesspolicy=singleuser
#PBS -M jedchou1@illinois.edu
#
MODEL=model.10.5400000.0.000000037
SCRIPTPATH=~/scratch/11-taxon_redo
SUBSET=100
for SPECIESNUMBER in {1..1}; do
    for N in 10 25 50 100 200; do
	SPATH=${SCRIPTPATH}/${MODEL}/${SPECIESNUMBER}
	mkdir ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	FILE=0${SUBSET}
	cp ${SPATH}/relabeled_shortened_data_${N}/${FILE}_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	for FILE in {0..0}{0..0}{0..9}{0..9}; do
	    cp ${SPATH}/relabeled_shortened_data_${N}/${FILE}_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	done
    done
done

SUBSET=500
for SPECIESNUMBER in {1..1}; do
    for N in 10 25 50 100 200; do
	SPATH=${SCRIPTPATH}/${MODEL}/${SPECIESNUMBER}
	mkdir ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	FILE=0${SUBSET}
	cp ${SPATH}/relabeled_shortened_data_${N}/${FILE}_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	for FILE in {0..0}{0..4}{0..9}{0..9}; do
            cp ${SPATH}/relabeled_shortened_data_${N}/${FILE}_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	done
    done
done