suppressPackageStartupMessages({
  library(doParallel)
  library(RColorBrewer)
  library(Biobase)
  library(metagenomeSeq)
  library(gplots)
  library(limma)
})
  
mypar <- function(a=1,b=1,brewer.n=8,brewer.name="Dark2",cex.lab=1,cex.main=1.2,cex.axis=1,mar=c(2.5,2.5,1.6,1.1),mgp=c(1.5,.5,0),...){
  require(RColorBrewer)
  par(mar=mar,mgp=mgp,cex.lab=cex.lab,cex.main=cex.main,cex.axis=cex.axis)
  par(mfrow=c(a,b),...)
  palette(brewer.pal(brewer.n,brewer.name))
}

#' Compute voom weights using customized log2 counts
#' Modified from: https://raw.githubusercontent.com/jhsiao999/Humanzee/916ee1b3e0e213839c17a99280211d68edaca161/R/voomWeightsCustomized.r
#' and of course the voom function
#'
#' @param log2counts counts on log2 scale 
#' @param design Experimental design of the data. Required to be an R 
#'                design.matrix object 
#' @param lib.size Library size.
#' @param is.cpm if the data is CPM normalized.
#' 
#' @export
#'
voomWeightsCustomized <- function(log2counts, design, lib.size = NULL, is.cpm = FALSE) {
  if (is.null(design)) {
    design <- model.matrix(~ 1 )
  }
  out<-list()
  
  if (is.cpm == TRUE) {
    fit <- lmFit(log2counts, design)
    xx <- fit$Amean + mean(log2(lib.size + 1)) - log2(1e+06)
    yy <- sqrt(fit$sigma)
    l <- lowess(xx, yy, f = .5)
    f <- approxfun(l, rule = 2)
    fitted.values <- fit$coef %*% t(fit$design)
    fitted.cpm <- 2^fitted.values
    fitted.count <- 1e-06 * t(t(fitted.cpm) * (lib.size + 1))
    fitted.logcount <- log2(fitted.count)
    w <- 1/f(fitted.logcount)^4
    dim(w) <- dim(fitted.logcount)
  }
  
  if (is.cpm == FALSE) {
    fit <- lmFit(log2counts, design)
    xx <- fit$Amean 
    yy <- sqrt(fit$sigma)
    l <- lowess(xx, yy, f = .5)
    f <- approxfun(l, rule = 2)
    fitted.values <- fit$coef %*% t(fit$design)
    fitted.logcount <- log2(fitted.values)
    w <- 1/f(fitted.logcount)^4
    dim(w) <- dim(fitted.logcount)
  }
  out$E = log2counts
  out$weights = w
  out$design = design
  new("EList",out)
}