#!/bin/bash

# For GSEA pre-ranked program
# Set up file paths
HOME=/home/ubuntu/hdd/gsea
GMT=${HOME}/gmt
RNK=${HOME}/rnk
OUTPUT=${HOME}/results

JarFile=${HOME}/gsea-3.0.jar
#GMT:
#c5.bp.v6.2.symbols.gmt
#msigdb.v6.1.symbols.gmt
#c5.all.v6.2.symbols.gmt
#DO.gmt #DO
#hpo.gmt
#costumed.gmt # GWAS + drugbank

## Outer loop for different gmt files; Inner loop for different tissues
while read g; do
  GmtFile=${GMT}/costumed.gmt
  mkdir ${OUTPUT}/${g}
  while read t; do
    RnkFile=${RNK}/"${t}".rnk
    OutFile=${OUTPUT}/${g}
    java -cp ${JarFile} -Xmx8192m xtools.gsea.GseaPreranked -gmx ${GmtFile} -rnk ${RnkFile} -out ${OutFile} -norm meandiv -nperm 1000 -scoring_scheme weighted
    echo Finish "${t}"!
  done < tissue.names.txt
  echo Finish all ${g}!!

done < gmt.list

echo Finish allll

# Run this script: ./run.prerank.sh > gsea.prerank.log
