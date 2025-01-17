#!/usr/bin/env bash
set -e

#######################################################################

#Program that downloads and install software prerequisites and hs38DH.fa

########################################################################


. $HP_SDIR/init.sh

cd $HP_HDIR/
mkdir -p prerequisites/ $HP_BDIR/ $HP_JDIR/

cd prerequisites/
wget -N -c https://netactuate.dl.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2
wget -N -c https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2
wget -N -c https://github.com/samtools/bcftools/releases/download/1.11/bcftools-1.11.tar.bz2
wget -N -c https://github.com/samtools/htslib/releases/download/1.11/htslib-1.11.tar.bz2
wget -N -c https://github.com/GregoryFaust/samblaster/releases/download/v.0.1.26/samblaster-v.0.1.26.tar.gz
wget -N -c https://github.com/vcftools/vcftools/releases/download/v0.1.16/vcftools-0.1.16.tar.gz
wget -N -c https://github.com/arq5x/bedtools2/releases/download/v2.29.2/bedtools-2.29.2.tar.gz
wget -N -c https://github.com/OpenGene/fastp/archive/v0.20.1.tar.gz
wget -N -c https://github.com/broadinstitute/gatk/releases/download/4.2.0.0/gatk-4.2.0.0.zip
wget -N -c https://github.com/seppinho/haplogrep-cmd/releases/download/v2.2.9/haplogrep.zip
wget -N -c https://github.com/genepi/haplocheck/releases/download/v1.3.3/haplocheck.zip
wget -N -c https://github.com/seppinho/mutserve/releases/download/v2.0.0-rc12/mutserve.zip

