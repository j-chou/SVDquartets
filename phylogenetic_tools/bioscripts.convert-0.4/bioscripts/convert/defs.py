#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Module-wide definitions and constants.

"""

__docformat__ = 'restructuredtext en'


### IMPORTS ###

from Bio import (Alphabet)
from Bio.Alphabet import (IUPAC)
from Bio.Data import (IUPACData)

__all__ = [
	'FORMATS',
	'EXT_TO_FORMAT',
	'FORMAT_TO_EXT',
	'KNOWN_FMTS',
	'VERSION',
	'EPILOG',
	'BIOSEQ_ALPHABET_DNA',
	'BIOSEQ_ALPHABET_PROTEIN',
]


### CONSTANTS & DEFINES ###
# Formats in SeqIO that we don't parse as yet. There's no actual problem,
# these just need to be checked:
# ace embl fastq fastq-solex ig pir swiss tab qual

# list of handled formats, parse these into input and output lists
FORMATS = {
	# format name : [extensions, preferred first]
	# name is always a possible extension
	'clustal'    : ['aln'],
	'fasta'      : ['fasta', 'fas'],
	'genbank'    : ['gb', 'gbk', 'gbank'], 
	'nexus'      : ['nexus', 'nex', 'nxs', 'paup'],
	'phd'        : ['phd'],
	'phylip'     : ['phy'],
	'stockholm'  : ['sth'],
	'qual'       : ['qual'],
	'tab'        : ['tab'],
}

# map files extensions (infiles) to formats
EXT_TO_FORMAT = {}
for k, v in FORMATS.iteritems():
	EXT_TO_FORMAT[k] = k
	for ext in v:
		EXT_TO_FORMAT[ext] = k

# map format to preferred files extensions (outfiles)
FORMAT_TO_EXT = {}
for k, v in FORMATS.iteritems():
	FORMAT_TO_EXT[k] = v[0]

KNOWN_FMTS = FORMATS.keys()

EPILOG = 'FORMAT must be one of %s.\n' % ', '.join (sorted (KNOWN_FMTS))

BIOSEQ_GAP = '-'

BIOSEQ_ALPHABET_GAPPEDAMBIGDNA = Alphabet.Gapped (IUPAC.ambiguous_dna,
	BIOSEQ_GAP)
BIOSEQ_ALPHABET_DNA = BIOSEQ_ALPHABET_GAPPEDAMBIGDNA

BIOSEQ_ALPHABET_GAPPEDAMBIGPROTEIN = Alphabet.Gapped (IUPAC.extended_protein,
	BIOSEQ_GAP)
BIOSEQ_ALPHABET_PROTEIN = BIOSEQ_ALPHABET_GAPPEDAMBIGPROTEIN

try:
	from bioscripts.convert import __version__ as VERSION
except:
	VERSION = 'unknown'


_DEV_MODE = True


### IMPLEMENTATION ###

### END ######################################################################
