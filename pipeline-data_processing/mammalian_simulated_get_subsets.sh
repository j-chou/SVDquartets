#!/bin/bash
#
#PBS -N 2X-200-500_subsets50and100
#PBS -l nodes=1:ppn=1
#PBS -l cput=4:00:00
#PBS -l walltime=4:00:00
#PBS -m be
#PBS -l naccesspolicy=singleuser
#PBS -M jedchou1@illinois.edu
#

SUBSET=50
SCRIPTPATH=~/scratch/2X-200-500
for SPECIESNUMBER in {1..20}; do
    for N in 10 25 50 100 200; do
    SPATH=${SCRIPTPATH}/R${SPECIESNUMBER}
    mkdir ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
    for GENENUMBER in {1..50}; do
	cp ${SPATH}/relabeled_shortened_data_${N}/${GENENUMBER}.fasta_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}/
	done
    done
done

SUBSET=100
SCRIPTPATH=~/scratch/2X-200-500
for SPECIESNUMBER in {1..20}; do
    for N in 10 25 50 100 200; do
    SPATH=${SCRIPTPATH}/R${SPECIESNUMBER}
    mkdir ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}
	for GENENUMBER in {1..100}; do
	    cp ${SPATH}/relabeled_shortened_data_${N}/${GENENUMBER}.fasta_relabeled_shortened.phy ${SPATH}/relabeled_shortened_data_${N}_subset_${SUBSET}/
	done
    done
done

