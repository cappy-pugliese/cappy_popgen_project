# Final Project

\<-- [See Part 1](Part1_Short_assign2.md)

## Part 2: Finishing the Project

------------------------------------------------------------------------

## Rerunning PCAngsd

I ran PCAngsd again, this time:

1.  only using Pd samples and
2.  only using North American Pd samples

To do this, I had to backtrack to the original vcf and exclude certain samples. I did this using:

`bcftools view -S <sample_file.txt>`

I then filtered it out a bit further this time around before using plink with bcftools. I had been using bcftools version 1.20, but this version does not seem to allow me to specify both `QUAL>20` and `MAF>0.05` at the same time. So I chose to use bcftools version 1.9, instead, since that was the second most recent version on the cluster.

```{bash}
bcftools view -S $SAMPLES \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $OUTDIR/$OUTNAME \
$VCF
```

Full script can be found [here](/code/scripts/03_bcfview.sh)

Afterwards, I reran Plink on the 2 new vcfs. This time around I used **Plink 2.0** instead of version 1.90.beta.4.4, because I was able to download the newer version of the software onto the cluster. Then I reran PCAngsd for both and processed them through R to make graphs (using similar code as before). These new R scripts can be found in the [R_code](/code/R_code/) folder.

The only major difference that was made was adjusting the population for loop to add padding to numbers less than two digits since the k's are larger now. I mainly did this so they would properly appear numerically later on in the graphs.

```{r}
pops <- c()
for (n in 1:k) {
    pops <- c(pops, paste0("pop", sprintf("%02d", n)))
}
## changed paste0("pop", n)
## to ---> paste0("pop", sprintf("%02d", n))
```

------------------------------------------------------------------------

## Results

### Only Pd Samples

![](figures/02_only-pd-samples/25_12-10_only-pd_by-continent.png)

Some things to note about this graph:

-   PCAngsd output the maximum k value, so it's possible not all of these subpopulations are actually subpopulations

    -   A lot of the North American samples have both populations 03, 05, 14, and 15

-   There are 4 samples from North America that look identical: Pd_36, 37, 39, and 45

    -   These individuals are all from New York from 2009, and are all cultures of the original Feb 2008 Williams Hotel 20631-21 type strain, which explains why they look identical

    -   The actual sample they appear to be based off of (Pd_28) does not seem to share the same admixture as them for some reason

-   Asside from these odd cultured strains, none of the North American samples appear to share the same population structure as the Asian samples (mostly pop04), but do share some similarities with the European samples, supporting the European Origin theory

    -   Subpopulations 03 and 11 are present in some European samples and most American samples

### Only North American Pd Samples

![](figures/03_only-n-american-pd-samples/25_12-09_n-amer-pd_by-country.png)

------------------------------------------------------------------------

## Discussion

------------------------------------------------------------------------

## Broader Analysis