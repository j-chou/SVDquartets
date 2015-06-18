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

def processFilesTaxon(inp_folder,out_folder,n,contigous):
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
        if(contigous):
            #startindex=random.randint(0,newdna.vector_size-n)
            indexlist=xrange(0,n)
        else:
            indexlist=random.sample(xrange(newdna.vector_size),n)
        newdna=dendropy.DnaCharacterMatrix.export_character_indices(newdna,indexlist)
        fileno=inp_file.split('_')[0]
        out_file=fileno+'_relabeled_shortened.phy'
        out_path=join(out_folder,out_file)
        newdna.write_to_path(out_path,'phylip')

def checkarguments(argv):
    try:
      opts, args = getopt.getopt(argv,"c")
    except getopt.GetoptError:
      print 'gene_length_shortener.py <input_path> <n> -c'
      sys.exit(2)
    contigous=False
    for opt, arg in opts:
      if opt == '-c':
         contigous=True
    return contigous,args

if __name__ == "__main__":
    contigous,args=checkarguments(sys.argv[1:])
    n=int(args[1])
    inp_folder=join(str(args[0]),'relabeled_data')
    out_folder=join(str(args[0]),'relabeled_shortened_data_'+str(n))
    processFilesTaxon(inp_folder,out_folder,n,contigous)
