# Differential expression analysis


| Scripts         |Step |
|-----------------|-----|
|filter.Rmd       |1    |
|limma.Rmd        |2    |

### Main steps

#### 1. Filt subjects and samples
- Keep subjects with `MHCVD = 0 or 1`
- Filter out subjects without genotype data from GTEx
- Remove samples without hardy scale
- Remove suboptimal samples
- Exclude samples from sex-specific tissues
 
#### 2. Conduct limma-voom on brain transcriptomes and other tissues
- Exploratary data analysis on MHCVD, gender, age, race and BMI
- Differential expression analysis on brain clusters and then other tissues

 

