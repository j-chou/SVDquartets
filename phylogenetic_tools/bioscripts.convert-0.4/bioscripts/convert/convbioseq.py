#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Convert biosequences from one format to another.

"""
# TODO: all the format crap should be in one table

__docformat__ = 'restructuredtext en'
__author__ = 'Paul-Michael Agapow <agapow@bbsrc.ac.uk>'


### IMPORTS ###

from exceptions import BaseException

from Bio import SeqIO, AlignIO

from defs import *
import common

try:
	from bioscripts.convert import __version__
except:
	__version__ = 'unknown'


### CONSTANTS & DEFINES ###

### IMPLEMENTATION ###

def main():
	out_fmt, infiles, opts = common.parse_args('biosequence')
	
	for in_path in infiles:
		dir, base, ext = common.dir_base_ext (in_path)
		in_fmt = (opts.input_format or EXT_TO_FORMAT.get (ext, '')).lower()
		assert (in_fmt), "no known input format specified"
		
		# calculate output format and name
		out_path = common.make_out_path (dir, base,
			opts.output_extension or FORMAT_TO_EXT[out_fmt])
		
		# open & read infile
		in_hndl = open (in_path, 'rb')
		in_seqs = [x for x in SeqIO.parse (in_hndl, in_fmt)]
		in_hndl.close()
		assert (in_seqs), \
			'''No sequences read from %s. Perhaps the file is not in %s format.''' % (file_name, in_fmt)
		
		# write out
		out_hndl = open (out_path, 'wb')
		if opts.seqtype:
			for s in in_seqs:
				s.alphabet = opts.seqtype
		if out_fmt in ['nexus']:
			# need to hack to handle this crap
			from Bio.Align import MultipleSeqAlignment
			aln = MultipleSeqAlignment(in_seqs,
				alphabet=opts.seqtype or BIOSEQ_ALPHABET_PROTEIN)
			AlignIO.write (aln, out_hndl, out_fmt)
		else:
			SeqIO.write (in_seqs, out_hndl, out_fmt)
		out_hndl.close()
		


### TEST & DEBUG ###

### MAIN ###

if __name__ == '__main__':
	try:
		main()
	except BaseException, err:
		if (_DEV_MODE):
			raise
		else:
			print err
	except:
		print "An unknown error occurred.\n"



### END ######################################################################
