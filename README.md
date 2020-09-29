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
- `ExpressionSet` object generation: [`expressionSet.Rmd`](DEanalysis/expressionSet.Rmd)
	- To gather the sample and subject data into one R object
- Filtering: [`filter.merge.Rmd`](DEanalysis/filter.merge.Rmd)
	- Subjects were selected by the criteria in the script
	- Tissues with very few sampels were removed
	- Genes were filtered in a tissue-aware manner, also Y genes were eliminated

### Differential Expression Analysis
- Differential expression analysis using limma-voom: [`limma.voom.Rmd`](DEanalysis/limma.voom.Rmd)
	- Linear mixed model: `Y ~ Sex + Ischemic time + Age + Batch + Hardy + MHCVD`

## Functional Enrichment Analysis
- Pre-ranked gene set enrichment analysis using GSEA: [`run.prerankedGSEA.sh`](gsea/run.prerankedGSEA.sh)
	- Genes were ranked by absolute _t_-statistics from limma results
	- `gmt` files were processed from annotation files of various databases

## Transcriptome-Wide Association Study
Gene expression variation was inferred from several public GWAS summary statistics using [S-PrediXcan](https://github.com/hakyimlab/MetaXcan) software for tissues with expression differences between CVD & non-CVD cohorts. Genes that have significant associations were compared to the differentially expressed genes from limma-voom. The code sees [here](twas/).

## Plots
- Plots for differentially expressed genes: [`deg.plot.Rmd`](plots/deg.plot.Rmd)
- Plots for enriched pathways: [`pathway.plot.Rmd`](plots/pathway.plot.Rmd)

## Notes
Warnings function `lmFit` in limma: if any term in the linear model only has one sample, then there will be a warning: `Warning: Partial NA coefficients for n probe(s)`

## Preprint
__Analysis of multi-tissue transcriptomes reveals candidate genes and pathways influenced by cerebrovascular diseases__

bioRxiv, 2019, doi: https://doi.org/10.1101/806893

