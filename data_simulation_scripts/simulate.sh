#!/bin/bash


rep=50
genes=1000
sp=10
#for b in 0.000001; do
	for t in 5400000 1800000 600000 200000; do  
		b=0`echo "scale=9; 1 / $t / 5"|bc -l`
		./simphy -RS $rep -RL U:$genes,$genes -RG 1 -ST U:$t,$t -SI U:1,1 -SL U:$sp,$sp -SB U:$b,$b -CP U:400000,400000 -HS L:1.5,1 -HL L:1.2,1 -HG L:1.4,1 -CU E:10000000 -SO U:1,1 -OD 1 -OR 0 -V 3  -CS 293745 -O model.$sp.$t.$b |grep -E "[:-]"| tee log.$sp.$t.$b; 
		rm model.$sp.$t.$b/*/l_trees.trees
		for r in `ls -d model.$sp.$t.$b/*`; do 
			sed -i "" -e "s/_0_0//g" $r/g_trees*.trees; 
		done
		perl post_stidsim.pl `pwd`/model.$sp.$t.$b 1 
		for r in `ls -d model.$sp.$t.$b/*`; do  
			cat $r/g_trees*.trees > $r/truegenetrees; 
			rm  $r/g_trees*.trees; 
		done
	done 
#done



# find . -name control.txt -execdir sh -c 'condor_run indelible &' \;
