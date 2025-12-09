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

![](figures/02_only-pd-samples/25_12-09_only-pd_by-continent.png)

### Only North American Pd Samples

![](figures/03_only-n-american-pd-samples/25_12-09_n-amer-pd_by-country.png)

------------------------------------------------------------------------

## Discussion

------------------------------------------------------------------------

## Broader Analysis