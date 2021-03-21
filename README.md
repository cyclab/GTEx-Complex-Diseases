# GTEx-Complex-Diseases

## Introduction
Although lots of technologies and strategies can be used to identify genetic factors of human complex diseases, results from these studies are still hard to decipher since complex diseases are "complex" and multifactorial. Inflammation has recently been associated with many complex diseases and may cause long-term damage to the human body. Here we examined whether the history of complex disease systematically altered human tissue transcriptomes and whether inflammation is enriched in identified molecular signatures, using postmortem samples from the Genotype-Tissue Expression (GTEx) project. We compared expression profiles between subjects with and without the medical history of cerebrovascular disease (CVD) or major depression (MD), more details see our manuscript.

## Data Exploration
- Comparison of the sample numbers between v6 and v8 releases: [`comp.v6.v8.Rmd`](exploration/comp.v6.v8.Rmd)
- Information about subjects and samples: 
	- CVD: [`cohortDemography.Rmd`](exploration/cohortDemography.Rmd)
	- MD: [`dprssn.cohort.Rmd`](exploration/dprssn.cohort.Rmd), [`MHDPRSSN.preprocess.Rmd`](exploration/MHDPRSSN.preprocess.Rmd)
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
- Differential expression analysis using limma-voom: [`limma.voom.Rmd`](DEanalysis/limma.voom.Rmd), [`dprssn.de.Rmd`](DEanalysis/dprssn.de.Rmd)
	- Linear mixed model: `Y ~ Sex + Ischemic time + Age + Batch + Hardy + MHCVD/MHDPRSSN`

## Functional Enrichment Analysis
- Pre-ranked gene set enrichment analysis using GSEA: [`run.prerankedGSEA.sh`](gsea/run.prerankedGSEA.sh)
	- Genes were ranked by absolute _t_-statistics from limma results
	- `gmt` files were processed from annotation files of various databases

## Transcriptome-Wide Association Study
Gene expression variation was inferred from several public GWAS summary statistics using [S-PrediXcan](https://github.com/hakyimlab/MetaXcan) software for tissues with expression differences between CVD & non-CVD or MD & non-MD cohorts. Genes that have significant associations were compared to the differentially expressed genes from limma-voom. The code sees [here](twas/).

## Plots
- Plots for differentially expressed genes: [`cvd.deg.plot.Rmd`](plots/cvd.deg.plot.Rmd), [`dprssn.deg.plot.Rmd`](plots/dprssn.deg.plot.Rmd)
- Plots for enriched pathways: [`pathway.plot.Rmd`](plots/pathway.plot.Rmd)

## Notes
Warnings function `lmFit` in limma: if any term in the linear model only has one sample, then there will be a warning: `Warning: Partial NA coefficients for n probe(s)`

## Preprint
Submitted, under review

