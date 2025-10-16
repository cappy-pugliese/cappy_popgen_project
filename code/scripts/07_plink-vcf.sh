#!/bin/bash
#SBATCH --job-name=plink
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=caprina.pugliese@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load plink/1.90.beta.4.4

## set variables
INDIR=/home/FCAM/cpugliese/lab_wns/vcfs/01_orig-vcfs
PLDIR=/isg/shared/apps/plink/plink-1.90beta4.4-x86_64/
OUTDIR=/home/FCAM/cpugliese/lab_wns/vcfs/03_filtered-vcfs/plink_files/02_plink-w-ld

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

# --maf
### Exclude variants with minor allele frequency lower than a threshold
# --geno
### Exclude variants with missing call frequencies greater than a threshold (default 0.1).  (Note that the default threshold is only applied if --geno is invoked without a parameter; when --geno is not invoked, no per-variant missing call frequency ceiling is enforced at all.  Other inclusion/exclusion default thresholds work the same way.)
# --mind
### Exclude samples with missing call frequencies greater than a threshold