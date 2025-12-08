#!/bin/bash
#SBATCH --job-name=pcangsd
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 6
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load pcangsd/1.0
source ~/.bashrc
    # need to add conda to path
conda activate pcangsd

## set variables
INDIR=/specify/in/directory/path/here
OUTDIR=/specify/out/directory/path/here
PCANGSD="python3 /path/to/pcangsd.py"

cd $OUTDIR

## PCAnsd
$PCANGSD -plink $INDIR/plink_pd \
-admix \
-out pcangsd_pd


conda deactivate
########### script end