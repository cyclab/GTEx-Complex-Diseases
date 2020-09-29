# GTEx-CVD

## Introduction
Cerebrovascular disease (CVD) remains one of the global leading causes of disability and mortality. The previous studies had identified various genetic loci associated with stroke. However, genetic variability that contributes to susceptibility to these diseases and the mechanism underlying CVD largely remain to be explored. Here, we aimed to investigate the effects of having CVD medical history on the molecular signature of human tissues using GTEx RNA-seq data.

## Data Exploration
- Comparison of the sample numbers between v6 and v8 releases: [`comp.v6.v8.Rmd`](exploration/comp.v6.v8.Rmd)
- Information about subjects and samples: [`cohortDemography.Rmd`](exploration/cohortDemography.Rmd)
- Principal Coordinates Analysis (PCoA) of tissues: [`PCoA.Rmd`](exploration/PCoA.Rmd) 
	- PCoA is used to determine which tissues can be merged into a group based on similarities, but then we determined _not_ to merge tissues
- Comparison of tissue-aware normalization methods: [`normalization.Rmd`](exploration/normalization.Rmd)
	- We decided to use tissue-aware **quantile normalization**

## RNA-seq Analysis
### Preprocessing
- `ExpressionSet` object generation: [`expressionSet.Rmd`](analysis/expressionSet.Rmd)
	- To gather the sample and subject data into one R object
- Filtering: [`filter.merge.Rmd`](analysis/filter.merge.Rmd)
	- Subjects were selected by the criteria in the script
	- Tissues with very few sampels were removed
	- Genes were filtered in a tissue-aware manner, also Y genes were eliminated

### Differential Expression Analysis
- Differential expression analysis using limma-voom: [`limma.voom.Rmd`](analysis/limma.voom.Rmd)
	- Linear mixed model: `Y ~ Sex + Ischemic time + Age + Batch + Hardy + MHCVD`

### Functional Enrichment Analysis
- Pre-ranked gene set enrichment analysis using GSEA: [`run.gsea.Rmd`](analysis/run.gsea.Rmd)
	- Genes were ranked by absolute _t_-statistics from limma results
	- `gmt` files were processed from annotation files of various databases


## Plots
- Plots for differentially expressed genes: [`deg.plot.Rmd`](plots/deg.plot.Rmd)
- Plots for enriched pathways: [`pathway.plot.Rmd`](plots/pathway.plot.Rmd)

## Preprint
__Analysis of multi-tissue transcriptomes reveals candidate genes and pathways influenced by cerebrovascular diseases__

bioRxiv, 2019, doi: https://doi.org/10.1101/806893


## Notes
Warnings function `lmFit` in limma: if any term in the linear model only has one sample, then there will be a warning: `Warning: Partial NA coefficients for n probe(s)`

