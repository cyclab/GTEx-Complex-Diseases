# GTEx-CVD

## Introduction
Cerebrovascular disease (CVD) remains one of the global leading causes of disability and mortality. The previous studies had identified various genetic loci associated with stroke. However, genetic variability that contributes to susceptibility to these diseases and the mechanism underlying CVD largely remain to be explored. Here, we aimed to investigate the effects of having CVD medical history on the molecular signature of human tissues using GTEx RNA-seq data.

## Pipeline

### 1. Preprocessing
- GTEx v6 data are normalized and clustered using [YARN](https://github.com/QuackenbushLab/yarn)
- Filter out sex-specific tissues, suboptimal samples, and unannotated subjects

### 2. Cohort Demography

- Investigate the cohort information for sex, age, tissue, race, etc.

### 3. Differential Expression Analysis

- Conduct linear mixed model:
  - Brain groups: `Y ~ Sex + Age + BMI + Hardy + Batch + MHCVD + PC1 + PC2 + PC3 + SMTSD + subject`
  - Others: `Y ~ Sex + Age + BMI + Hardy + Batch + MHCVD + PC1 + PC2 + PC3 `
- Weights are derived from voom
- Obtain DEGs with _`t`_, `adj.P.val`, etc.

### 4. Functional Enrichment Analysis
- Perform pre-ranked gene set enrichment analysis using GSEA v4.0.1
- `rnk` files are from limma reports
- `gmt` files are processed from annotation files of various databases

## Preprint

__Analysis of multi-tissue transcriptomes reveals candidate genes and pathways influenced by cerebrovascular diseases__

bioRxiv, 2019, doi: https://doi.org/10.1101/806893

## Updates

I'll update the results using GTEx v8 release.
