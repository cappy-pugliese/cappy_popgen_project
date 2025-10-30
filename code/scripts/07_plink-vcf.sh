#!/bin/bash
#SBATCH --job-name=plink
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load plink/1.90.beta.4.4

## set variables
INDIR=/specify/in/directory/path/here
PLDIR=/specify/plink/path/location/here
OUTDIR=/specify/out/directory/path/here

cd $OUTDIR

$PLDIR/plink --vcf $INDIR/pd.vcf.gz \
--make-bed \
--double-id \
--allow-extra-chr \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--out plink_pd

########### script end