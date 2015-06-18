#!/bin/bash
#
#PBS -N 11-taxon_20_subset_100and500
#PBS -l nodes=1:ppn=1
#PBS -l cput=4:00:00
#PBS -l walltime=4:00:00
#PBS -m be
#PBS -l naccesspolicy=singleuser
#PBS -M jedchou1@illinois.edu
#

SUBSET=100
SCRIPTPATH=~/scratch/15-taxon_redo
for SPECIESNUMBER in {1..10}; do
    for N in 10 25 50 100 200; do
    SPATH=${SCRIPTPATH}/${SPECIESNUMBER}
    mkdir ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	for GENENUMBER in {1..100}; do
	    cp ${SPATH}/relabeled_shortened_data_${N}/${GENENUMBER}.fasta_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}/
	done
    done
done

SUBSET=500
SCRIPTPATH=~/scratch/15-taxon_redo
for SPECIESNUMBER in {1..10}; do
    for N in 10 25 50 100 200; do
    SPATH=${SCRIPTPATH}/${SPECIESNUMBER}
    mkdir ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
    for GENENUMBER in {1..500}; do
	    cp ${SPATH}/relabeled_shortened_data_${N}/${GENENUMBER}.fasta_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}/
	    done
    done
done
