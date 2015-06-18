__author__ = 'shashank'

import os.path
import numpy as np
import operator
import math

def getInput(inp_file,out_file,outw_file):
    inpf= open(inp_file, 'r')
    outf=open(out_file,'w')#input file for qmc
    outfw=open(outw_file,'w')#input file for wqmc
    found=False
    while(not(found)):
        line=inpf.readline()
        if(line=='SVD scores for each quartet\n'):
            found=True
    line=inpf.readline()
    line=inpf.readline()
    line=inpf.readline()
    line=inpf.readline()
    while(not(line=='\n')):
        svdscores_dict = {}
        parts=line.split()
        a=parts[1]
        b=parts[2]
        c=parts[4]
        d=parts[5]
        svdscores_dict[a+','+b+'|'+c+','+d] = float(parts[6])
        for i in range(2):
            line=inpf.readline()
            parts=line.split()
            a=parts[0]
            b=parts[1]
            c=parts[3]
            d=parts[4]
            svdscores_dict[a+','+b+'|'+c+','+d] = float(parts[5])

        sorted_svdscores_list = sorted(svdscores_dict.items(), key=operator.itemgetter(1))
        svd_min = sorted_svdscores_list[0][1]
        svd_med = sorted_svdscores_list[1][1]
        svd_max = sorted_svdscores_list[2][1]
        if(svd_max>0 and not(svd_min==svd_med)):
            R = (svd_med-svd_min)/(svd_max*math.exp(svd_max-svd_med))
            split0_weight = (1/math.exp(svd_min))*R
            split1_weight = (1/math.exp(svd_med))*R
            split2_weight = (1/math.exp(svd_max))*R
            outf.write(sorted_svdscores_list[0][0]+' ')
            outfw.write(sorted_svdscores_list[0][0]+':'+str(split0_weight)+' ')
            outfw.write(sorted_svdscores_list[1][0]+':'+str(split1_weight)+' ')
            outfw.write(sorted_svdscores_list[2][0]+':'+str(split2_weight)+' ')
        line=inpf.readline()

if __name__ == "__main__":
   getInput('paup_quartet_trees.txt','qmc_quartet_trees.txt','wqmc_quartet_trees.txt')
