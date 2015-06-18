__author__ = 'shashank'

import os
import os.path
import operator
import math
import dendropy
from os.path import isfile,join
from os import listdir
import random
from collections import defaultdict
import sys

def processFiles(inp_folder,out_file):
    inputfiles = [ join(inp_folder,f) for f in listdir(inp_folder) if isfile(join(inp_folder,f)) ]
    superdna=dendropy.DnaCharacterMatrix()
    #print (superdna.description())
    for inp_file in inputfiles:
        if (not(inp_file.endswith('.phy'))):
            continue
        dna = dendropy.DnaCharacterMatrix.get_from_path(inp_file,"phylip")
        superdna.extend(dna,False,True)
    new_dna_string=""
    new_dna_string+=str(len(superdna))+'\t'+str(superdna.vector_size)+'\n'
    for i in range(1,len(superdna)+1):
        new_taxon=str(i)
        if(new_taxon and not(new_taxon.isspace())):
            new_dna_string+=new_taxon+'\t'+str(superdna[new_taxon])+'\n'
    newdna=dendropy.DnaCharacterMatrix.get_from_string(new_dna_string,'phylip')
    newdna.write_to_path(out_file,'nexus')

if __name__ == "__main__":
    n=int(sys.argv[2])
    k=int(sys.argv[3])
    curr_folder=str(sys.argv[1])
    inp_folder=join(curr_folder,'relabeled_shortened_sampled_data_'+str(n)+'_'+str(k))
    out_file=join(curr_folder,'relabeled_shortened_sampled_combined_'+str(n)+'_'+str(k)+'.nex')
    processFiles(inp_folder,out_file)