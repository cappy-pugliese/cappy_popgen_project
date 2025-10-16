freq_GT = function(site,ploidy=1){
  clean_site = na.omit(site)
  total_sites = ploidy*length(site)
  p = sum(clean_site)/total_sites
  return(p)
}

sample_het = function(site){
  n = 2*length(site)
  p = freq_GT(site)
  h = n/(n-1)*2*p*(1-p)
  return(h)
}

# one large function:
process_GT = function(GT,samples){
  pops = sort(unique(samples$population))
#Get indices for each population
  idx_pops = lapply(pops,function(x) {
    which(colnames(GT) %in% samples$indivs[which(samples$population == x)])
  })
  #Name them to make retrieval easier.
  names(idx_pops) = pops
  #Check for NAs per site per pop
  obs_alleles = lapply(1:length(pops),function(x){
    apply(GT[,idx_pops[[x]]],1,function(x) length(!is.na(x)))
  })
  names(obs_alleles) = pops
  summary_list = list()
  summary_list[["obs alleles"]] = obs_alleles
  # Now, let's get allele frequencies        
  ps = lapply(1:length(pops),function(x) {
    apply(GT[,idx_pops[[x]]],1,freq_GT)
  })
  names(ps) = pops
  summary_list[["allele freqs"]] = ps
  # Heterozygosities
  hets = lapply(1:length(pops),function(x) {
    apply(GT[,idx_pops[[x]]],1,sample_het)
  })
  names(hets) = pops
  summary_list[["heterozygosities"]] = hets
  #All possible pairs of populations:
  pop_pairs = combn(pops,2)
  #Calculate fst for each
  fst =lapply(1:dim(pop_pairs)[2],function(x) {
    pop1 = pop_pairs[1,x]
    pop2 = pop_pairs[2,x]
    n1 = obs_alleles[[pop1]]
    n2 = obs_alleles[[pop2]]
    p1 = ps[[pop1]]
    p2 = ps[[pop2]]
  })
  # Add names to make comparisons clear
  names(fst) = sapply(1:dim(pop_pairs)[2],function(x) paste(pop_pairs[,x],collapse="-"))
  summary_list[["Fst"]] = fst
  
  # calculating r^2 value
  cor_mat = cor(GT, use = "pairwise.complete.obs")
  pops <- unique(samples$population)
  r2_means <- numeric(length(pops))
  names(r2_means) <- pops

  for (pop in pops) {
  # get individuals in this population
    inds <- samples$indivs[samples$population == pop]
  # subset correlation matrix for this population
    sub_mat <- cor_mat[inds, inds]
  # square the correlations to get r²
    r2_vals <- sub_mat[upper.tri(sub_mat)]^2
  # take the mean (ignoring NAs)
    r2_means[pop] <- mean(r2_vals, na.rm = TRUE)
  }
  summary_list[["r2_means"]] <- r2_means
  
  return(summary_list)
}