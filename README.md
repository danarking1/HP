# PREREQUISEITES

* executables: bwa, samtools, bcftools, htslib, samblaster, vcftools
    wget https://netactuate.dl.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2<br>
    wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2<br>
    wget https://github.com/samtools/bcftools/releases/download/1.11/bcftools-1.11.tar.bz2<br>
    wget https://github.com/samtools/htslib/releases/download/1.11/htslib-1.11.tar.bz2<br>
    git clone git://github.com/GregoryFaust/samblaster.git<br>
    git clone https://github.com/vcftools/vcftools.git<br>

* java: picard, mutserve, gatk (Mutect2), haplogrep
  wget https://github.com/broadinstitute/picard/releases/download/2.23.8/picard.jar<br>
  wget https://github.com/broadinstitute/gatk/releases/download/4.1.9.0/gatk-4.1.9.0.zip<br>
  wget https://github.com/seppinho/haplogrep-cmd/releases/download/v2.2.9/haplogrep.zip<br>

<br>
* RefSeq: hs38DH<br>
  wget ftp://ftp.ccb.jhu.edu/pub/dpuiu/Homo_sapiens/hs38DH/hs38DH.fa<br>

# FILES
<br>
$ tree <br>
scripts/<br>
|-- run.sh                              # main executable, calls "filter.sh" on multiple .bam/.cram files provided in an input file;<br>
|-- checkInstall.sh			# check prerequisites<br>
|-- init.sh				# set environment variables<br>
|-- init_marcc.sh                       # specific to MARCC<br>
|-- filter.sh				# filter/realign reads, calls SNP/INDELs, filter SNP/INDELs at multiple heteroplamsy levels<br>
|-- readCount.sh			# count reads: all, mapped, chrM, filtered<br>
|-- snpCount.sh				# merge, count SNP/INDELs, HOM/HET(AF=) at multiple heteroplamsy levels<br>
|-- snpCount1.sh			$ merge, count SNP/INDELs, HOM/HET(AF=) for a given heteroplamsy level<br>
|-- circSam.pl				# "circularizes" SAM alignments; extend reference, align & split reads spanning circ. point<br>
|-- count.pl				# count values in a certain column (-i; 0 based)<br>
|-- fa2Vcf.pl				# creates "##reference" & "##contig" VCF headers<br>
|-- filterVcf.pl			# filter VCF files; discard HETEROZYGOUS SNP/INDELs with AF less than a THOLD<br>
|-- fixmutect2Vcf.pl			# postprocess gatk Mutect2 output<br>
|-- fixmutserveVcf.pl			# postprocess mutserve output<br>
|-- join.pl				# join 2 files by the 1st column<br>
|-- labelVcf.pl				# add the homopolimer tag(HP) to SNPs located at certain positions<br>
|-- maxVcf.pl				# get the major allele<br>
|-- mutect2.vcf				# mutect2 VCF header<br>
|-- mutserve.vcf			# mutserve VCF header<br>
|-- uniq2.pl				# filters unique lines based on 2 columns (-i 0 -j 1)<br>
java/					# jars<br>
|-- gatk.jar<br>
|-- haplogrep.jar<br>
|-- mutserve.jar<br>
bin/                                    # executables (in case they have not been already installed)<br>
|-- ...<br>
RefSeq/                                 # references: chrM, hs38DH, rCRS<br>
|-- hs38DH.fa        	                # to be	downloaded separately<br>
|-- chrM.fa<br>
|-- rCRS.fa<br>
|-- RSRS.fa<br>

# LEGEND

<br>
* metadata<br>
  Run   	: SRR<br>
  rdLen		: AvgReadLength (run)<br>
  ...<br>

<br>
* read counts<br>
  chrM		: number of reads aligned to chrM <br>

<br>
* computed coverage<br>
  Gcvg		: recomputed genome coverage: Bases/3217346917 <br>
  Mcvg		: mitochondrion covearge: chrM*rdLen/16569<br>

<br>
* mtDNA copy number<br>
  M		: Gcvg based:  2*Mcvg/Gcvg<br>

<br>
* mutect2 results<br>
  haplogroup	: mutect2 haploroup<br>
  03%S		: homozygous SNPs, 3% heteroplasmy rate<br>
  03%S		: heterozygous<br>
  03%I		: homozygous INDELs<br>
  03%i		: heterozygous INDELs<br>
  ...<br>
  05%<br>
  10%<br>

# EXAMPLE 1
<br>
1. init ; could add content to ~/.bash_profile
  $ source HP/scripts/init.sh		
  # source HP/scripts/init_marcc.sh      # MARCC

2. check install (once) ; if successfull => "Success message!" at the end
  $ HP/scripts/checkInstall.sh

3. generate input file list (.bam or .cram)
  $ find bams/ -name "*bam" > in.txt  

3o. split input file (optional; sets of 100)
  split -d -a 1 --numeric=3  -l 100 in.txt  in. --additional-suffix=.txt  

4. run "run.sh" script ; if successful  generates "filter.all.sh"
  $ HP/scripts/run.sh in.txt out > filter.all.sh

4o. on multiple files
  $ HP/scripts/run.sh in.000.txt out/ > filter.1.sh
  $ HP/scripts/run.sh in.001.txt out/ > filter.2.sh
  ...

5. check filter.all.sh
  $ cat filter.*.sh

6. execute filter.all.sh
  $ nohup ./filter.all.sh 
  # sbatch --time=24:0:0 ./filter.all.sh   # MARCC

# EXAMPLE 2
4. use RSRS.fa for realignment
  HP/scripts/run.sh filter.1.txt filter.1/ hs38DH.fa RSRS.fa 

# EXAMPLE 3
4. use rCRS.fa for realignment, mutserve for SNP calling
  HP/scripts/run.sh filter.1.txt filter.1/ hs38DH.fa rCRS.fa  mutserve

