# Cappy's Popgen Project

## Data used for the project

I will be working on the same vcf dataset that I am using for my current Master's project looking at *Pseudogymnoascus destructans* individuals, the organism responsible for White Nose Syndrome in bats. This data was compiled from the NCBI database for *P. destructan* whole genome sequence samples taken from North America. I have already processed the dataset into a vcf with 74 *P. destructans* individuals.

## Population structure analysis

To look at population structure, I'll be using PCAngsd version 1.0 and generating a graph of the population structure it calculates.

### Running Plink

In order for PCAngsd to run, we need to use Plink to generate some output. Here, I used Plink version 1.90.beta.4.4 (mainly because that was the most recent version that worked for me that was already installed on the cluster). The full Plink script can be found [here,](code/scripts/07_plink-vcf.sh) but these are the options I specified for my script:

```{bash}
$PLDIR/plink --vcf $INDIR/pd.vcf.gz \
--make-bed \
--double-id \
--allow-extra-chr \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--out plink_pd
```

The `--make-bed` and `--out` arguments [are needed]{.underline} in order to get the proper output plink files needed for PCAngsd

The `--maf`, `--geno`, and `--mind` options all help with filtering out any variants that don't meet specific thresholds:

-   `--maf` specifies the minor allele frequency threshold for variants
-   `--geno` specifies the missing call frequencies threshold for variants
-   `--mind` specifies the missing call frequencies threshold for samples

### Running PCAngsd

After running Plink, we can now use the output files to run PCAngsd. We will be ussing the `-admix` option to calculate population structure and generate our visual output.

```{bash}
$PCANGSD -plink $INDIR/plink_pd \
-admix \
-out pcangsd_pd
```

then add in pcangsd stuff into this project and elaborate on graph creation