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
import getopt

def processFilesTaxon(inp_folder,out_folder,k):
    inputfiles = [ f for f in listdir(inp_folder) if isfile(join(inp_folder,f)) ]
    for inp_file in inputfiles:
        print inp_file
        filetype=''
        sampler=False
        inp_path=join(inp_folder,inp_file)
        if inp_path.endswith('.phy'):
            filetype='phylip'
        else:
            continue
        newdna = dendropy.DnaCharacterMatrix.get_from_path(inp_path,filetype)
        if not os.path.exists(out_folder):
            os.makedirs(out_folder)
        indexlist=random.sample(xrange(newdna.vector_size),k)
        newdna=dendropy.DnaCharacterMatrix.export_character_indices(newdna,indexlist)
        fileno=inp_file.split('_')[0]
        out_file=fileno+'_relabeled_shortened_sampled.phy'
        out_path=join(out_folder,out_file)
        newdna.write_to_path(out_path,'phylip')
        #print(newdna.description(3))

if __name__ == "__main__":
    n=int(sys.argv[2])
    k=int(sys.argv[3])
    inp_folder=join(str(sys.argv[1]),'relabeled_shortened_data_'+str(n))
    out_folder=join(str(sys.argv[1]),'relabeled_shortened_sampled_data_'+str(n)+'_'+str(k))
    processFilesTaxon(inp_folder,out_folder,k)
