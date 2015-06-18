#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Functions shared between scripts.

"""

__docformat__ = 'restructuredtext en'


### IMPORTS ###

from os import path
from optparse import OptionParser

from defs import *

__all__ = [
	'make_optparser',
]


### CONSTANTS & DEFINES ###

### IMPLEMENTATION ###

def parse_args (name):
	"""
	Construct the optparser for either script.
	
	Since they have an identical API, just pass a name for the descriptions.
	"""
	usage = '%prog [opts] FORMAT INFILES ...'
	version = "version %s" % VERSION	
	optparser = OptionParser (usage=usage, version=version, epilog=EPILOG)
	
	optparser.add_option ('--input-format', '-i',
		dest="input_format",
		help='''The format of the input %s files. If not supplied, this will be
			inferred from the extension of the files.''' % name,
		metavar='FORMAT',
		default='',
	)
			
	optparser.add_option ('--output-extension', '-e',
		dest="output_extension",
		help='''The extension of the output %s files. If not supplied,
		this will be inferred from the output format.''' % name,
		metavar='EXTENSION',
		default='',
	)
	
	optparser.add_option ('--seqtype', '-t',
		dest="seqtype",
		help='''The type of sequence (dna or protein) being converted. Often
			this can be inferred from the input file, but sometimes must be
			explicitly set.''',
		default = '',
		metavar='TYPE',
	)
	
	opts, pargs = optparser.parse_args()
	
	# check args ...
	# ... check output format
	if (len (pargs) < 1):
		optparser.error ('No output format specified')
	out_fmt = pargs[0].strip().lower()
	if (out_fmt not in KNOWN_FMTS):
		optparser.error ("unknown output format")
	# ... check input format
	if (opts.input_format) and (opts.input_format not in KNOWN_FMTS):
		optparser.error ("unknown input format")
	# ... check input files
	infiles = pargs[1:]
	if (not infiles):
		optparser.error ('No input files specified')
	# ... check seqtype
	seqtype = opts.seqtype.strip().lower()
	if (opts.seqtype not in ['dna', 'protein', '']):
		optparser.error ("unknown sequence type")
	elif opts.seqtype == 'dna':
		alphabet = BIOSEQ_ALPHABET_DNA
	elif opts.seqtype == 'protein':
		alphabet = BIOSEQ_ALPHABET_PROTEIN
	else:
		alphabet = None
	opts.seqtype = alphabet
	
	## Postconditions & return:
	return out_fmt, infiles, opts


def dir_base_ext (in_path):
	# extract base name and input format
	dir_name, file_name = path.split (in_path) 
	base_name, orig_ext = path.splitext (file_name)
	if (orig_ext.startswith ('.')):
		orig_ext = orig_ext[1:]
	return dir_name, base_name, orig_ext


def make_out_path (dir_name, base_name, ext):
	return path.join (dir_name, '%s.%s' % (base_name, ext))



### END ######################################################################
