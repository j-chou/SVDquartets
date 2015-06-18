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

def processFilesTaxon(inp_folder,out_folder,dict_file):
    taxa_dict=defaultdict(str)
    dict_input=open(dict_file,'r')
    line=dict_input.readline()
    while(line and not(line.isspace())):
        parts=line.split()
        if(len(parts)==2):
            taxa_dict[parts[1]]=parts[0]
        line=dict_input.readline()
    inputfiles = [ f for f in listdir(inp_folder) if isfile(join(inp_folder,f)) ]
    for inp_file in inputfiles:
        print inp_file
        filetype=''
        sampler=False
        inp_path=join(inp_folder,inp_file)
        if inp_path.endswith('.phy'):
            filetype='phylip'
        elif inp_path.endswith('.fasta'):
            filetype='dnafasta'
        elif inp_path.endswith('s_tree.trees'):
            t = dendropy.Tree.get_from_path(inp_path, 'newick')
            for new_taxon in taxa_dict.keys():
                old_taxon=taxa_dict[new_taxon]
                node_to_change = t.find_node_with_taxon_label(old_taxon)
                if(not(node_to_change==None)):
                    new_Taxon = dendropy.Taxon(label=new_taxon)
                    node_to_change.taxon = new_Taxon
            out_path=join(inp_folder,'S_relabeled_tree.trees')
            newick_string=t.as_newick_string()+';'
            out_file=open(out_path,'w+')
            out_file.write(newick_string)
            out_file.close()
            continue
        else:
            continue
        dna = dendropy.DnaCharacterMatrix.get_from_path(inp_path,filetype)
        new_dna_string=""
        new_dna_string+=str(len(dna))+'\t'+str(dna.vector_size)+'\n'
        for i in range(1,len(dna)+1):
            new_taxon=str(i)
            old_taxon=taxa_dict[new_taxon]
            if(old_taxon and new_taxon and not(old_taxon.isspace()) and not(new_taxon.isspace())):
                new_dna_string+=new_taxon+'\t'+str(dna[old_taxon])+'\n'
        #print(new_dna_string)
        newdna=dendropy.DnaCharacterMatrix.get_from_string(new_dna_string,'phylip')
        if not os.path.exists(out_folder):
            os.makedirs(out_folder)
        fileno=inp_file.split('_')[0]
        out_file=fileno+'_relabeled.phy'
        out_path=join(out_folder,out_file)
        newdna.write_to_path(out_path,'phylip')
        #print(newdna.description(3))

if __name__ == "__main__":
    inp_folder=str(sys.argv[1])
    out_folder=join(str(sys.argv[1]),'relabeled_data')
    dict_file=str(sys.argv[2])
    processFilesTaxon(inp_folder,out_folder,dict_file)
