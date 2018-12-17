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
#customed.gmt # GWAS + drugbank

## Outer loop for different gmt files; Inner loop for different tissues
while read t; do
  mkdir ${OUTPUT}/${t}

  while read g; do
    GmtFile=${GMT}/${g}
    RnkFile=${RNK}/${t}.rnk

    mkdir ${OUTPUT}/${t}/${g}
    OutFile=${OUTPUT}/${t}/${g}
    java -cp ${JarFile} -Xmx8192m xtools.gsea.GseaPreranked -gmx ${GmtFile} -rnk ${RnkFile} -out ${OutFile} -norm meandiv -nperm 1000 -scoring_scheme weighted
    echo Finish ${g}!
  done < gmt.list

  echo Finish all ${t}!!
done < tissue.names.txt

echo Finish allllll

# Run this script: ./run.prerank.sh > gsea.prerank.log
