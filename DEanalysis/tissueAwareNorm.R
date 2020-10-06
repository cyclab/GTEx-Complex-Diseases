## tissue-aware normalization, can return log2-transformed counts
## Chi-Lam Poon Dec 2019

tissue.aware.norm <- function(eset, group, method=c('TMM', 'RLE', 'UQ', 'DESeq', 'QN', 'qsmooth', 'none'), logOutput=TRUE) {
  suppressPackageStartupMessages({
    library(edgeR)
    library(doParallel)
    library(preprocessCore)
    library(DESeq2)
    library(qsmooth)
  })
  
  cl <- makeCluster(4)
  registerDoParallel(cl)
  if (length(group) == 1) tissues <- factor(pData(eset)[, group])
  
  # function to retrieve normalized counts from dge list
  getDGEcnts <- function (dge) {
    dge <- estimateCommonDisp(dge)
    dge <- estimateTagwiseDisp(dge)
    norm.cnts <- t(t(dge$pseudo.counts)*(dge$samples$norm.factors))
    norm.cnts
  }
  
  if (method == 'DESeq') {
    # counts divided by median ratio of gene counts relative to geometric mean per gene
    normalizedMatrix <- foreach(tissue = unique(tissues), .packages = c("Biobase", "edgeR", "DESeq2"), .export = c("getDGEcnts"), .combine = cbind) %dopar% {
      cnts <- exprs(eset[, which(pData(eset)[, group] %in% tissue)])
      dds <- DESeqDataSetFromMatrix(countData = cnts, colData = pData(eset[, which(pData(eset)[, group] %in% tissue)]), design = ~ 1)
      dds <- estimateSizeFactors(dds)
      #cpm <- fpm(dds, robust = T) #a robust method using specific library sizes
      norm.cnts <- counts(dds, normalized=T)
      norm.cnts
    }
  } else if (method == 'QN') {
    normalizedMatrix <- foreach(tissue = unique(tissues), .packages = c("Biobase", "edgeR", "DESeq2", "preprocessCore"), .export = c("getDGEcnts"), .combine = cbind) %dopar% {
      cnts <- exprs(eset[, which(pData(eset)[, group] %in% tissue)])
      norm.cnts <- normalize.quantiles(cnts, copy=F)
      norm.cnts
    }
  } else if (method == 'qsmooth') {
    counts <- exprs(eset)
    qs <- qsmooth(counts, group_factor = tissues)
    normalizedMatrix <- qsmoothData(qs)
  } else {
    # for 'TMM', 'RLE', 'UQ' & 'none'
    normalizedMatrix <- foreach(tissue = unique(tissues), .packages = c("Biobase", "edgeR", "DESeq2"), .export = c("getDGEcnts"), .combine = cbind) %dopar% {
      cnts <- exprs(eset[, which(pData(eset)[, group] %in% tissue)])
      dge <- DGEList(cnts)
      dge <- calcNormFactors(dge, method = method)
      norm.cnts <- getDGEcnts(dge)
      norm.cnts
    }
  }
  
  if (logOutput) {
    normalizedMatrix <- log2(normalizedMatrix + 1)
  }
  normalizedMatrix <- normalizedMatrix[, match(rownames(pData(eset)), colnames(normalizedMatrix))]
  normalizedMatrix
}

