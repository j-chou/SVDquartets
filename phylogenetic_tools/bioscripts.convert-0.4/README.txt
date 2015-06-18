Introduction
============

Biopython scripts for converting molecular sequences.

Bioinformatics is bedevilled by a large number of file formats. Biopython
provides classes and IO functions that allow interconversion. This module
provides scripts that use Biopython internally to simply convert multiple
files on the commandline.


Installation
============

bioscripts.convert [#homepage]_ can be installed in a number of ways.
Biopython [#biopython]_ is a prerequisite.

Via easy_install or equivalent
------------------------------

From the commandline call::

	% easy_install bioscripts.convert
	
Superuser privileges may be required. 


Via setup.py
------------

Download a source tarball, unpack it and call setup.py to
install::

	% tar zxvf bioscripts.convert.tgz
	% cd bioscripts.convert
	% python setup.py install
	
Superuser privileges may be required. 



Usage
=====


::

	convbioseq.py [options] FORMAT INFILES ...
	
or::

	convalign.py [options] FORMAT INFILES ...

with the options:

  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i FORMAT, --input-format=FORMAT
                        The format of the input biosequence files. If not
                        supplied, this will be inferred from the extension of 
                        the files.
  -e EXTENSION, --output-extension=EXTENSION
                        The extension of the output biosequence files. If not
                        supplied, this will be inferred from the output format.
  -t TYPE, --seqtype=TYPE
                        The type of sequence (dna or protein) being converted.
                        Often this can be inferred from the input file, but 
                        sometimes must be explicitly set.

FORMAT must be one of clustal, fasta, genbank, nexus, phd, phylip, qual,
stockholm, tab. The input formats inferred from extensions are clustal
('.aln'), genbank ('.genbank'), nexus ('.nxs'), nexus ('.nexus'), phylip
('.phylip'), stockholm ('.sth'), phd ('.phd'), qual ('.qual'), phylip
('.phy'), clustal ('.clustal'), genbank ('.gb'), tab ('.tab'), fasta
('.fasta'), stockholm ('.stockholm'). The default extensions for output
formats are '.aln' (clustal), '.nexus' (nexus), '.phy' (phylip), '.phd' (phd),
'.qual' (qual), '.gb' (genbank), '.sth' (stockholm), '.fasta' (fasta).

For example::

	% convbioseq.py clustal one.fasta two.nxs three.stockholm

will produce three clustal formatted files 'one.aln', 'two.aln' and
'three.aln' from files it assumes are Fasta, Nexus and Stockholm formatted
respectively.

	% convbioseq.py -i phylip clustal one.fasta two.nxs

will produce two Phylip formatted files 'one.phy' and 'two.phy' and from files
it assumes are Fasta formatted.

	% convbioseq.py -e foo clustal one.fasta two.nxs
	
will produce two Clustal formatted files 'one.foo' and 'two.foo' from files
it assumes are Fasta and Nexus formatted respectively.	



Limitations
===========

This module is not intended for importing, but the setuptools packaging and
infrastructure make for simple distribution of scripts, allowing the checking
of prerequisites, consistent installation and updating.

The ``bioscripts`` namespace was chosen as a convenient place to "keep" these
scripts and is open to other developers.

Due to limitations on identifiers in certain formats, sequence names
may differ between input and output files. Also, not all formats understood by
Biopython have been enabled, due to being untested or incomplete.

Depending on your platform, the scripts may be installed as ``.py`` scripts,
or some form of executable, or both.

Some formats (e.g. FASTA) do not specify sequence type, while others (e.g. 
NEXUS), absolutely require it. Thus, the sequence type option may need to be 
explicitly specified. Older versions of Biopython contain a bug that will prevent 
conversion to nexus format for associated reasons.


References
==========

.. [#homepage] `bioscripts.convert homepage <http://www.agapow/net/software/bioscripts.convert>`__

.. [#biopython] `Biopython homepage <http://www.biopython.org>`__

.. [#setuptools] `Installing setuptools <http://peak.telecommunity.com/DevCenter/setuptools#installing-setuptools>`__



