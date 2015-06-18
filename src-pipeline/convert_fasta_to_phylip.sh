#!/bin/bash

i=$1
j=$2
~/AGBsvdquartets/src-pipeline/Fasta2Phylip.pl ~/scratch/AGBsvdquartets/data/sim${i}/${j}.fasta  ~/scratch/AGBsvdquartets/data/sim${i}/${j}.phy
