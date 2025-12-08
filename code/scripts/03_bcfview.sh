#!/bin/bash
#SBATCH --job-name=bcfview
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## variables
VCF=/path/to/orignial/vcf.gz
SAMPLES=/path/to/samples.txt
OUTDIR=/output/directory/for/filtered/vcf
OUTNAME=file-name-for-filtered-vcf.gz

## load modules
module load bcftools/1.9
# note bcftools 1.20 does not work when filtering with more than one -i option

bcftools view -S $SAMPLES \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $OUTDIR/$OUTNAME \
$VCF

########### script end