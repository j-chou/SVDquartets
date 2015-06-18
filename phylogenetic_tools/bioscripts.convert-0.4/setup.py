from setuptools import setup, find_packages
import os

from bioscripts.convert import __version__

setup (
	name='bioscripts.convert',
	version=__version__,
	description="Biopython scripts for converting molecular sequences between formats.",
	long_description=open("README.txt").read() + "\n" +
	open(os.path.join("docs", "HISTORY.txt")).read(),
	# Get more strings from http://www.python.org/pypi?%3Aaction=list_classifiers
	classifiers=[
		"Development Status :: 4 - Beta",
		"Environment :: Console",
		"Intended Audience :: Science/Research",
		"License :: OSI Approved :: BSD License",
		"Topic :: Scientific/Engineering :: Bio-Informatics",
		"Programming Language :: Python",
		"Topic :: Software Development :: Libraries :: Python Modules",
		"Topic :: Text Processing",
	],
	keywords='bioinformatics conversion',
	author='Paul-Michael Agapow',
	author_email='agapow@bbsrc.ac.uk',
	url='http://www.agapow.net/software/bioscripts.convert',
	license='BSD',
	packages=find_packages(exclude=['ez_setup']),
	namespace_packages=['bioscripts'],
	include_package_data=True,
	zip_safe=False,
	install_requires=[
		'setuptools',
		'biopython >= 1.49',
	],
	entry_points={
		'console_scripts': [
			'convbioseq = bioscripts.convert.convbioseq:main',
			'convalign = bioscripts.convert.convalign:main',
		],
	},
	#scripts=[
	#	'bioscripts/convert/convbioseq.py',
	#],
)
