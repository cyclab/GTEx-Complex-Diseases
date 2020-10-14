#!/bin/bash

## script to run S-MulTiXcan

mainDir=/home/pclam/tools/twas
dataDir=/NAS_lab/helenlin/GWAS/megastroke
resDir=/home/pclam/tools/twas/results


for d in 1.AS 2.AIS 3.LAS 4.CES 5.SVS
#mkdir $resDir/multixcan/
do
  python $mainDir/MetaXcan/software/SMulTiXcan.py \
    --models_folder $mainDir/data/models/selected_elastic_net \
    --models_name_pattern "en_(.*).db" \
    --snp_covariance /NAS_lab/pclam/gwas/gtex.covar/gtex_v8_expression_elastic_net_snp_smultixcan_covariance.txt.gz \
    --metaxcan_folder $resDir/megastroke/$d \
    --metaxcan_filter "$d_en_(.*).csv" \
    --metaxcan_file_name_parse_pattern "(.*)_en_(.*).csv" \
    --gwas_file $dataDir/MEGASTROKE.$d.EUR.out \
    --snp_column MarkerName \
    --effect_allele_column Allele1 \
    --non_effect_allele_column Allele2 \
    --beta_column Effect \
    --pvalue_column P-value \
    --keep_non_rsid \
    --cutoff_condition_number 30 \
    --verbosity 7 \
    --throw \
    --MAX_M 100 \
    --output $resDir/multixcan/megastroke/$d.multixcan.txt
done


