#!/bin/bash
# For GSEA pre-ranked program
# Set up file paths
HOME=/home/pclam/cvd/v8/gsea
GMTDIR=${HOME}/gmt/names
RNK=${HOME}/rnk
OUTPUT=${HOME}/results/new
PG=${HOME}/GSEA_Linux_4.0.1


# Outer loop for different tissues
# Inner loop for different gmt files
while read t; do
  echo running ${t}...
  mkdir ${OUTPUT}/${t}
  RnkFile=${RNK}/${t}.rnk

  for g in "do" hpo hallmark pos curated motif cancer go onco immuno
  do
    mkdir ${OUTPUT}/${t}/${g}
    OutFile=${OUTPUT}/${t}/${g}

    ${PG}/gsea-cli.sh GSEAPreranked -gmx ${GMTDIR}/${g}.txt -rnk ${RnkFile} -out ${OutFile} -norm meandiv -nperm 1000 -scoring_scheme weighted -rpt_label my_analysis -create_svgs false -make_sets true -plot_top_x 20 -rnd_seed timestamp -zip_report false
    #java -cp ${JarFile} -Xmx8192m xtools.gsea.GseaPreranked -gmx ${GmtFile} -rnk ${RnkFile} -out ${OutFile} -norm meandiv -nperm 1000 -scoring_scheme weighted
  echo ----Finish ${g}!----
  done
done < tissue.list

echo Finish all!

# Run this script: ./run.prerank.sh > gsea.prerank.log
